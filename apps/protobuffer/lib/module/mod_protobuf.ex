defmodule Mod.Protobuf do
  @behaviour :ejabberd_listener
  use GenServer
  require Logger
  require Record

  Record.defrecord(:socket_state,
    sockmod: :gen_tcp,
    socket: nil,
    max_stanza_size: nil,
    xml_stream: nil,
    shaper: :none,
    sock_peer_name: :none
  )

  def listeners() do
    [
      {{5202, {0, 0, 0, 0, 0, 0, 0, 0}, :tcp}, Mod.Protobuf,
       %{
         accept_interval: 0,
         access: :c2s,
         backlog: 5,
         cafile: :undefined,
         ciphers: :undefined,
         dhfile: :undefined,
         ip: {0, 0, 0, 0, 0, 0, 0, 0},
         max_fsm_queue: 10000,
         max_stanza_size: 262_144,
         protocol_options: :undefined,
         shaper: :c2s_shaper,
         starttls: false,
         starttls_required: true,
         supervisor: true,
         tls: true,
         tls_compression: false,
         tls_verify: false,
         transport: :tcp,
         use_proxy_protocol: false,
         zlib: false
       }}
    ]
    |> :ejabberd_listener.listeners_childspec()
    |> Enum.map(fn spec ->
      :supervisor.start_child(:ejabberd_listener, spec)
    end)
  end

  def stop_listener() do
    :ejabberd_listener.delete_listener({5202, {0, 0, 0, 0, 0, 0, 0, 0}, :tcp}, Mod.Protobuf)
  end

  @impl GenServer
  def init([sockmod, socket, opts]) do
    :xmpp_stream_in.init([Mod.Protobuf, {sockmod, socket}, opts])
  end

  @impl GenServer
  def handle_call(_, _from, state) do
    {:reply, :ok, state}
  end

  def peername(%{socket: {:gen_tcp, sock}}) do
    :inet.peername(sock)
  end

  def peername(%{socket: {sockmod, sock}}) do
    sockmod.peername(sock)
  end

  def starttls(socketdata, tlsopts) do
    sockmod = socket_state(socketdata, :sockmod)

    case sockmod do
      :gen_tcp ->
        socket = socket_state(socketdata, :socket)

        case :fast_tls.tcp_to_tls(socket, tlsopts) do
          {:ok, tlssocket} ->
            socketdata = socket_state(socketdata, socket: tlssocket, sockmod: :fast_tls)
            {:ok, socketdata}

          {:error, _} = err ->
            err
        end

      _ ->
        :erlang.error(:badarg)
    end
  end

  def init_state(%{socket: socket, mod: mod} = state, opts) do
    encrypted = :proplists.get_bool(:tls, opts)

    state = %{
      state
      | stream_direction: :in,
        stream_id: :xmpp_stream.new_id(),
        stream_state: :wait_for_stream,
        stream_header_sent: false,
        stream_restarted: false,
        stream_compressed: false,
        stream_encrypted: Encrypted,
        stream_version: {1, 0},
        stream_authenticated: false,
        codec_options: [:ignore_els],
        xmlns: "jabber:client",
        lang: "",
        user: "",
        server: "",
        resource: "",
        lserver: ""
    }

    init =
      try do
        mod.init([state, opts])
      catch
        _, :undef -> {:ok, state}
      end

    case init do
      {:ok, state2} when not encrypted ->
        state2

      {:ok, state2} when encrypted ->
        tlsopts = :ejabberd_c2s.tls_options(state2)

        case starttls(socket, tlsopts) do
          {:ok, tlssocket} ->
            %{state | socket: tlssocket}

          {:error, reason} ->
            process_stream_end({:tls, reason}, state2)
        end

      {:error, reason} ->
        process_stream_end(reason, state)

      :ignore ->
        {:stop, state}
    end
  end

  def process_stream_end(_, %{stream_state: :disconnected} = state) do
    state
  end

  def process_stream_end(reason, state) do
    Logger.debug("stream end reason: #{inspect(reason)}")
    GenServer.cast(self(), :release_socket)
    %{state | stream_timeout: :infinity, stream_state: :disconnected}
  end

  @impl GenServer
  def handle_cast(:accept, %{socket: socket, socket_mod: sockmod, socket_opts: opts} = state) do
    xmppsocket = :xmpp_socket.new(sockmod, socket, opts)
    socketmonitor = :xmpp_socket.monitor(xmppsocket)

    case :xmpp_socket.peername(xmppsocket) do
      {:ok, ip} ->
        state = state |> Map.delete(:socket_mod) |> Map.delete(:socket_opts)
        state = %{state | socket: xmppsocket, socket_monitor: socketmonitor, ip: ip}

        case init_state(state, opts) do
          {:stop, newstate} ->
            {:stop, :normal, newstate}

          newstate ->
            case newstate.stream_state == :disconnected do
              true ->
                {:noreply, newstate}

              false ->
                handle_info({:tcp, socket, ""}, newstate)
            end
        end

      {:error, _} ->
        {:stop, :normal, State}
    end
  end

  def handle_cast(msg, state) do
    :xmpp_stream_in.handle_cast(msg, state)
  end

  def recv_data({:fast_tls, sock}, data) do
    case :fast_tls.recv_data(sock, data) do
      {:ok, _} = ok -> ok
      {:error, e} when is_atom(e) -> {:error, {:socket, e}}
      {:error, e} when is_binary(e) -> {:error, {:tls, e}}
      {:error, _} = err -> err
    end
  end

  def recv_data(_, data) do
    {:ok, data}
  end

  def activate_socket({sockmod, sock} = socket) do
    res =
      case sockmod do
        :gen_tcp -> :inet.setopts(sock, active: :once)
        _ -> sockmod.setopts(sock, active: :once)
      end

    check_sock_result(socket, res)
  end

  def check_sock_result(_, :ok) do
    :ok
  end

  def check_sock_result({_, sock}, {:error, why}) do
    send(self(), {:tcp_closed, sock})
    Logger.debug("MQTT socket error: #{inspect(why)}")
  end

  def process_recv_data(data, %{left: true, last_data: last} = state) do
    parse_recv_data(last <> data, state)
  end

  def process_recv_data(data, state) do
    parse_recv_data(data, state)
  end

  def parse_recv_data(data, state) do
    case :ejabberd_protobuf.process_data_len(data) do
      false ->
        send(self(), {:tcp_closed, state.socket})
        state

      :continue ->
        activate_socket(state.socket)
        %{state | left: true, last_data: data}

      {len, rdata} ->
        rdatasize = byte_size(rdata)

        cond do
          len > rdatasize ->
            activate_socket(state.socket)
            %{state | left: true, last_data: data}

          len == rdatasize ->
            decode_pb_message(rdata, state)
            activate_socket(state.socket)
            %{state | left: false, last_data: ""}

          true ->
            <<rrdata::binary-size(len), r::binary>> = rdata
            decode_pb_message(rrdata, state)
            parse_recv_data(r, %{state | left: true, last_data: r})
        end
    end
  end

  def decode_pb_message(data, _state) do
    pb = MessageProtobuf.Decode.decode_pb_message(data)
    Logger.debug("data #{inspect(data, limit: :infinity)}, pb: #{inspect(pb, limit: :infinity)}")
    send(self(), {:"$gen_event", pb})
  end

  @impl GenServer
  def handle_info({:tcp, _tcpsock, tcpdata}, %{socket: socket} = state) do
    case recv_data(socket, tcpdata) do
      {:ok, data} ->
        process_recv_data(data, state)

      {:more, _codec1} ->
        {:noreply, state}

      {:error, why} ->
        Logger.error("recv data error #{inspect(why)}")
        {:stop, :normal, state}
    end
  end

  def handle_info({:tcp_closed, _sock}, state) do
    Logger.debug("MQTT connection reset by peer")
    {:stop, {:socket, :closed}, state}
  end

  def handle_info({:tcp_error, _sock, reason}, state) do
    Logger.debug("MQTT connection error: #{inspect(reason)}")
    {:stop, {:socket, reason}, state}
  end

  @impl :ejabberd_listener
  def start_link(sockmod, socket, opts) do
    GenServer.start_link(
      Mod.Protobuf,
      [{sockmod, socket}, opts],
      :ejabberd_config.fsm_limit_opts(opts)
    )
  end

  @impl :ejabberd_listener
  def start(sockmod, socket, opts) do
    GenServer.start(
      Mod.Protobuf,
      [{sockmod, socket}, opts],
      :ejabberd_config.fsm_limit_opts(opts)
    )
  end

  @impl :ejabberd_listener
  def accept(pid) do
    GenServer.cast(pid, :accept)
  end

  @impl :ejabberd_listener
  def listen_opt_type(_) do
    :econf.bool()
  end

  @impl :ejabberd_listener
  def listen_options() do
    [
      access: :all,
      shaper: :none,
      tls: false,
      tls_compression: false,
      starttls: false,
      starttls_required: false,
      tls_verify: false,
      zlib: false,
      max_stanza_size: :infinity,
      max_fsm_queue: 10000
    ]
  end

  def become_controller(pid, _) do
    accept(pid)
  end

  def socket_type() do
    :raw
  end
end
