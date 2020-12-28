defmodule Admin.Router.User do
  @moduledoc """
    user router
  """
  use Plug.Router
  require Logger
  plug Plug.Logger
  plug :match
  plug :dispatch

  match "/getUpdateUsers.qunar" do
    Logger.info("method #{inspect(conn.method)}, #{inspect(conn.body_params)}, #{inspect(conn.query_params)}")
    send_resp(conn, 200, "get increment users")
  end
end
