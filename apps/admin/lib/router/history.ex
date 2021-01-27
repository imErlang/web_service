defmodule Admin.Router.History do
  @moduledoc """
  history router
  """
  use Plug.Router
  require Logger
  require SweetXml

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  match "/rbl" do
    body = Handler.History.get_rbl(conn)
    send_resp(conn, 200, body)
  end

  match "/msgs" do
    body = Handler.History.get_msgs(conn)
    send_resp(conn, 200, body)
  end

  match "/get" do
    body = Handler.History.get_history(conn)
    send_resp(conn, 200, body)
  end

  match "/getreadflag" do
    body = Ejabberd.Util.success([])
    send_resp(conn, 200, body)
  end

  match "/muc/get" do
    body = Ejabberd.Util.success([])
    send_resp(conn, 200, body)
  end

  match "/muc/readmark" do
    body = Ejabberd.Util.success([])
    send_resp(conn, 200, body)
  end

  match "/system/get" do
    body = Ejabberd.Util.success([])
    send_resp(conn, 200, body)
  end
end
