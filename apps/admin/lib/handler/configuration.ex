defmodule Handler.Configuration do
  require Logger

  def get_config(conn) do
    username = Map.get(conn.body_params, "username", "")
    host = Map.get(conn.body_params, "host", "")
    version = Map.get(conn.body_params, "version", 0)
    result = get_configs(username, host, version)
    Ejabberd.Util.success(result)
  end

  def get_configs(username, host, version) do
    configs =
      Ejabberd.Configuration.select_increment_config(username, host, version)
      |> Enum.reduce(%{}, fn config, acc ->
        Logger.debug("config #{inspect(config)}")

        case Map.get(acc, config.configkey, nil) do
          nil ->
            Map.put(acc, config.configkey, transfer_config(config))

          old_config ->
            Map.put(acc, config.configkey, %{
              old_config
              | infos: [transfer_subconfig(config) | old_config.infos]
            })
        end
      end)
      |> Map.values()

    Logger.debug("get configs #{inspect(configs)}")
    max_version = Ejabberd.Configuration.select_max_version(username, host)
    %{version: max_version, clientConfigInfos: configs}
  end

  defp transfer_config(config) do
    %{
      key: config.configkey,
      infos: [transfer_subconfig(config)]
    }
  end

  defp transfer_subconfig(config) do
    %{
      subkey: config.subkey,
      configinfo: config.configinfo,
      isdel: config.isdel
    }
  end

  def set_configuration(conn) do
    config = %{
      username: Map.get(conn.body_params, "username", ""),
      host: Map.get(conn.body_params, "host", ""),
      key: Map.get(conn.body_params, "key", ""),
      subkey: Map.get(conn.body_params, "subkey", ""),
      batchProcess:
        Map.get(conn.body_params, "batchProcess", [])
        |> Enum.map(fn c ->
          %{
            key: Map.get(c, "key", ""),
            subkey: Map.get(c, "subkey", ""),
            value: Map.get(c, "value", "")
          }
        end),
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
    Logger.debug("get max version: #{max_version}")

    case config.batchProcess == [] do
      true ->
        set_config(set_max_version(config, max_version))

      false ->
        Enum.each(config.batchProcess, fn cf ->
          changes = Map.merge(config, set_max_version(cf, max_version))
          Logger.debug("set config changes: #{inspect(changes)}")
          set_config(changes)
        end)
    end

    result = get_configs(config.username, config.host, config.version)
    Logger.debug("set client config result: #{inspect(result)}")
    Ejabberd.Util.success(result)
  end

  def set_max_version(config, max_version) do
    Map.update(config, :version, max_version + 1, fn _ -> max_version + 1 end)
  end

  defp set_config(changes) do
    config =
      Ejabberd.Configuration.get_config(
        changes.username,
        changes.host,
        changes.key,
        changes.subkey
      )

    Logger.debug("set config #{inspect(changes)}, oldconfig: #{inspect(config)}")
    set_config(changes, config)
  end

  defp set_config(%{type: 1} = changes, nil) do
    Ejabberd.Configuration.insert(changes)
    true
  end

  defp set_config(%{type: 1} = changes, config) do
    Ejabberd.Configuration.update(config, %{
      configinfo: changes.value,
      version: changes.version,
      operate_plat: changes.operate_plat,
      isdel: 0
    })

    true
  end

  defp set_config(%{type: 2}, nil) do
    {false, "non-exist"}
  end

  defp set_config(%{type: 2} = changes, config) do
    Logger.debug("delete client config: #{inspect(config)}")

    Ejabberd.Configuration.update(config, %{
      isdel: 1,
      version: changes.version
    })
  end
end
