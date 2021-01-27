defmodule Admin.Router.Dep do
  @moduledoc """
  host router
  """
  use Plug.Router
  require Logger

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  match "/add" do
    body = Handler.Dep.add(conn)
    send_resp(conn, 200, body)
  end

  match "/get" do
    body = Handler.Dep.get(conn)
    send_resp(conn, 200, body)
  end

  match "delete" do
    body = Handler.Dep.delete(conn)
    send_resp(conn, 200, body)
  end

  match "/update" do
    body = Handler.Dep.update(conn)
    send_resp(conn, 200, body)
  end
end
