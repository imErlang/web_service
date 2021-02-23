defmodule Mod.Protobuf do
  @behaviour :ejabberd_listener

  @impl :ejabberd_listener
  def start_link(_sockmod, _socket, _state) do
    :ignore
  end

  @impl :ejabberd_listener
  def start(_sockmod, _socket, _state) do
    :ignore
  end

  @impl :ejabberd_listener
  def accept(pid) do
    pid
  end

  @impl :ejabberd_listener
  def listen_opt_type(_) do
    :econf.bool()
  end

  @impl :ejabberd_listener
  def listen_options() do
    []
  end

end
