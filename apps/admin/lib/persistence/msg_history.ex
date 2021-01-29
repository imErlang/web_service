defmodule Persistence.MsgHistory do
  use Ecto.Schema

  import Ecto.Query

  require Logger

  schema "msg_history" do
    field(:m_from, :string, default: "")
    field(:m_to, :string, default: "")
    field(:m_body, :string, default: "")
    field(:read_flag, :integer, default: 0)
    field(:msg_id, :string, default: "")
    field(:from_host, :string, default: "")
    field(:to_host, :string, default: "")
    field(:realfrom, :string, default: "")
    field(:realto, :string, default: "")
    field(:msg_type, :string, default: "")
    field(:create_time, :utc_datetime)
    field(:update_time, :utc_datetime)
  end

  @get_rbl_sql """
    SELECT
    a.user,
    a.host,
    a.xmlBody,
    a.create_time,
    COALESCE(b.cnt, 0) AS cnt,
    extract(epoch FROM a.create_time) AS time,
    1 AS mFlag
  FROM (
    SELECT
      b.msg_id,
      a.user,
      a.host,
      b.m_body AS xmlBody,
      b.create_time AS create_time
    FROM (
      SELECT
        CASE WHEN m_from = $1 THEN
          m_to
        ELSE
          m_from
        END AS USER,
        CASE WHEN m_from = $1 THEN
          to_host
        ELSE
          from_host
        END AS host,
        max(id) AS msgid
      FROM
        msg_history
      WHERE
        create_time > now() - interval '7 day'
        and(m_from = $1
          OR m_to = $1)
      GROUP BY
        CASE WHEN m_from = $1 THEN
          m_to
        ELSE
          m_from
        END,
        CASE WHEN m_from = $1 THEN
          to_host
        ELSE
          from_host
        END) AS a
      INNER JOIN msg_history AS b ON a.msgid = b.id
    ORDER BY
      b.create_time ASC) AS a
    LEFT JOIN (
      SELECT
        m_from,
        count(*) AS cnt
      FROM
        msg_history
      WHERE
        m_to = $1
        and((read_flag & 2) = 0)
        AND create_time > now() - interval '7 day'
      GROUP BY
        m_from) AS b ON a.user = b.m_from
  ORDER BY
    a.create_time DESC;
  """
  def get_rbl(user_id, host) do
    Logger.debug("user_id: #{inspect(user_id)}, host: #{host}")
    {:ok, result} = Ecto.Adapters.SQL.query(Ejabberd.Repo, @get_rbl_sql, [user_id])
    Logger.debug("result: #{inspect(result)}")
    result
  end

  def get_history_user(user_id, key, limit, offset) do
    [user_s_name, domain] = String.split(user_id, "@")

    search_history =
      "SELECT a.count, b.create_time as date, b.m_from, b.from_host as fromhost, b.realfrom, b.m_to, b.to_host as tohost,
    b.realto, b.m_body as msg, a.conversation, b.msg_id, a.id FROM ( SELECT count(1) as count, MAX(id) as id, m_from||'@'||from_host
    || '_' || m_to||'@'||to_host as conversation FROM msg_history WHERE xpath('/message/body/text()',m_body::xml)::text ilike E'%#{
        key
      }%'
    AND ( (m_from = E'#{user_s_name}' and from_host = E'#{domain}') or (m_to = E'#{user_s_name}' and to_host = E'#{
        domain
      }'))
    GROUP BY m_from||'@'||from_host || '_' || m_to||'@'||to_host ORDER BY id desc OFFSET #{offset} LIMIT #{
        limit
      }) a LEFT JOIN msg_history b ON a.id = b.id"

    {:ok, result} = Ecto.Adapters.SQL.query(Ejabberd.Repo, search_history, [])
    Logger.debug("search user history result: #{inspect(result.rows)}")
    result.rows
  end

  def get_history(params) do
    num = Map.get(params, "num", 50)
    from = Map.get(params, "from", "")
    to = Map.get(params, "to", "")
    keyword = Map.get(params, "keyword", "")
    {:ok, time} = Map.get(params, "time", 0) |> DateTime.from_unix(:microsecond)

    Persistence.MsgHistory
    |> filter_history(%{from: from}, :from)
    |> filter_history(%{to: to}, :to)
    |> filter_history(%{keyword: keyword}, :keyword)
    |> where([msg], msg.create_time > ^time)
    |> limit(^num)
    |> Ejabberd.Repo.all()
  end

  def get_file_history(user_id, key, limit, offset) do
    [user_s_name, domain] = String.split(user_id, "@")

    file_sql = "
    SELECT file, from_, pfv.muc_name as to_, date, msgid, pfv.show_name as label, pfv.muc_pic as icon, msg
    FROM (
        SELECT json(unnest(xpath('//body[@msgType=\"5\"]/text()', packet::xml))::text) AS file, '' AS from_, muc_room_name AS to_, create_time AS date, msg_id AS msgid,packet as msg
        FROM muc_room_history
        WHERE muc_room_name IN (
            SELECT muc_name
            FROM user_register_mucs
            WHERE username = E'#{user_s_name}'
               AND registed_flag = 1
               AND host = E'#{domain}'
        )
    ) pfc left join muc_vcard_info pfv
    on pfc.to_= split_part(pfv.muc_name,'@',1)
    WHERE file ->> 'FileName' ilike E'%#{key}%'
    UNION ALL
    SELECT file, from_, to_, date, msgid, pfb.user_name as label, pfv.url as icon, msg
    FROM (
        SELECT json(unnest(xpath('/message/body[@msgType=\"5\"]/text()', m_body::xml))::text) AS file, m_from || '@' || from_host as from_
            , m_to || '@' || to_host as to_, create_time AS date
            , msg_id AS msgid, m_body as msg
        FROM msg_history
        WHERE (m_from = E'#{user_s_name}' AND from_host = E'#{domain}' )
            OR (m_to = E'#{user_s_name}' AND to_host = E'#{domain}' )
    ) pfx left join vcard_version pfv
    on split_part(pfx.from_,'@',1) = pfv.username
    left join host_users pfb
    on pfv.username = pfb.user_id and pfv.host = ANY(SELECT host from host_info WHERE id = pfb.host_id)
    WHERE file ->> 'FileName' ilike E'%#{key}%'
    ORDER BY date desc
    OFFSET #{offset}
    LIMIT #{limit} "
    {:ok, result} = Ecto.Adapters.SQL.query(Ejabberd.Repo, file_sql, [])
    Logger.debug("search file history result: #{inspect(result.rows)}")
    result.rows
  end

  def get_read_flag(user, time, id) do
    sql =
      "
        SELECT id, msg_id,read_flag, extract(epoch from date_trunc(\'US\', update_time)) as update_time
        FROM msg_history WHERE (m_from = #{user} or m_to=#{user}) and update_time > to_timestamp(#{
        time
      }) id > #{id}
        order by create_time desc limit 10000"

    {:ok, result} = Ecto.Adapters.SQL.query(Ejabberd.Repo, sql, [])
    Logger.debug("get read flag result: #{inspect(result.rows)}")
    result.rows
  end

  def get_msgs(params) do
    from = Map.get(params, "from", "")
    to = Map.get(params, "to", "")
    from_host = Map.get(params, "fhost", "")
    to_host = Map.get(params, "thost", "")
    num = Map.get(params, "num", 50)

    Persistence.MsgHistory
    |> filter_history(%{from: from, to: to, from_host: from_host, to_host: to_host}, :from_to)
    |> filter_history(%{from: to, to: from, from_host: to_host, to_host: from_host}, :from_to)
    |> filter_history(%{create_time: params.time, direction: params.direction}, :create_time)
    |> filter_history(%{turn: params.turn}, :order)
    |> limit(^num)
    |> Ejabberd.Repo.all()
  end

  def filter_history(query, %{turn: "desc"}, :order) do
    query
    |> order_by([msg], desc: msg.create_time)
  end

  def filter_history(query, %{turn: "asc"}, :order) do
    query
    |> order_by([msg], asc: msg.create_time)
  end

  def filter_history(query, %{direction: ">="} = params, :create_time) do
    query
    |> where([msg], msg.create_time >= ^params.create_time)
  end

  def filter_history(query, %{direction: "<="} = params, :create_time) do
    query
    |> where([msg], msg.create_time <= ^params.create_time)
  end

  def filter_history(query, %{direction: ">"} = params, :create_time) do
    query
    |> where([msg], msg.create_time > ^params.create_time)
  end

  def filter_history(query, %{direction: "<"} = params, :create_time) do
    query
    |> where([msg], msg.create_time < ^params.create_time)
  end

  def filter_history(query, params, :from_to) do
    query
    |> or_where(
      [msg],
      msg.m_from == ^params.from and msg.from_host == ^params.from_host and msg.m_to == ^params.to and
        msg.to_host == ^params.to_host
    )
  end

  def filter_history(query, params, :from) do
    query
    |> or_where([msg], msg.m_from == ^params.from)
  end

  def filter_history(query, params, :to) do
    query
    |> or_where([msg], msg.m_to == ^params.to)
  end

  def filter_history(query, params, :keyword) do
    query
    |> where([msg], like(msg.m_body, ^("%" <> params.keyword <> "%")))
  end

  def filter_history(query, %{}, _) do
    Logger.debug("doesnot match ")
    query
  end
end
