defmodule Ejabberd.HostUsers do
  use Ecto.Schema

  require Logger

  import Ecto.Query, only: [from: 2, where: 3, update: 3, select: 3]

  schema "host_users" do
    field(:host_id, :integer, default: 1)
    field(:user_id, :string)
    field(:user_name, :string)
    field(:department, :string)
    field(:tel, :string)
    field(:email, :string, default: "")
    field(:dep1, :string)
    field(:dep2, :string)
    field(:dep3, :string)
    field(:dep4, :string)
    field(:dep5, :string)
    field(:pinyin, :string, default: "")
    field(:frozen_flag, :integer)
    field(:version, :integer)
    field(:user_type, :string)
    field(:hire_flag, :integer)
    field(:gender, :integer)
    field(:password, :string)
    field(:initialpwd, :integer)
    field(:pwd_salt, :string)
    field(:leader, :string)
    field(:hrbp, :string)
    field(:user_role, :integer)
    field(:approve_flag, :integer)
    field(:user_desc, :string)
    field(:user_origin, :integer)
    field(:hire_type, :string)
    field(:admin_flag, :string)
    field(:ps_deptid, :string)
    field(:create_time, :utc_datetime)
  end

  def get_users(host_id) do
    Ejabberd.HostUsers
    |> where([u], u.hire_flag == 1 and u.frozen_flag == 0 and u.host_id == ^host_id)
    |> Ejabberd.Repo.all()
  end

  def create_user(user) do
    user |> Ejabberd.Repo.insert(on_conflict: :nothing)
  end

  def find_user(user_id, host_id) do
    query = from(u in Ejabberd.HostUsers, where: u.user_id == ^user_id and u.host_id == ^host_id)
    Ejabberd.Repo.one(query)
  end

  def get_update_users(host_id, version) do
    Ejabberd.HostUsers
    |> where([u], u.host_id == ^host_id and u.version > ^version)
    |> Ejabberd.Repo.all()
  end

  def max_version do
    Ejabberd.HostUsers
    |> select([u], max(u.version))
    |> Ejabberd.Repo.one()
  end

  def update_version(user_id, host_id) do
    update_sql = "WITH max_version AS ( SELECT MAX(version) AS max_version FROM host_users where host_id = $2)
    UPDATE host_users
    SET version = max_version.max_version + 1
    FROM max_version
    WHERE host_users.user_id = $1 and host_users.host_id = $2"
    {:ok, result} = Ecto.Adapters.SQL.query(Ejabberd.Repo, update_sql, [user_id, host_id])
    Logger.debug("update user version: #{inspect(result)}")
    result
  end

  def delete(user_id, host_id) do
    max_version = max_version()

    query =
      Ejabberd.HostUsers
      |> where([u], u.user_id == ^user_id and u.host_id == ^host_id)
      |> update([], set: [hire_flag: 0, version: ^(max_version + 1)])

    {num, _} = Ejabberd.Repo.update_all(query, [])
    num > 0
  end

  def search_user(user_id, "_" <> username, limit, offset) do
    search_user_local(user_id, String.slice(username, 1..-1), "~", limit, offset)
  end

  def search_user(user_id, username, limit, offset) do
    search_user_local(user_id, "%#{username}%", "ilike", limit, offset)
  end

  @spec search_user_local(binary, any, any, any, any) :: nil | [binary | [any]]
  def search_user_local(user_id, username, search_model, limit, offset) do
    [user_s_name, domain] = String.split(user_id, "@")

    search_sql =
      "SELECT aa.user_id, aa.department, bb.url as icon, CASE WHEN aa.nick != '' THEN aa.nick ELSE aa.user_name END, bb.mood , aa.pinyin
    FROM
    (
        SELECT a.user_id, b.department, b.user_name, b.pinyin, a.nick
        FROM (
            SELECT uu.user_id || '@' || hh.host as user_id,'' as nick, uu.host_id as hostid
            FROM host_users uu
            LEFT JOIN host_info hh
            ON uu.host_id = hh.id
            WHERE uu.hire_flag = 1 AND LOWER(uu.user_type) != 's'  AND
            ( uu.user_id ILIKE '#{username}' OR uu.user_name #{search_model} '#{username}' OR uu.pinyin ILIKE '#{
        username
      }' )
            AND uu.host_id = ANY(select id from host_info where host = '#{domain}' )
            UNION
            SELECT cc.subkey AS user_id, cc.configinfo as nick, hh.id as hostid
            FROM client_config_sync cc
            LEFT JOIN host_info hh
            ON cc.host = hh.host
            WHERE cc.username = '#{user_s_name}' AND cc.configkey = 'kMarkupNames' AND cc.configinfo #{
        search_model
      } '#{username}'  AND cc.host =  '#{domain}'
        ) a
        LEFT JOIN host_users b
        ON split_part(a.user_id, '@', 1)  = b.user_id AND a.hostid = b.host_id
    ) aa
    LEFT JOIN vcard_version bb
    ON aa.user_id = bb.username || '@' || bb.host
    LEFT JOIN
    (
    SELECT CASE WHEN m_from || '@' || from_host = '#{user_id}' THEN m_to || '@' || to_host ELSE m_from || '@' || from_host END AS contact, max(create_time) mx
        FROM msg_history
        WHERE (m_from = '#{user_s_name}' and from_host =  '#{domain}' ) or (m_to = '#{user_s_name}' and to_host = '#{
        domain
      }'  )
        GROUP BY contact
    ) cc
    ON aa.user_id = cc.contact
    ORDER BY cc.mx DESC nulls last
    LIMIT #{limit}
    OFFSET #{offset}"

    {:ok, result} = Ecto.Adapters.SQL.query(Ejabberd.Repo, search_sql, [])
    Logger.debug("search user result: #{inspect(result.rows)}")
    result.rows
  end
end
