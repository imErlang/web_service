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

  match "/search" do
    body = Admin.Router.Search.search(conn)
    send_resp(conn, 200, body)
  end

  match "/sharemsg" do
    body = Admin.Router.Share.share_msg(conn)
    send_resp(conn, 200, body)
  end

  match "/im_http_service/newapi/nck/rsa/get_public_key.do" do
    result = %{
      rsa_pub_key_shortkey: Application.get_env(:admin, :rsa_pub_key_shortkey),
      rsa_pub_key_fullkey: Application.get_env(:admin, :rsa_pub_key_fullkey),
      pub_key_fullkey: Application.get_env(:admin, :pub_key_fullkey),
      pub_key_shortkey: Application.get_env(:admin, :pub_key_shortkey)
    }

    put_resp_header(conn, "content-type", "application/json")
    send_resp(conn, 200, Ejabberd.Util.success(result))
  end

  match "/file/v2/download/:key" do
    Admin.Router.File.download(conn, key)
  end

  match "/file/v2/download/perm/:key" do
    Admin.Router.File.download(conn, key)
  end

  match "file/v2/inspection/:type" do
    Admin.Router.File.inspect(conn, type)
  end

  match "/file/v2/upload/file" do
    Admin.Router.File.upload(conn)
  end

  match "/qfproxy/file/v2/emo/d/e/:package/:shortcut/:type" do
    Admin.Router.File.download_emo(conn, package, shortcut, type)
  end

  match "/im_http_service/newapi/domain/get_user_status.qunar" do
    Admin.Router.User.get_user_status(conn)
  end

  match "/im_http_service/newapi/getmsgs.qunar" do
    Admin.Router.History.get_msgs(conn)
  end

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
