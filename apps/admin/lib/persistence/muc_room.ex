defmodule Persistence.MucRoom do
  use Ecto.Schema

  import Ecto.Query

  require Logger

  @primary_key false
  schema "muc_room" do
    field(:name, :string, default: "")
    field(:host, :string, default: "")
    field(:opts, :string, default: "")
    field(:created_at, :utc_datetime)
  end

  def get_muc(muc_name) do
    Persistence.MucRoom
    |> where([muc], muc.name == ^muc_name)
    |> Ejabberd.Repo.one()
  end
end
