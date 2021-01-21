defmodule Admin.Router.History do
  @moduledoc """
  history router
  """
  use Plug.Router
  require Logger
  require SweetXml

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  match "/get" do
    get_history(conn)
  end

  def get_history(conn) do
    histories = Ejabberd.MsgHistory.get_history(conn.body_params)
    Logger.debug("histories: #{inspect(histories)}")

    read_flag = Map.get(conn.body_params, "read_flag", "f")

    result =
      histories
      |> Enum.map(fn history ->
        Logger.debug("history: #{history.m_body}")
        body = SweetXml.parse(history.m_body)

        attrs = attrs_to_json(body)
        Logger.debug("attrs: #{inspect(attrs)} ")

        stime = body |> get_content(:name, :stime)
        stime = if stime == nil, do: %{stime: ""}, else: attrs_to_json(stime)
        Logger.debug("stime: #{inspect(stime)}")

        msg_body = get_content(body, :name, :body)
        Logger.debug("msg_body: #{inspect(msg_body)}")

        body_content =
          get_content(msg_body, :type, :text)
          |> SweetXml.xmlText(:value)
          |> to_string()

        msg_content =
          msg_body
          |> attrs_to_json()
          |> Map.put(:content, body_content)

        Logger.debug("msgContent: #{inspect(msg_content)}")

        read_flag =
          cond do
            read_flag == "t" ->
              history.read_flag

            history.read_flag == 0 ->
              0

            true ->
              1
          end

        %{
          from: history.m_from,
          from_host: history.from_host,
          to: history.m_to,
          to_host: history.to_host,
          message: attrs,
          body: msg_content,
          stime: stime,
          read_flag: read_flag,
          t: history.create_time
        }
      end)

    succ = Ejabberd.Util.success(result)
    send_resp(conn, 200, succ)
  end

  def attrs_to_json(xml) do
    xml
    |> SweetXml.xmlElement(:attributes)
    |> Enum.map(fn attr ->
      {SweetXml.xmlAttribute(attr, :name), to_string(SweetXml.xmlAttribute(attr, :value))}
    end)
    |> Map.new()
  end

  def get_content(xml, :name, value) do
    xml
    |> SweetXml.xmlElement(:content)
    |> Enum.find(fn e -> SweetXml.xmlElement(e, :name) == value end)
  end

  def get_content(xml, :type, value) do
    xml
    |> SweetXml.xmlElement(:content)
    |> Enum.find(fn e -> SweetXml.xmlText(e, :type) == value end)
  end

  match "/getreadflag" do
    succ = Ejabberd.Util.success([])
    send_resp(conn, 200, succ)
  end

  match "/muc/get" do
    get_muc_history(conn)
  end

  def get_muc_history(conn) do
    succ = Ejabberd.Util.success([])
    send_resp(conn, 200, succ)
  end

  match "/muc/readmark" do
    succ = Ejabberd.Util.success([])
    send_resp(conn, 200, succ)
  end

  match "/system/get" do
    succ = Ejabberd.Util.success([])
    send_resp(conn, 200, succ)
  end
end
