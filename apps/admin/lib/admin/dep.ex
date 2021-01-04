defmodule Admin.Router.Dep do
  @moduledoc """
  host router
  """
  use Plug.Router
  require Logger

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  @department_separator "/"

  match "/add" do
    params = conn.body_params
    dep_name = Map.get(params, "depName", "")

    dep_name =
      unless String.starts_with?(dep_name, @department_separator) do
        @department_separator <> dep_name
      else
        dep_name
      end

    dep = %{
      dep_name: dep_name,
      dep_level: Map.get(params, "depLevel", 1),
      dep_vp: Map.get(params, "depVp", ""),
      dep_hr: Map.get(params, "depHr", ""),
      dep_visible: Map.get(params, "depVisible", ""),
      parent_id: Map.get(params, "parentId", 0),
      dep_leader: Map.get(params, "depLeader", ""),
      dep_desc: Map.get(params, "depDesc", "")
    }

    ret =
      if Ejabberd.Department.create(dep) do
        Ejabberd.Util.success("")
      else
        Ejabberd.Util.fail("insert dep error")
      end

    send_resp(conn, 200, ret)
  end

  match "/get" do
    host = Map.get(conn.body_params, "host")

    case Ejabberd.HostInfo.getHostInfo(host) do
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
