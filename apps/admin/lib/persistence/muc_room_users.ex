defmodule Persistence.MucRoomUsers do
  use Ecto.Schema

  require Logger

  schema "muc_room_users" do
    field(:muc_name, :string, default: "")
    field(:username, :string, default: "")
    field(:host, :string, default: "")
    field(:subscribe_flag, :integer, default: 0)
    field(:date, :integer, default: 0)
    field(:login_date, :integer, default: 0)
    field(:domain, :string, default: "")
    field(:update_time, :utc_datetime)
  end
end
