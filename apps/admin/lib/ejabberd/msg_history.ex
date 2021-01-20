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
    field(:real_from, :string, default: "")
    field(:real_to, :string, default: "")
    field(:msg_type, :string, default: "")
    field(:create_time, :utc_datetime)
    field(:update_time, :utc_datetime)
  end

  def get_history(params) do
    Ejabberd.MsgHistory
    |> filter_history(params, :from)
  end
  def compare_fromto(query, params) do
    query
    |> where([msg], msg.m_from == ^params.from and msg.m_to == ^params.to)
  end

  def filter_history(query, %{from: from}, :from) do
    query
    |> where([msg], msg.m_from == ^from)
  end

  def filter_history(query, %{to: to}, :to) do
    query
    |> where([msg], msg.m_to == ^to)
  end

  def filter_history(query, %{keyword: keyword}, :keyword) do
    query
    |> where([msg], like(msg.m_body, ^("%"<> keyword <> "%")))
  end
end
