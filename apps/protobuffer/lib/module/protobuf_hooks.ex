defmodule Protobuffer.Hooks do
  @behaviour :gen_mod

  require Logger

  @impl :gen_mod
  def start(host, opts) do
    Logger.debug("protobuf module start #{inspect(host)}, #{inspect(opts)}")
    :ejabberd_hooks.add(:set_presence_hook, host, Protobuffer.Hooks,
		  :on_presence_update, 50)
    :ok
  end

  @impl :gen_mod
  def stop(host) do
    Logger.debug("protobuf module stop #{inspect(host)}")
    :ejabberd_hooks.delete(:set_presence_hook, host, Protobuffer.Hooks,
		  :on_presence_update, 50)
    :ok
  end

  @impl :gen_mod
  def depends(_host, _opts) do
    []
  end

  def on_presence_update(user, server, resource, presence) do
    Logger.debug("on presence update #{inspect(user)}, #{inspect(server)}, #{inspect(resource)}, #{inspect(presence)}")
    login_presence = Mod.Protobuf.Handler.send_login_presence(user, server)
    user_jid = :jid.make(user, server, resource)
    :ejabberd_router.route(user_jid, user_jid, login_presence)
    :ok
  end

  @impl :gen_mod
  def reload(host, newopts, oldopts) do
    Logger.debug("protobuf module reload #{inspect(host)}, #{inspect(newopts)}, #{inspect(oldopts)}")
    :ok
  end

  @impl :gen_mod
  def mod_opt_type(_) do
    true
  end

  @impl :gen_mod
  def mod_options(host) do
    Logger.debug("protobuf module mod_options #{inspect(host)}")
    []
  end

  @impl :gen_mod
  def mod_doc() do
    Logger.debug("protobuf module mod_doc")
    %{desc: "protobuf module"}
  end
end
