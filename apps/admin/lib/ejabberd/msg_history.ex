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
    {:ok, time} = Map.get(params, "time", 0) |> DateTime.from_unix(:microsecond)
    Ejabberd.MsgHistory
    |> filter_history(params, :from)
    |> filter_history(params, :to)
    |> filter_history(params, :keyword)
    |> where([msg], msg.create_time > ^time)
    |> limit(^num)
    |> Ejabberd.Repo.all()
  end

  def filter_history(query, %{"user" => from}, :from) do
    query
    |> or_where([msg], msg.m_from == ^from)
  end

  def filter_history(query, %{"user" => to}, :to) do
    query
    |> or_where([msg], msg.m_to == ^to)
  end

  def filter_history(query, %{"keyword" => keyword}, :keyword) do
    query
    |> where([msg], like(msg.m_body, ^("%"<> keyword <> "%")))
  end

  def filter_history(query, %{}, _) do
    Logger.debug("doesnot match ")
    query
  end

end
