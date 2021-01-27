defmodule Admin.Router.User do
  @moduledoc """
    user router
  """
  use Plug.Router
  require Logger
  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  match "/status" do
    body = Handler.User.get_user_status(conn)
    send_resp(conn, 200, body)
  end

  match "/get_vcard_info" do
    body = Handler.User.get_vcard_info(conn)
    send_resp(conn, 200, body)
  end

  match "/add" do
    body = Handler.User.add(conn)
    send_resp(conn, 200, body)
  end

  match "/delete/user" do
    body = Handler.User.delete(conn)
    send_resp(conn, 200, body)
  end

  match "/getuserDetail" do
    body = Handler.User.get_user_detail(conn)
    send_resp(conn, 200, body)
  end
end
