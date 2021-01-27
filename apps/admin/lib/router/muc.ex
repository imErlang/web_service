defmodule Admin.Router.Muc do
  use Plug.Router
  require Logger
  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  match "/get_increment_mucs" do
    body = Handler.Muc.get_increment_mucs(conn)
    send_resp(conn, 200, body)
  end
end
