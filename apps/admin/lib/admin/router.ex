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

  plug(JsonPlug)

  plug(:dispatch)

  match "/im_http_service/newapi/update/getUpdateUsers.qunar" do
    Admin.Router.User.get_update_users(conn)
  end

  match "/im_http_service/newapi/muc/get_increment_mucs.qunar" do
    Admin.Router.Muc.get_increment_mucs(conn)
  end

  match "/im_http_service/newapi/configuration/getincreclientconfig.qunar" do
    Admin.Router.Configuration.get_config(conn)
  end

  match "/im_http_service/newapi/gethistory.qunar" do
    Admin.Router.History.get_history(conn)
  end

  match "/im_http_service/newapi/getmuchistory.qunar" do
    Admin.Router.History.get_muc_history(conn)
  end

  match "/im_http_service/newapi/getreadflag.qunar" do
    Admin.Router.History.get_muc_history(conn)
  end

  match "/im_http_service/newapi/get_muc_readmark1.qunar" do
    Admin.Router.History.get_muc_history(conn)
  end

  match "/im_http_service/newapi/get_system_history.qunar" do
    Admin.Router.History.get_muc_history(conn)
  end

  match "/im_http_service/newapi/medal/medalList.qunar" do
    Admin.Router.History.get_muc_history(conn)
  end

  match "/im_http_service/newapi/medal/userMedalList.qunar" do
    Admin.Router.History.get_muc_history(conn)
  end

  match "/im_http_service/newapi/domain/get_vcard_info.qunar" do
    Admin.Router.User.get_vcard_info(conn)
  end

  forward("/host/", to: Admin.Router.HostInfo)
  forward("/user", to: Admin.Router.User)
  forward("/muc", to: Admin.Router.Muc)
  forward("/configuration", to: Admin.Router.Configuration)
  forward("/history", to: Admin.Router.History)

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
