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
    get_muc_history(conn)
  end

  def get_history(conn) do
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