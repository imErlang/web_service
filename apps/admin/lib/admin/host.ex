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
    host = Map.get(conn.body_params, "host")

    case Ejabberd.HostInfo.get_host_info(host) do
      nil ->
        errRet = Ejabberd.Util.fail("host not exist", -1)
        send_resp(conn, 200, errRet)

      hostInfo ->
        detail = %{
          host: hostInfo.host,
          description: hostInfo.description,
          host_type: hostInfo.host_type,
          host_qrcode: hostInfo.host_qrcode,
          need_approve: hostInfo.need_approve,
          create_time: hostInfo.create_time
        }

        succ = Ejabberd.Util.success(detail)
        send_resp(conn, 200, succ)
    end
  end
end
