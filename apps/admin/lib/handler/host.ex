defmodule Handler.HostInfo do
  @moduledoc """
  host handle
  """
  require Logger

  def get_host_info(conn) do
    host = Map.get(conn.body_params, "host")

    case Ejabberd.HostInfo.get_host_info(host) do
      nil ->
        Ejabberd.Util.fail("host not exist", -1)

      hostInfo ->
        detail = %{
          host: hostInfo.host,
          description: hostInfo.description,
          host_type: hostInfo.host_type,
          host_qrcode: hostInfo.host_qrcode,
          need_approve: hostInfo.need_approve,
          create_time: hostInfo.create_time
        }

        Ejabberd.Util.success(detail)
    end
  end
end
