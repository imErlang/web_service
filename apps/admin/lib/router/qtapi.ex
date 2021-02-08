defmodule Admin.Router.Qtapi do
  @moduledoc """
  host router
  """
  use Plug.Router
  require Logger
  import Helper

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  match "/gethistory.qunar" do
    body = Handler.History.get_history(conn)
    send_resp_json(conn, body)
  end

  match "/getmsgs.qunar" do
    body = Handler.History.get_msgs(conn)
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

  match "/nck/rsa/get_public_key.do" do
    result = %{
      rsa_pub_key_shortkey: Application.get_env(:admin, :rsa_pub_key_shortkey),
      rsa_pub_key_fullkey: Application.get_env(:admin, :rsa_pub_key_fullkey),
      pub_key_fullkey: Application.get_env(:admin, :pub_key_fullkey),
      pub_key_shortkey: Application.get_env(:admin, :pub_key_shortkey)
    }

    send_resp_json(conn, Ejabberd.Util.success(result))
  end
end
