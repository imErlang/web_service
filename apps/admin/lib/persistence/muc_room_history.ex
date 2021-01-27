defmodule Ejabberd.MucRoomHistory do
  use Ecto.Schema

  require Logger

  schema "muc_room_history" do
    field(:muc_room_name, :string, default: "")
    field(:nick, :string, default: "")
    field(:packet, :string, default: "")
    field(:have_subject, :boolean)
    field(:size, :string, default: "")
    field(:host, :string, default: "")
    field(:create_time, :utc_datetime)
  end

  @get_rbl_sql """
  select a.groupname as user,2 as mFlag , case when b.cnt is null then 0 else b.cnt end,
    a.msg_id,a.create_time, extract(epoch from a.create_time) as time, a.packet as xmlBody
      from ((select concat(b.muc_room_name, '@conference.', b.host) as groupname, max(b.id)
      as msgid from muc_room_users a inner join muc_room_history b on a.muc_name = b.muc_room_name
      and a.host = b.host where a.username = $1 and b.create_time > now() - interval '7 day'
      group by concat(b.muc_room_name, '@conference.',b.host)) a inner join muc_room_history b on
      a.msgid = b.id) as a left join (select concat(a.muc_name, '@', a.domain)
      as name, count(*) AS cnt from muc_room_users as a left join muc_room_history
      as b on a.muc_name = b.muc_room_name and b.create_time > to_timestamp(a.date::double precision/1000)
      where create_time > now() - interval '7 day'  and a.username = $1 group by name)
      as b on a.groupname = b.name;
  """
  def get_rbl(user_id, host) do
    Logger.debug("user_id: #{inspect(user_id)}, host: #{host}")
    {:ok, result} = Ecto.Adapters.SQL.query(Ejabberd.Repo, @get_rbl_sql, [user_id])
    Logger.debug("result: #{inspect(result)}")
    result
  end

  @select_msg_by_time """
  SELECT muc_room_name, nick, packet, create_time, extract(epoch from date_trunc('US', create_time)),host
  FROM muc_room_history WHERE (muc_room_name=$1  and create_time >= to_timestamp($2))
  ORDER by create_time desc limit $3;
  """
  def select_msg_by_time(params) do
    Logger.debug("params: #{inspect(params)}")

    {:ok, result} =
      Ecto.Adapters.SQL.query(Ejabberd.Repo, @select_msg_by_time, [
        params.muc_room_name,
        # params.direction,
        params.time,
        # params.turn,
        params.num
      ])

    Logger.debug("result: #{inspect(result.rows)}")
    result.rows
  end

  def get_muc_history(user_id, key, limit, offset) do
    [user_s_name, domain] = String.split(user_id, "@")

    search_muc_history =
      "SELECT count, c.muc_name, b.msg_id, b.create_time as date, b.packet, c.show_name as label, c.muc_pic as icon , a.id FROM (SELECT count(1) as count, MAX(id) as id, muc_room_name FROM muc_room_history WHERE xpath('/message/body/text()',packet::xml)::text ilike '%#{
        key
      }%' AND muc_room_name = ANY(SELECT muc_name FROM user_register_mucs where username = '#{
        user_s_name
      }' and registed_flag = 1  AND host = '#{domain}' and domain = 'conference.' || '#{domain}' ) GROUP BY muc_room_name ORDER BY id desc OFFSET #{
        offset
      } LIMIT #{limit} ) as a LEFT JOIN muc_room_history b ON a.id = b.id LEFT JOIN muc_vcard_info c on a.muc_room_name = split_part(c.muc_name,'@',1)"

    {:ok, result} = Ecto.Adapters.SQL.query(Ejabberd.Repo, search_muc_history, [])
    Logger.debug("search muc history result: #{inspect(result.rows)}")
    result.rows
  end
end
