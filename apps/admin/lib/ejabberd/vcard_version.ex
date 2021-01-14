defmodule Ejabberd.VcardVersion do
  use Ecto.Schema

  require Logger

  import Ecto.Query, only: [where: 3]

  schema "vcard_version" do
    field(:username, :string)
    field(:version, :integer, default: 1)
    field(:url, :string, default: "/file/v2/download/8c9d42532be9316e2202ffef8fcfeba5.png")
    field(:uin, :string, default: "")
    field(:profile_version, :integer, default: 1)
    field(:mood, :string, default: "")
    field(:gender, :integer, default: 0)
    field(:host, :string, default: "")
  end

  def get_vcard_info(username, host) do
    Ejabberd.VcardVersion
    |> where([v], v.username == ^username and v.host == ^host)
    |> Ejabberd.Repo.one()
  end
end
