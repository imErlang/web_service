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
    Ejabberd.MsgHistory
    |> filter_history(%{from: from, to: to}, :from_to)
  end

  def filter_history(query, params, :from_to) do
    query
    |> where([msg], msg.m_from == ^params.from and msg.from_host == ^params.from_host and msg.m_to == ^params.to and msg.to_host == ^params.to_host)
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
    |> where([msg], like(msg.m_body, ^("%"<> params.keyword <> "%")))
  end

  def filter_history(query, %{}, _) do
    Logger.debug("doesnot match ")
    query
  end

end
