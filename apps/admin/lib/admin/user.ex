defmodule Admin.Router.User do
  @moduledoc """
    user router
  """
  use Plug.Router
  require Logger
  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  forward("/host/", to: Admin.Router.HostInfo)

  match "/addUser/user" do
    conn
  end

  match "/addUser/users" do
    conn
  end

  match "/update/user" do
    conn
  end

  match "/update/changePwd" do
    conn
  end

  match "/delete/users" do
    conn
  end

  match "/delete/user" do
    conn
  end

  match "/kick/user" do
    conn
  end

  match "/user/list" do
    conn
  end

  match "/getuserDetail" do
    Logger.info(
      "method #{inspect(conn.method)}, #{inspect(conn.body_params)}, #{inspect(conn.query_params)}"
    )

    userId = Map.get(conn.body_params, "userId")
    host = Map.get(conn.body_params, "host")
    hostInfo = Ejabberd.HostInfo.getHostInfo(host)
    Logger.info("hostInfo #{inspect(hostInfo)}")

    case Ejabberd.HostUsers.findByUserId(userId, hostInfo.id) do
      nil ->
        errRet = Ejabberd.Util.fail("user not exist", -1)
        send_resp(conn, 200, errRet)

      user ->
        Logger.info("user #{inspect(user)}")

        detail = %{
          department: user.department,
          email: user.email,
          gender: user.gender,
          hrbp: user.hrbp,
          leader: user.leader,
          role: "",
          roleClassName: "",
          tel: user.tel,
          userId: user.user_id,
          userName: user.user_name
        }

        userResult = Ejabberd.Util.success(detail)

        Logger.info("userResult #{inspect(userResult)}")
        put_resp_header(conn, "content-type", "application/json")
        send_resp(conn, 200, userResult)
    end
  end
end
