defmodule Ejabberd.MsgHistory do
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

  # MsgHistory.historyUser = async function (userId, keyWord, limit, offset) {
  #   let search_model = 'ilike';
  #   if (keyWord.startsWith('_')) {
  #     search_model = '~';
  #     keyWord = keyWord.substring(1);
  #   } else {
  #     keyWord = `%${keyWord}%`;
  #   }
  #   const user_s_name = userId.split('@')[0];
  #   const domain = userId.split('@')[1];
  #   app.logger.debug('search_model:', search_model, keyWord, limit, offset);
  #   const searchHistory = `SELECT a.count, b.create_time as date, b.m_from, b.from_host as fromhost, b.realfrom, b.m_to, b.to_host as tohost,
  #   b.realto, b.m_body as msg, a.conversation, b.msg_id, a.id FROM ( SELECT count(1) as count, MAX(id) as id, m_from||'@'||from_host
  #   || '_' || m_to||'@'||to_host as conversation FROM msg_history WHERE xpath('/message/body/text()',m_body::xml)::text ilike E'${keyWord}'
  #   AND ( (m_from = E'${user_s_name}' and from_host = E'${domain}') or (m_to = E'${user_s_name}' and to_host = E'${domain}'))
  #   GROUP BY m_from||'@'||from_host || '_' || m_to||'@'||to_host ORDER BY id desc OFFSET ${offset} LIMIT  ${limit}) a LEFT JOIN msg_history b ON a.id = b.id`;
  #   app.logger.debug('searchHistory:', searchHistory);
  #   const result = await app.model.query(searchHistory, { type: 'SELECT' });
  #   app.logger.debug('get history user:', result);
  #   return result;
  # };

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

    Ejabberd.MsgHistory
    |> filter_history(%{from: from}, :from)
    |> filter_history(%{to: to}, :to)
    |> filter_history(%{keyword: keyword}, :keyword)
    |> where([msg], msg.create_time > ^time)
    |> limit(^num)
    |> Ejabberd.Repo.all()
  end

  # const result = await app.model.query(
  #     'SELECT m_from, from_host, m_to, to_host, m_body, create_time, '
  #     + 'extract(epoch from date_trunc(\'US\', create_time)), read_flag FROM ' + msgByTime.table
  #     + ' WHERE ((m_from=:fuser and from_host = :fhost and m_to=:tuser and to_host = :thost) '
  #     + 'or (m_to=:fuser and to_host = :fhost and m_from=:tuser and from_host = :thost )) '
  #     + 'and create_time ' + msgByTime.direction + ' to_timestamp(:time) '
  #     + 'ORDER by create_time ' + msgByTime.turn + ' limit :num ',
  def get_msgs(params) do
    from = Map.get(params, "from", "")
    to = Map.get(params, "to", "")
    from_host = Map.get(params, "fhost", "")
    to_host = Map.get(params, "thost", "")
    num = Map.get(params, "num", 50)

    Ejabberd.MsgHistory
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
