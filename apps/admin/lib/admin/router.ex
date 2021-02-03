defmodule Admin.Router do
  @moduledoc """
  endpoint for admin http service
  """

  use Plug.Router
  use Plug.ErrorHandler

  require Logger
  import Helper

  plug(Plug.Logger)
  plug(:match)

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(:dispatch)

  match "/py/search" do
    body = Handler.Search.search(conn)
    send_resp_json(conn, body)
  end

  match "/py/sharemsg" do
    body = Handler.Share.share_msg(conn)
    send_resp_json(conn, body)
  end

  forward("/host/", to: Admin.Router.HostInfo)
  forward("/user", to: Admin.Router.User)
  forward("/muc", to: Admin.Router.Muc)
  forward("/configuration", to: Admin.Router.Configuration)
  forward("/history", to: Admin.Router.History)
  forward("/dep", to: Admin.Router.Dep)
  forward("/qtalk", to: Admin.Router.Qtalk)
  forward("/im_http_service/newapi", to: Admin.Router.HttpService)
  forward("/im_http_service", to: Admin.Router.Qtapi)
  forward("/newapi", to: Admin.Router.HttpService)
  forward("/qfproxy/file", to: Admin.Router.File)
  forward("/file", to: Admin.Router.File)
  forward("/package/qtapi", to: Admin.Router.Qtapi)

  match "/startalk_nav" do
    Logger.debug("query #{inspect(conn.query_params)}")
    server_ip = Application.get_env(:admin, :server_ip, "127.0.0.1")
    port = Application.get_env(:admin, :server_port, 8080)
    nav = Handler.Nav.getNav("http", server_ip, "startalk.tech", port)
    {:ok, body} = Jason.encode(nav, escape: :html_safe)
    send_resp_json(conn, body)
  end

  def handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    send_resp(conn, conn.status, "Something went wrong")
  end
end
