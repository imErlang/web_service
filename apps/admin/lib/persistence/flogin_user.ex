defmodule Ejabberd.Floginuser do
  use Ecto.Schema

  require Logger

  import Ecto.Query, only: [where: 3]

  schema "flogin_user" do
    field(:username, :string, default: "")
    field(:create_time, :utc_datetime)
  end

  def get_login_users(users) do
    Ejabberd.Floginuser
    |> where([flogin], flogin.username in ^users)
    |> Ejabberd.Repo.all()
  end
end
