defmodule Mod.Protobuf do
  import Kernel, except: [send: 2]
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

  @impl GenServer
  def init([state, opts]) do
    :xmpp_stream_in.init([Mod.Protobuf.C2s, state, opts])
  end

  @impl GenServer
  def handle_call(_, _from, state) do
    {:reply, :ok, state}
  end

  def get_owner(_socket) do
    self()
  end

  def peername(socket) when is_port(socket) do
    :inet.peername(socket)
  end
  def peername(socket) do
    :fast_tls.peername(socket)
  end

  def send_xml(_socket, {:xmlstreamstart, _, _}) do
    :ok
  end
  def send_xml(socket, el) do
    Logger.debug("socket: #{inspect(socket)}, el: #{inspect(el)}")
    # :fast_tls.send(socket, el)
    data = MessageProtobuf.Encode.send_probuf_msg(%{}, el)
    Logger.debug("data: #{inspect(data)}")
  end

  def get_transport(_) do
    :tls
  end

  def setopts(socket, opts) do
    :fast_tls.setopts(socket, opts)
  end

  def starttls(socketdata, tlsopts) do
    Logger.debug("starttls: #{inspect(socketdata)}, tlsopts #{inspect(tlsopts)}")
    socket = socket_state(socketdata, :socket)
    case is_port(socket) do
      true ->
        case :fast_tls.tcp_to_tls(socket, tlsopts) do
          {:ok, tlssocket} ->
            socketdata = socket_state(socketdata, socket: tlssocket)
            Logger.debug("starttls new socketdata: #{inspect(socketdata)}")
            {:ok, socketdata}

          {:error, _} = err ->
            err
        end

      false ->
        :erlang.error(:badarg)
    end
  end

  def init_state(%{socket: socket, mod: mod} = state, opts) do
    Logger.debug("init state #{inspect(state)}, opts: #{inspect(opts)}")
    encrypted = :proplists.get_bool(:tls, opts)

    state =
      Map.merge(state, %{
        stream_direction: :in,
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
      })

    init =
      try do
        mod.init([state, opts])
      catch
        _, :undef -> {:ok, state}
      end

    Logger.debug("mod init #{inspect(init)}")

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

  def process_stream_ends(_, %{stream_state: :disconnected} = state) do
    state
  end

  def process_stream_end(reason, state) do
    Logger.debug("stream end reason: #{inspect(reason)}")
    GenServer.cast(self(), :release_socket)
    %{state | stream_timeout: :infinity, stream_state: :disconnected}
  end

  @impl GenServer
  def handle_cast(:accept, %{socket: socket, socket_mod: sockmod, socket_opts: opts} = state) do
    xmppsocket = :xmpp_socket.new(sockmod, socket, opts) |> socket_state(xml_stream: :undefined)
    Logger.debug("accept state: #{inspect(state, limit: :infinity)}, xmppsocket: #{inspect(xmppsocket, limit: :infinity)}")
    socketmonitor = :xmpp_socket.monitor(xmppsocket)

    case :xmpp_socket.peername(xmppsocket) do
      {:ok, ip} ->
        state =
          state
          |> Map.delete(:socket_mod)
          |> Map.delete(:socket_opts)
          |> Map.put(:socket, xmppsocket)
          |> Map.put(:socket_monitor, socketmonitor)
          |> Map.put(:ip, ip)

        case init_state(state, opts) do
          {:stop, newstate} ->
            {:stop, :normal, newstate}

          newstate ->
            case newstate.stream_state == :disconnected do
              true ->
                {:noreply, newstate}

              false ->
                Logger.debug("accept suc")
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

  def activate_socket(socket) do
    sockmod = socket_state(socket, :sockmod)
    sock = socket_state(socket, :socket)

    case sockmod do
      :gen_tcp -> :inet.setopts(sock, active: :once)
      _ -> sockmod.setopts(sock, active: :once)
    end
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
        Kernel.send(self(), {:tcp_closed, state.socket})
        state

      :continue ->
        activate_socket(state.socket)
        Map.merge(state, %{left: true, last_data: data})

      {len, rdata} ->
        rdatasize = byte_size(rdata)

        cond do
          len > rdatasize ->
            activate_socket(state.socket)
            Map.merge(state,%{ left: true, last_data: data})

          len == rdatasize ->
            decode_pb_message(rdata, state)
            activate_socket(state.socket)
            Map.merge(state, %{ left: false, last_data: ""})

          true ->
            <<rrdata::binary-size(len), r::binary>> = rdata
            decode_pb_message(rrdata, state)
            parse_recv_data(r, Map.merge(state,%{ left: true, last_data: r}))
        end
    end
  end

  def decode_pb_message(data, _state) do
    pb = MessageProtobuf.Decode.decode_pb_message(data)
    Logger.debug("data #{inspect(data, limit: :infinity)}, pb: #{inspect(pb, limit: :infinity)}")
    Kernel.send(self(), {:"$gen_event", pb})
  end

  @impl GenServer
  def handle_info({:tcp, _tcpsock, tcpdata}, %{socket: socket} = state) do
    Logger.debug("recv socket data: #{inspect(tcpdata, limit: :infinity)}")

    case recv_data(socket, tcpdata) do
      {:ok, data} ->
        {:noreply, process_recv_data(data, state)}

      {:more, _codec1} ->
        {:noreply, state}

      {:error, why} ->
        Logger.error("recv data error #{inspect(why)}")
        {:stop, :normal, state}
    end
  end

  def handle_info(msg, state) do
    Logger.debug("recv msg: #{inspect(msg)}")
    :xmpp_stream_in.handle_info(msg, state)
  end

  def start_link(_sockmod, socket, opts) do
    Logger.debug("protobu start ")

    GenServer.start_link(
      Mod.Protobuf,
      [{Mod.Protobuf, socket}, opts],
      :ejabberd_config.fsm_limit_opts(opts)
    )
  end

  def start(sockmod, socket, opts) do
    GenServer.start(
      Mod.Protobuf,
      [{sockmod, socket}, opts],
      :ejabberd_config.fsm_limit_opts(opts)
    )
  end

  def accept(pid) do
    Logger.debug("protobuf accept: #{inspect(pid)}")
    GenServer.cast(pid, :accept)
  end

  def become_controller(pid, _) do
    accept(pid)
  end

  def socket_type() do
    :raw
  end
end
