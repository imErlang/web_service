defmodule Ejabberd.HostInfo do
  use Ecto.Schema

  import Ecto.Query, only: [from: 2]
  import Ecto.Changeset

  require Logger

  schema "host_info" do
    field(:host, :string)
    field(:description, :string)
    field(:host_type, :integer)
    field(:host_qrcode, :string, default: "")
    field(:need_approve, :integer)
    field(:host_admin, :string)
    field(:create_time, :utc_datetime)
  end

  @fields ~w(host description host_type host_qrcode need_approve host_admin)a

  def changeset(data, params \\ %{}) do
    data |> cast(params, @fields)
  end

  def create(params) do
    cs = changeset(%Ejabberd.HostInfo{}, params)

    if cs.valid? do
      Ejabberd.Repo.insert(cs)
    else
      cs
    end
  end

  def get_host(id) do
    Ejabberd.HostInfo |> Ejabberd.Repo.get(id)
  end

  def get_host_info(host) do
    query = from(h in Ejabberd.HostInfo, where: h.host == ^host)

    result = Ejabberd.Repo.one(query)

    if result.host_qrcode == nil do
      %Ejabberd.HostInfo{result | host_qrcode: ""}
    else
      result
    end
  end
end
