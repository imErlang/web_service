defmodule Admin.Router.HttpService do
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

  match "/muc/get_muc_vcard.qunar" do
    body = Handler.Muc.get_muc_vcard(conn)
    send_resp_json(conn, body)
  end

  match "/muc/set_muc_vcard.qunar" do
    body = Handler.Muc.set_muc_vcard(conn)
    send_resp_json(conn, body)
  end

  match "/getmucmsgs.qunar" do
    body = Handler.History.get_muc_msgs(conn)
    send_resp_json(conn, body)
  end

  match "/configuration/setclientconfig.qunar" do
    body = Handler.Configuration.set_configuration(conn)
    send_resp_json(conn, body)
  end

  match "/configuration/getincreclientconfig.qunar" do
    body = Handler.Configuration.get_config(conn)
    send_resp_json(conn, body)
  end

  match "/nck/rsa/get_public_key.do" do
    result = %{
      rsa_pub_key_shortkey: Application.get_env(:admin, :rsa_pub_key_shortkey),
      rsa_pub_key_fullkey: Application.get_env(:admin, :rsa_pub_key_fullkey),
      pub_key_fullkey: Application.get_env(:admin, :pub_key_fullkey),
      pub_key_shortkey: Application.get_env(:admin, :pub_key_shortkey)
    }

    send_resp_json(conn, Ejabberd.Util.success(result))
  end

  match "/domain/get_user_status.qunar" do
    body = Handler.User.get_user_status(conn)
    send_resp_json(conn, body)
  end

  match "/getmsgs.qunar" do
    body = Handler.History.get_msgs(conn)
    send_resp_json(conn, body)
  end

  match "/update/getUpdateUsers.qunar" do
    body = Handler.User.get_update_users(conn)
    send_resp_json(conn, body)
  end

  match "/muc/get_increment_mucs.qunar" do
    body = Handler.Muc.get_increment_mucs(conn)
    send_resp_json(conn, body)
  end

  match "/muc/get_user_increment_muc_vcard.qunar" do
    body = Handler.Muc.get_user_increment_muc_vcard(conn)
    send_resp_json(conn, body)
  end

  match "/gethistory.qunar" do
    body = Handler.History.get_history(conn)
    send_resp_json(conn, body)
  end

  match "/getmuchistory.qunar" do
    body = Handler.History.get_offline_muc_history(conn)
    send_resp_json(conn, body)
  end

  match "/getreadflag.qunar" do
    body = Handler.History.get_read_flag(conn)
    send_resp_json(conn, body)
  end

  match "/get_muc_readmark1.qunar" do
    body = Handler.History.get_muc_readmark(conn)
    send_resp_json(conn, body)
  end

  # TODO
  match "/get_system_history.qunar" do
    body = Ejabberd.Util.success([])
    send_resp_json(conn, body)
  end

  match "/medal/medalList.qunar" do
    body = Ejabberd.Util.success([])
    send_resp_json(conn, body)
  end

  match "/medal/userMedalList.qunar" do
    body = Ejabberd.Util.success([])
    send_resp_json(conn, body)
  end

  # TODO
  match "/statics/pc_statics.qunar" do
    body = Ejabberd.Util.success([])
    send_resp_json(conn, body)
  end

  match "/domain/get_vcard_info.qunar" do
    body = Handler.User.get_vcard_info(conn)
    send_resp_json(conn, body)
  end
end
