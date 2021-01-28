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

  match "/search" do
    body = Handler.Search.search(conn)
    send_resp_json(conn, body)
  end

  match "/sharemsg" do
    body = Handler.Share.share_msg(conn)
    send_resp_json(conn, body)
  end

  match "/im_http_service/newapi/muc/get_muc_vcard.qunar" do
    body = Handler.Muc.get_muc_vcard(conn)
    send_resp_json(conn, body)
  end

  match "/im_http_service/newapi/muc/set_muc_vcard.qunar" do
    body = Handler.Muc.set_muc_vcard(conn)
    send_resp_json(conn, body)
  end

  match "/im_http_service/newapi/getmucmsgs.qunar" do
    body = Handler.History.get_muc_msgs(conn)
    send_resp_json(conn, body)
  end

  match "/im_http_service/newapi/configuration/setclientconfig.qunar" do
    body = Handler.Configuration.set_configuration(conn)
    send_resp_json(conn, body)
  end

  match "/im_http_service/newapi/configuration/getincreclientconfig.qunar" do
    body = Handler.Configuration.get_config(conn)
    send_resp_json(conn, body)
  end

  match "/im_http_service/newapi/nck/rsa/get_public_key.do" do
    result = %{
      rsa_pub_key_shortkey: Application.get_env(:admin, :rsa_pub_key_shortkey),
      rsa_pub_key_fullkey: Application.get_env(:admin, :rsa_pub_key_fullkey),
      pub_key_fullkey: Application.get_env(:admin, :pub_key_fullkey),
      pub_key_shortkey: Application.get_env(:admin, :pub_key_shortkey)
    }

    send_resp_json(conn, Ejabberd.Util.success(result))
  end

  match "/qfproxy/file/v2/download/:key" do
    Handler.File.download(conn, key)
  end

  match "/qfproxy/file/v2/download/perm/:key" do
    Handler.File.download(conn, key)
  end

  match "/qfproxy/file/v2/inspection/:type" do
    body = Handler.File.inspect(conn, type)
    send_resp_json(conn, body)
  end

  match "/qfproxy/file/v2/upload/file" do
    body = Handler.File.upload(conn)
    send_resp_json(conn, body)
  end

  match "/qfproxy/file/v2/emo/d/e/:package/:shortcut/:type" do
    Handler.File.download_emo(conn, package, shortcut, type)
  end

  match "/im_http_service/newapi/domain/get_user_status.qunar" do
    body = Handler.User.get_user_status(conn)
    send_resp_json(conn, body)
  end

  match "/im_http_service/newapi/getmsgs.qunar" do
    body = Handler.History.get_msgs(conn)
    send_resp_json(conn, body)
  end

  match "/im_http_service/newapi/update/getUpdateUsers.qunar" do
    body = Handler.User.get_update_users(conn)
    send_resp_json(conn, body)
  end

  match "/im_http_service/newapi/muc/get_increment_mucs.qunar" do
    body = Handler.Muc.get_increment_mucs(conn)
    send_resp_json(conn, body)
  end

  match "/im_http_service/newapi/gethistory.qunar" do
    body = Handler.History.get_history(conn)
    send_resp_json(conn, body)
  end

  # TODO
  match "/im_http_service/newapi/getmuchistory.qunar" do
    body = Ejabberd.Util.success([])
    send_resp_json(conn, body)
  end

  # TODO
  match "/im_http_service/newapi/getreadflag.qunar" do
    body = Ejabberd.Util.success([])
    send_resp_json(conn, body)
  end

  # TODO
  match "/im_http_service/newapi/get_muc_readmark1.qunar" do
    body = Ejabberd.Util.success([])
    send_resp_json(conn, body)
  end

  # TODO
  match "/im_http_service/newapi/get_system_history.qunar" do
    body = Ejabberd.Util.success([])
    send_resp_json(conn, body)
  end

  # TODO
  match "/im_http_service/newapi/medal/medalList.qunar" do
    body = Ejabberd.Util.success([])
    send_resp_json(conn, body)
  end

  # TODO
  match "/im_http_service/newapi/medal/userMedalList.qunar" do
    body = Ejabberd.Util.success([])
    send_resp_json(conn, body)
  end

  match "/im_http_service/newapi/domain/get_vcard_info.qunar" do
    body = Handler.User.get_vcard_info(conn)
    send_resp_json(conn, body)
  end

  forward("/host/", to: Admin.Router.HostInfo)
  forward("/user", to: Admin.Router.User)
  forward("/muc", to: Admin.Router.Muc)
  forward("/configuration", to: Admin.Router.Configuration)
  forward("/history", to: Admin.Router.History)
  forward("/dep", to: Admin.Router.Dep)

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

  defp send_resp_json(conn, body) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, body)
  end
end
