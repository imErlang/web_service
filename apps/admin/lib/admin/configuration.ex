defmodule Admin.Router.Configuration do
  use Plug.Router
  require Logger
  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  match "/get" do
    succ = Ejabberd.Util.success("")
    send_resp(conn, 200, succ)
  end

  match "/set" do
    config = %{
      username: Map.get(conn.body_params, "username", ""),
      host: Map.get(conn.body_params, "host", ""),
      configkey: Map.get(conn.body_params, "key", ""),
      subkey: Map.get(conn.body_params, "subkey", ""),
      batchProcess: Map.get(conn.body_params, "batchProcess", ""),
      value: Map.get(conn.body_params, "value", ""),
      resource: Map.get(conn.body_params, "resource", ""),
      operate_plat: Map.get(conn.body_params, "operate_plat", ""),
      version: Map.get(conn.body_params, "version", 0),
      type: Map.get(conn.body_params, "type", 0)
    }

    Logger.debug(
      "config #{inspect(config)} username: #{config.username}, batchProcess: #{
        inspect(config.batchProcess)
      }"
    )

    max_version = Ejabberd.Configuration.select_max_version(config.username, config.host)

    case config.batchProcess == nil || config.batchProcess == [] do
      true ->
        set_config(set_max_version(config, max_version))

      false ->
        Enum.each(config.batchProcess, fn cf ->
          set_config(set_max_version(cf, max_version))
        end)
    end

    succ = Ejabberd.Util.success("")
    send_resp(conn, 200, succ)
  end

  defp set_max_version(config, max_version) do
    Map.update(config, :version, max_version + 1, fn _ -> max_version + 1 end)
  end

  defp set_config(config) do
    Logger.debug("set config #{inspect(config)}")
  end
end
