defmodule Ejabberd.UserRegisterMucs do

  use Ecto.Schema

  import Ecto.Query

  require Logger

  @primary_key false
  schema "user_register_mucs" do
    field(:username, :string, default: "")
    field(:muc_name, :string, default: "")
    field(:domain, :string, default: "")
    field(:host, :string, default: "")
    field(:created_at, :utc_datetime)
    field(:registed_flag, :integer, default: 1)
  end

  def get_increment_mucs(username, host, time) do
    Ejabberd.UserRegisterMucs
    |> where([m], m.created_at > ^time and m.username == ^username and m.host == ^host)
    |> Ejabberd.Repo.all()
  end
end
