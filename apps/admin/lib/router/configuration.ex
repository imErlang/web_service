defmodule Admin.Router.Configuration do
  use Plug.Router
  require Logger
  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  match "/get" do
    body = Handler.Configuration.get_config(conn)
    send_resp(conn, 200, body)
  end

  match "/set" do
    body = Handler.Configuration.set_configuration(conn)
    send_resp(conn, 200, body)
  end
end
