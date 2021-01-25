defmodule Admin.Router.User do
  @moduledoc """
    user router
  """
  use Plug.Router
  require Logger
  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  match "/status" do
    get_user_status(conn)
  end

  def get_user_status(conn) do
    host = Map.get(conn.body_params, "host", Ejabberd.Util.get_default_host())

    users =
      Map.get(conn.body_params, "users", [])
      |> Enum.map(fn user ->
        [user, _] = String.split(user, "@")
        user
      end)

    Logger.debug("host: #{host}, users: #{inspect(users)}")
    results = Ejabberd.Floginuser.get_login_users(users)
    Logger.debug("results: #{inspect(results)}")
    result = Ejabberd.Util.success(results)
    send_resp(conn, 200, result)
  end

  match "/get_vcard_info" do
    get_vcard_info(conn)
  end

  def get_vcard_info(conn) do
    domains = Map.get(conn.body_params, "_json", [])
    Logger.debug("domains: #{inspect(domains)}")

    results =
      domains
      |> Enum.map(fn domain_users ->
        domain = Map.get(domain_users, "domain", "")
        host = Ejabberd.HostInfo.get_host_info(domain)

        users =
          Map.get(domain_users, "users", [])
          |> Enum.flat_map(fn user ->
            username = Map.get(user, "user", [])
            version = Map.get(user, "version", [])
            Logger.debug("username: #{inspect(username)}, version: #{inspect(version)}")
            vcard_version = Ejabberd.VcardVersion.get_vcard_info(username, domain)

            case vcard_version.version >= version do
              true ->
                [transfer_user(Ejabberd.HostUsers.find_user(username, host.id), vcard_version)]

              false ->
                []
            end
          end)

        %{domain: domain, users: users}
      end)

    Logger.debug("results: #{inspect(results)}")
    result = Ejabberd.Util.success(results)
    send_resp(conn, 200, result)
  end

  defp transfer_user(user, vcard_version) do
    %{
      type: "",
      loginName: user.user_name,
      email: "",
      gender: user.gender,
      nickname: vcard_version.username,
      webname: vcard_version.username,
      imageurl: vcard_version.url,
      uid: "0",
      username: user.user_name,
      domain: vcard_version.host,
      commenturl: "https://xxxx/dianping/user_comment.php",
      mood: vcard_version.mood,
      adminFlag: user.admin_flag,
      V: vcard_version.version,
      v: vcard_version.version
    }
  end

  match "/getUpdateUsers" do
    get_update_users(conn)
  end

  def get_update_users(conn) do
    max_version = Ejabberd.HostUsers.max_version()
    version = Map.get(conn.body_params, "version")
    Logger.debug("max_version: #{max_version}, version: #{version}")

    case max_version <= version do
      true ->
        succ = Ejabberd.Util.success("")
        send_resp(conn, 200, succ)

      false ->
        host = Map.get(conn.body_params, "host", Ejabberd.Util.get_default_host())
        host_info = Ejabberd.HostInfo.get_host_info(host)
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

        Logger.debug(
          "update_users: #{inspect(update_users)}, delete_users: #{inspect(delete_users)}"
        )

        succ =
          Ejabberd.Util.success(%{
            update: update_users,
            delete: delete_users
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

  match "/add" do
    userId = Map.get(conn.body_params, "userId")
    host = Map.get(conn.body_params, "host")
    Logger.info("userId #{userId} host #{host} ")
    host_info = Ejabberd.HostInfo.get_host_info(host)
    params = conn.body_params
    Logger.info("add user params #{inspect(conn.body_params)}")

    user = %Ejabberd.HostUsers{
      host_id: host_info.id,
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
      user_type: Map.get(params, "user_type", "U"),
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

    max_version = Ejabberd.HostUsers.max_version()
    vcard_version = %Ejabberd.VcardVersion{
      username: Map.get(params, "userId"),
      version: max_version + 1,
      url: "/file/v2/download/8c9d42532be9316e2202ffef8fcfeba5.png",
      host: host
    }
    Ejabberd.VcardVersion.set_vcard_version(vcard_version)

    # send notify to http
    Admin.Ejabberd.notify(host_info)

    userResult = Ejabberd.Util.success("")
    put_resp_header(conn, "content-type", "application/json")
    send_resp(conn, 200, userResult)
  end

  match "/update/user" do
    userResult = Ejabberd.Util.success("")
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
    host_info = Ejabberd.HostInfo.get_host_info(host)
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
    hostInfo = Ejabberd.HostInfo.get_host_info(host)
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
