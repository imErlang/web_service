defmodule Admin.Router.History do
  @moduledoc """
  history router
  """
  use Plug.Router
  require Logger

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  match "/get" do
    get_history(conn)
  end

  def get_history(conn) do
    histories = Ejabberd.MsgHistory.get_history(conn.body_params)
    Logger.debug("histories: #{inspect(histories)}")
    histories |> Enum.map(fn history ->
      Logger.debug("history: #{history.m_body}")
      body = XmlToMap.naive_map(history.m_body)
      Logger.debug("body: #{inspect(body)}")

    end)
    succ = Ejabberd.Util.success([])
    send_resp(conn, 200, succ)
  end

  match "/getreadflag" do
    succ = Ejabberd.Util.success([])
    send_resp(conn, 200, succ)
  end

  match "/muc/get" do
    get_muc_history(conn)
  end

  def get_muc_history(conn) do
    succ = Ejabberd.Util.success([])
    send_resp(conn, 200, succ)
  end

  match "/muc/readmark" do
    succ = Ejabberd.Util.success([])
    send_resp(conn, 200, succ)
  end

  match "/system/get" do
    succ = Ejabberd.Util.success([])
    send_resp(conn, 200, succ)
  end
end
