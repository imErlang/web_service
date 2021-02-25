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
end
