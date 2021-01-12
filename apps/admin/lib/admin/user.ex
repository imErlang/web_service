defmodule Admin.Router.User do
  @moduledoc """
    user router
  """
  use Plug.Router
  require Logger
  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  match "/getUpdateUsers" do
    max_version = Ejabberd.HostUsers.max_version()
    version = Map.get(conn.body_params, "version")
    Logger.debug("#{max_version}, version #{version}")

    case max_version <= version do
      true ->
        succ = Ejabberd.Util.success("")
        send_resp(conn, 200, succ)

      false ->
        host = Map.get(conn.body_params, "host")
        host_info = Ejabberd.HostInfo.getHostInfo(host)
        users = Ejabberd.HostUsers.get_update_users(host_info.id, version)
        Logger.debug("users: #{inspect(users)}")

        {update_users, delete_users} =
          users
          |> Enum.reduce(
            {[], []},
            fn user, {update, delete} ->
              case user.hire_flag == 0 do
                true ->
                  {update, [transfer_update_user(user) | delete]}

                false ->
                  {[transfer_update_user(user) | update], delete}
              end
            end
          )

        succ =
          Ejabberd.Util.success(%{
            update: update_users,
            delete: delete_users,
            version: max_version
          })

        send_resp(conn, 200, succ)
    end
  end

  defp transfer_update_user(user) do
    pinyin = if user.pinyin == nil, do: "", else: user.pinyin
    email = if user.email == nil, do: "", else: user.email

    %{
      visibleFlag: true,
      U: user.user_id,
      N: user.user_name,
      D: user.department,
      pinyin: pinyin,
      sex: user.gender,
      uType: user.user_type,
      email: email
    }
  end

  match "/addUser/user" do
    userId = Map.get(conn.body_params, "userId")
    host = Map.get(conn.body_params, "host")
    Logger.info("userId #{userId} host #{host} ")
    hostInfo = Ejabberd.HostInfo.getHostInfo(host)
    params = conn.body_params
    Logger.info("add user params #{inspect(conn.body_params)}")

    user = %Ejabberd.HostUsers{
      host_id: hostInfo.id,
      user_id: Map.get(params, "userId"),
      user_name: Map.get(params, "userName"),
      department: Map.get(params, "department"),
      tel: Map.get(params, "tel"),
      email: Map.get(params, "email"),
      dep1: Map.get(params, "dep1", ""),
      dep2: Map.get(params, "dep2", ""),
      dep3: Map.get(params, "dep3", ""),
      dep4: Map.get(params, "dep4", ""),
      dep5: Map.get(params, "dep5", ""),
      pinyin: Map.get(params, "pinyin", ""),
      frozen_flag: Map.get(params, "frozen_flag", 0),
      version: Map.get(params, "version", 0),
      user_type: Map.get(params, "user_type", ""),
      hire_flag: Map.get(params, "hire_flag", 1),
      gender: Map.get(params, "gender", 1),
      password: Map.get(params, "password", ""),
      initialpwd: Map.get(params, "initialpwd", 0),
      pwd_salt: Map.get(params, "pwd_salt", ""),
      leader: Map.get(params, "leader", ""),
      hrbp: Map.get(params, "hrbp", ""),
      user_role: Map.get(params, "user_role", 0),
      approve_flag: Map.get(params, "approve_flag", 0),
      user_desc: Map.get(params, "user_desc", ""),
      user_origin: Map.get(params, "user_origin", 0),
      hire_type: Map.get(params, "hire_type", ""),
      admin_flag: Map.get(params, "admin_flag", ""),
      ps_deptid: Map.get(params, "ps_deptid", "")
    }

    Ejabberd.HostUsers.create_user(user)

    userResult = Ejabberd.Util.success()
    put_resp_header(conn, "content-type", "application/json")
    send_resp(conn, 200, userResult)
  end

  match "/update/user" do
    userResult = Ejabberd.Util.success()
    put_resp_header(conn, "content-type", "application/json")
    send_resp(conn, 200, userResult)
  end

  match "/update/changePwd" do
    userResult = Ejabberd.Util.success()
    put_resp_header(conn, "content-type", "application/json")
    send_resp(conn, 200, userResult)
  end

  match "/delete/user" do
    user_id = Map.get(conn.body_params, "userId")
    host = Map.get(conn.body_params, "host")
    host_info = Ejabberd.HostInfo.getHostInfo(host)
    Logger.info("user_id: #{user_id}, host_id: #{host_info.id}")

    userResult =
      if Ejabberd.HostUsers.delete(user_id, host_info.id) do
        Ejabberd.Util.success()
      else
        Ejabberd.Util.fail("delete user error")
      end

    put_resp_header(conn, "content-type", "application/json")
    send_resp(conn, 200, userResult)
  end

  match "/kick/user" do
    userResult = Ejabberd.Util.success()
    put_resp_header(conn, "content-type", "application/json")
    send_resp(conn, 200, userResult)
  end

  match "/user/list" do
    userResult = Ejabberd.Util.success()
    put_resp_header(conn, "content-type", "application/json")
    send_resp(conn, 200, userResult)
  end

  match "/getuserDetail" do
    Logger.info(
      "method #{inspect(conn.method)}, #{inspect(conn.body_params)}, #{inspect(conn.query_params)}"
    )

    userId = Map.get(conn.body_params, "userId")
    host = Map.get(conn.body_params, "host")
    hostInfo = Ejabberd.HostInfo.getHostInfo(host)
    Logger.info("hostInfo #{inspect(hostInfo)}")

    case Ejabberd.HostUsers.find_user(userId, hostInfo.id) do
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
