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

  match "/rbl" do
    user = Map.get(conn.body_params, "user", "f")
    domain = Map.get(conn.body_params, "domain", "f")
    msg_rbls = Ejabberd.MsgHistory.get_rbl(user, domain)
    muc_room_rbls = Ejabberd.MucRoomHistory.get_rbl(user, domain)

    Logger.debug(
      "msg_rbls: #{inspect(msg_rbls.rows)}, muc_room_rbls: #{inspect(muc_room_rbls.rows)}"
    )

    # ["chao.zhang5", "startalk.tech", "<message msec_times='1611106000194' xml:lang='en' from='chao.zhang@startalk.tech' to='chao.zhang5@startalk.tech' type='chat' client_type='ClientTypeMac' client_ver='200010'><body id='42f997cbf6f4473f82dd1458d1cdb78e' msgType='1'>667</body></message>", ~U[2021-01-20 01:26:40.194000Z], 0, 1611106000.194, 1]
    result =
      (msg_rbls.rows ++ muc_room_rbls.rows)
      |> Enum.map(fn [u, host, xml_body, create_time, cnt, time, read_flag] ->
        %{
          user: u,
          xmlBody: xml_body,
          cnt: cnt,
          create_time: create_time,
          mFlag: read_flag,
          host: host,
          time: time
        }
      end)

    succ = Ejabberd.Util.success(result)
    send_resp(conn, 200, succ)
  end

  defp translate_muc_history([muc, nick, packet, _create_time, time, domain]) do
    body = SweetXml.parse(packet)

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

    attrs =
      cond do
        attrs.sendjid !== nil ->
          Map.put(attrs, :realfrom, attrs.sendjid)

        attrs.realfrom !== nil ->
          Map.put(attrs, :sendjid, attrs.realfrom)

        true ->
          attrs |> Map.put(:sendjid, "") |> Map.put(:realfrom, "")
      end

    %{
      muc: muc,
      nick: nick,
      host: domain,
      t: time,
      message: attrs,
      body: msg_content
    }
  end

  match "/mucmsgs" do
    time = Map.get(conn.body_params, "time", "time") |> trunc() |> get_time()
    Logger.debug("time: #{inspect(time)}")

    include = Map.get(conn.params, "include", "")
    direction = Map.get(conn.params, "direction", "")
    {direction, turn} = get_direction(include, direction)
    muc = Map.get(conn.params, "muc", "")
    num = Map.get(conn.params, "num", 50)

    result =
      Ejabberd.MucRoomHistory.select_msg_by_time(%{
        direction: direction,
        turn: turn,
        time: time,
        muc_room_name: muc,
        num: num
      })
      |> Enum.map(fn muc_history ->
        translate_muc_history(muc_history)
      end)

    result =
      case turn == "desc" do
        true ->
          Enum.reverse(result)

        false ->
          result
      end

    succ = Ejabberd.Util.success(result)
    send_resp(conn, 200, succ)
  end

  match "/msgs" do
    get_msgs(conn)
  end

  defp get_time(time) do
    cond do
      time > 1_000_000_000_000 ->
        trunc(time / 1000)

      time == 0 ->
        DateTime.utc_now() |> DateTime.to_unix()

      true ->
        time
    end
  end

  defp get_direction("t", "0") do
    {"<=", "desc"}
  end

  defp get_direction("t", _) do
    {">=", "asc"}
  end

  defp get_direction(_, "0") do
    {"<", "desc"}
  end

  defp get_direction(_, _) do
    {">", "asc"}
  end

  def get_msgs(conn) do
    read_flag = Map.get(conn.body_params, "read_flag", "f")
    Logger.debug("read_flag: #{inspect(read_flag)}")

    {:ok, time} =
      Map.get(conn.body_params, "time", "time") |> trunc() |> get_time() |> DateTime.from_unix()

    Logger.debug("time: #{inspect(time)}")

    include = Map.get(conn.params, "include", "")
    direction = Map.get(conn.params, "direction", "")

    {direction, turn} = get_direction(include, direction)

    Logger.debug("direction: #{inspect(direction)}, turn: #{inspect(turn)}")

    msgs =
      Ejabberd.MsgHistory.get_msgs(
        Map.merge(conn.params, %{direction: direction, turn: turn, time: time})
      )

    Logger.debug("histories: #{inspect(msgs)}")

    result =
      msgs
      |> Enum.map(fn msg -> translate_history(msg, read_flag) end)

    succ = Ejabberd.Util.success(result)
    send_resp(conn, 200, succ)
  end

  match "/get" do
    get_history(conn)
  end

  def get_history(conn) do
    histories = Ejabberd.MsgHistory.get_history(conn.body_params)
    Logger.debug("histories: #{inspect(histories)}")

    read_flag = Map.get(conn.body_params, "read_flag", "f")

    result =
      histories
      |> Enum.map(fn history -> translate_history(history, read_flag) end)

    succ = Ejabberd.Util.success(result)
    send_resp(conn, 200, succ)
  end

  defp translate_history(history, read_flag) do
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
