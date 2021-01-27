defmodule Admin.Router.HostInfo do
  @moduledoc """
  host router
  """
  use Plug.Router
  require Logger

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  match "/add" do
    Ejabberd.HostInfo.create(conn.body_params)
    succ = Ejabberd.Util.success("")
    send_resp(conn, 200, succ)
  end

  match "/get" do
    body = Handler.HostInfo.get_host_info(conn)
    send_resp(conn, 200, body)
  end
end
