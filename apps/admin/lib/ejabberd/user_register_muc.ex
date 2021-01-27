defmodule Ejabberd.UserRegisterMucs do
  use Ecto.Schema

  import Ecto.Query

  require Logger

  @primary_key false
  schema "user_register_mucs" do
    field(:username, :string, default: "")
    field(:muc_name, :string, default: "")
    field(:domain, :string, default: "")
    field(:host, :string, default: "")
    field(:created_at, :utc_datetime)
    field(:registed_flag, :integer, default: 1)
  end

  def get_increment_mucs(username, host, time) do
    Ejabberd.UserRegisterMucs
    |> where([m], m.created_at > ^time and m.username == ^username and m.host == ^host)
    |> Ejabberd.Repo.all()
  end

  def search_group(user_id, key, limit, offset) do
    [user_s_name, domain] = String.split(user_id, "@")

    search_group_sql =
      "
    WITH tmp (key, user_id) AS (
      SELECT E'#{key}%', user_id
     FROM host_users
     WHERE  hire_flag = 1 AND user_id != E'#{user_s_name}' AND ( user_id ilike E'%#{key}%' OR user_name ilike E'%#{
        key
      }%' OR pinyin ilike E'%${key}%' ) AND host_id = ANY(SELECT id FROM host_info WHERE host = E'#{
        domain
      }' )
    ),
    tmp2 (muc_name, domain, created_at) AS (
      SELECT split_part(muc_name || '@' || domain,'@',1) ,split_part(muc_name || '@' || domain,'@',2), max(created_at) as created_at
      FROM user_register_mucs
      WHERE username = E'#{user_s_name}' AND host = E'#{domain}'
      AND registed_flag != 0 AND muc_name <> ALL ('{}') AND domain = 'conference.' || E'#{domain}'
      GROUP BY muc_name || '@' || domain
    )
    SELECT
      aa.mucname,
      split_part(bb.muc_name, '@', 2) AS domain,
      bb.show_name,
      bb.muc_title,
      bb.muc_pic,
      aa.tag
    FROM (
      SELECT mucname, array_agg(tag) AS tag, MAX(time) as time
      FROM(
          SELECT mucname, tag, time from (
          SELECT muc_name AS mucname, array_agg(hit) AS tag, max(time) as time
          FROM (
             SELECT a.muc_name|| '@' || a.domain as muc_name, string_agg(a.username||'@'||a.host, '|') as hit, max(a.created_at) as time
                      FROM user_register_mucs a JOIN tmp2 b ON a.muc_name = b.muc_name
                      WHERE username IN (select user_id from tmp where key =  E'%#{key}%' ) and a.registed_flag != 0 AND a.domain = 'conference.' || E'#{
        domain
      }'
                      group by a.muc_name || '@' || a.domain
          ) foo
          GROUP BY muc_name
          HAVING COUNT(muc_name) = 1
          ) boo
          union all
          select a.muc_name|| '@' || a.domain as muccname, array[''] as hit, a.created_at as time
          from tmp2 a join muc_vcard_info b on concat(a.muc_name, '@', a.domain) = b.muc_name
          where (b.show_name ilike E'%#{key}%' or b.muc_name ilike  E'%#{key}%' )
          ) poo
      GROUP BY mucname
    ) aa
    JOIN muc_vcard_info bb
    ON aa.mucname  = bb.muc_name
    ORDER BY time DESC
    offset #{offset} limit #{limit}
    "

    Logger.debug("search_group_sql: #{search_group_sql}")
    {:ok, result} = Ecto.Adapters.SQL.query(Ejabberd.Repo, search_group_sql, [])
    Logger.debug("search group result: #{inspect(result.rows)}")
    result.rows
  end
end
