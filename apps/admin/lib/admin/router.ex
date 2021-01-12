defmodule Admin.Router do
  @moduledoc """
  endpoint for admin http service
  """

  use Plug.Router
  use Plug.ErrorHandler

  require Logger

  plug(Plug.Logger)
  plug(:match)

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(:dispatch)

  forward("/host/", to: Admin.Router.HostInfo)
  forward("/startalk/management/dep", to: Admin.Router.Dep)
  forward("/startalk/management/base", to: Admin.Router.Base)
  forward("/user", to: Admin.Router.User)
  forward("/muc", to: Admin.Router.Muc)

  match "/startalk_nav" do
    Logger.debug("query #{inspect(conn.query_params)}")
    nav = Admin.Router.NavHandler.getNav("http", "192.168.18.128", "startalk.tech", 8080)
    succ = Ejabberd.Util.success(nav)
    send_resp(conn, 200, succ)
  end

  def handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    send_resp(conn, conn.status, "Something went wrong")
  end
end
