defmodule Mod.Protobuf.C2s do
  @behaviour :xmpp_stream_in

  require Logger

  @impl :xmpp_stream_in
  def init(args) do
    :ejabberd_c2s.init(args)
  end

  @impl :xmpp_stream_in
  def handle_call(msg, from, state) do
    Logger.debug("#{inspect(msg)}, #{inspect(from)}, #{inspect(state)}")
    state
  end

  @impl :xmpp_stream_in
  def handle_cast(msg, state) do
    Logger.debug("#{inspect(msg)}, #{inspect(state)}")
    state
  end

  @impl :xmpp_stream_in
  def handle_info(msg, state) do
    Logger.debug("#{inspect(msg)}, #{inspect(state)}")
    state
  end

  @impl :xmpp_stream_in
  def terminate(reason, state) do
    Logger.debug("#{inspect(reason)}, #{inspect(state)}")
    state
  end

  @impl :xmpp_stream_in
  def code_change(_, state, _) do
    Logger.debug("#{inspect(state)}")
    state
  end

  @impl :xmpp_stream_in
  def handle_recv(el, pkt, %{lserver: lserver} = state) do
    :ejabberd_hooks.run_fold(:c2s_handle_recv, lserver, state, [el, pkt])
    state
  end

  @impl :xmpp_stream_in
  def handle_stream_start(streamstart, state) do
    Logger.debug("stream start : #{inspect(streamstart)}, state: #{inspect(state)}")
    state
  end

  @impl :xmpp_stream_in
  def handle_stream_end(reason, state) do
    Logger.debug("stream end : #{inspect(reason)}, state: #{inspect(state)}")
    state
  end

  @impl :xmpp_stream_in
  def sasl_mechanisms(mechs, state) do
    :ejabberd_c2s.sasl_mechanisms(mechs, state)
  end

  @impl :xmpp_stream_in
  def get_password_fun(mech, state) do
    :ejabberd_c2s.get_password_fun(mech, state)
  end

  @impl :xmpp_stream_in
  def check_password_fun(_mech, %{server: server}) do
    fn(u, _authzid, p) ->
      Handler.User.check_user_password(server, u, p)
    end
  end

  @impl :xmpp_stream_in
  def check_password_digest_fun(mech, state) do
    :ejabberd_c2s.check_password_digest_fun(mech, state)
  end

  @impl :xmpp_stream_in
  def handle_auth_success(_user, _mech, authmodule, state) do
    Map.put(state, :auth_module, authmodule)
  end

  @impl :xmpp_stream_in
  def bind(r, state) do
    :ejabberd_c2s.bind(r, state)
  end

  @impl :xmpp_stream_in
  def handle_authenticated_packet(pkt, state) do
    Logger.debug("handle packet: #{inspect(pkt)}, state: #{inspect(state)}")
    :ejabberd_c2s.handle_authenticated_packet(pkt, state)
  end
end
