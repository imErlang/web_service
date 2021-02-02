defmodule Admin.Router.Qtalk do
  @moduledoc """
  host router
  """
  use Plug.Router
  require Logger

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  match "/send_thirdmessage" do
    body = Ejabberd.Util.success()
    Helper.send_resp_json(conn, body)
  end

  match "/send_notify" do
    body = Ejabberd.Util.success()
    Helper.send_resp_json(conn, body)
  end

  match "/create_muc" do
    body = Ejabberd.Util.success()
    Helper.send_resp_json(conn, body)
  end

  match "/add_muc_user" do
    body = Ejabberd.Util.success()
    Helper.send_resp_json(conn, body)
  end

  match "/del_muc_user" do
    body = Ejabberd.Util.success()
    Helper.send_resp_json(conn, body)
  end

  match "/destroy_muc" do
    body = Ejabberd.Util.success()
    Helper.send_resp_json(conn, body)
  end

  match "/get_user_nick" do
    body = Ejabberd.Util.success()
    Helper.send_resp_json(conn, body)
  end

  match "/send_message" do
    body = Ejabberd.Util.success()
    Helper.send_resp_json(conn, body)
  end

  match "/muc_users" do
    body = Ejabberd.Util.success()
    Helper.send_resp_json(conn, body)
  end

  match "/auth_uk" do
    body = Ejabberd.Util.success()
    Helper.send_resp_json(conn, body)
  end

  match "/clear_staff" do
    body = Ejabberd.Util.success()
    Helper.send_resp_json(conn, body)
  end

  match "/send_notice_vcard" do
    body = Ejabberd.Util.success()
    Helper.send_resp_json(conn, body)
  end

  match "/management/change_muc_opts" do
    body = Ejabberd.Util.success()
    Helper.send_resp_json(conn, body)
  end

  match "/management/get_muc_opts" do
    body = Ejabberd.Util.success()
    Helper.send_resp_json(conn, body)
  end

  match "/management/del_muc_user" do
    body = Ejabberd.Util.success()
    Helper.send_resp_json(conn, body)
  end

  match "/add_host" do
    body = Ejabberd.Util.success()
    Helper.send_resp_json(conn, body)
  end
end
