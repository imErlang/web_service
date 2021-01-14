defmodule Ejabberd.Configuration do
  use Ecto.Schema

  import Ecto.Query

  require Logger

  schema "client_config_sync" do
    field(:username, :string, default: "")
    field(:host, :string, default: "")
    field(:configkey, :string, default: "")
    field(:subkey, :string, default: "")
    field(:configinfo, :string, default: "")
    field(:version, :integer, default: 1)
    field(:operate_plat, :string, default: "")
    field(:create_time, :utc_datetime)
    field(:update_time, :utc_datetime)
    field(:isdel, :integer, default: 0)
  end

  def select_increment_config(username, host, version) do
    Ejabberd.Configuration
    |> where(
      [config],
      config.username == ^username and config.host == ^host and config.version > ^version
    )
    |> order_by([config], config.update_time)
    |> Ejabberd.Repo.all()
  end

  def select_max_version(username, host) do
    max_version =
      Ejabberd.Configuration
      |> select([config], max(config.version))
      |> where([config], config.username == ^username and config.host == ^host)
      |> Ejabberd.Repo.one()

    if max_version != nil and max_version > 0, do: max_version, else: 0
  end

  def get_configs(username, host) do
    Ejabberd.Configuration
    |> where([config], config.username == ^username and config.host == ^host)
    |> Ejabberd.Repo.all()
  end

  def get_config(username, host, configkey, subkey) do
    Ejabberd.Configuration
    |> where(
      [config],
      config.username == ^username and config.host == ^host and config.configkey == ^configkey and
        config.subkey == ^subkey
    )
    |> Ejabberd.Repo.one()
  end

  def insert(config) do
    %Ejabberd.Configuration{
      username: config.username,
      host: config.host,
      configkey: config.key,
      subkey: config.subkey,
      configinfo: config.value,
      version: config.version,
      operate_plat: config.operate_plat
    }
    |> Ejabberd.Repo.insert()
  end

  def update(config, changes) do
    Ecto.Changeset.change(config, changes)
    |> Ejabberd.Repo.update()
  end
end
