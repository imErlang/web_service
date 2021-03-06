defmodule Handler.History do
  @moduledoc """
  history handler
  """

  require Logger
  require SweetXml
  import Plug.Conn

  def get_file_history(user_id, key, limit, offset) do
    Persistence.MsgHistory.get_file_history(user_id, key, limit, offset)
    |> Enum.map(fn [file, _from, _to, date, msgid, label, icon, msg] ->
      body = SweetXml.parse(msg)

      attrs = attrs_to_json(body)
      Logger.debug("attrs: #{inspect(attrs)} ")
      msg_body = get_content(body, :name, :body)
      msg_attrs = attrs_to_json(msg_body)
      Logger.debug("msg_body: #{inspect(msg_body)}, msg_atts: #{inspect(msg_attrs)}")
      time = if attrs.msec_times !== nil, do: attrs.msec_times, else: ""

      attrs_realfrom = Map.get(attrs, :realfrom, "")
      attrs_sendjid = Map.get(attrs, :sendjid, "")

      from =
        cond do
          attrs_realfrom !== nil && attrs_realfrom !== "" ->
            attrs_realfrom

          attrs_sendjid !== nil && attrs_sendjid !== "" ->
            attrs_sendjid

          true ->
            [attrs_from | _] = attrs.from |> String.split("/")
            attrs_from
        end

      attrs_realto = Map.get(attrs, :realto, "")

      to =
        cond do
          attrs_realto !== nil && attrs_realto !== "" ->
            attrs_realto

          true ->
            [attrs_to | _] = attrs.to |> String.split("/")
            attrs_to
        end

      {:ok, history_body} = Jason.encode(file)

      %{
        body: history_body,
        date: "#{date.year}-#{date.month}-#{date.day} #{date.hour}:#{date.minute}:#{date.second}",
        fileinfo: file,
        icon: icon,
        label: label,
        todoType: 32,
        extendinfo: "",
        msgid: msgid,
        mtype: msg_attrs.msgType,
        time: time,
        from: from,
        realfrom: from,
        to: to,
        realto: to
      }
    end)
  end

  def get_offline_muc_history(conn) do
    time = Map.get(conn.body_params, "time", 0) |> get_time()
    user = Map.get(conn.body_params, "user", "")
    num = Map.get(conn.body_params, "num", 10)
    host = Map.get(conn.body_params, "host", "")
    Logger.debug("user:#{user}, num: #{num}, time: #{time}, host: #{host}")

    result =
      Persistence.MucRoomHistory.select_local_domain_muc_history(user, host, time, num)
      |> Enum.map(fn [muc, nick, packet, _create_time, date, _domain] ->
        translate_muc_history(muc, nick, packet, date, "conference@#{host}")
      end)

    Logger.debug("get offline muc msg history #{inspect(result)}")
    Ejabberd.Util.success(result)
  end

  def get_muc_readmark(conn) do
    user = Map.get(conn.body_params, "user", "")
    host = Map.get(conn.body_params, "host", "")
    time = Map.get(conn.body_params, "time", 0)

    time =
      case is_binary(time) do
        true ->
          String.to_integer(time)

        false ->
          time
      end

    Logger.debug("user: #{user}, host: #{host}, time: #{time}")

    result =
      Persistence.MucRoomHistory.select_muc_time(user, host, time)
      |> Enum.map(fn [muc_name, domain, date] ->
        %{
          muc_name: muc_name,
          domain: domain,
          date: date
        }
      end)

    Ejabberd.Util.success(result)
  end

  def get_muc_history(user_id, key, limit, offset) do
    histories =
      Persistence.MucRoomHistory.get_muc_history(user_id, key, limit, offset)
      |> Enum.map(fn [count, _muc_name, msg_id, date, msg, label, icon, _id] ->
        body = SweetXml.parse(msg)

        attrs = attrs_to_json(body)
        Logger.debug("attrs: #{inspect(attrs)} ")

        from =
          cond do
            attrs.realfrom !== nil && attrs.realfrom !== "" ->
              attrs.realfrom

            attrs.sendjid !== nil && attrs.sendjid !== "" ->
              attrs.sendjid

            true ->
              [attrs_from | _] = attrs.from |> String.split("/")
              attrs_from
          end

        attrs_realto = Map.get(attrs, :realto, "")

        to =
          cond do
            attrs_realto !== nil && attrs_realto !== "" ->
              attrs_realto

            true ->
              [attrs_to | _] = attrs.to |> String.split("/")
              attrs_to
          end

        time = if attrs.msec_times !== nil, do: attrs.msec_times, else: ""
        msg_body = get_content(body, :name, :body)
        Logger.debug("msg_body: #{inspect(msg_body)}")

        body_content =
          get_content(msg_body, :type, :text)
          |> SweetXml.xmlText(:value)
          |> to_string()

        msg_attrs = attrs_to_json(msg_body)

        %{
          count: count,
          date:
            "#{date.year}-#{date.month}-#{date.day} #{date.hour}:#{date.minute}:#{date.second}",
          icon: icon,
          label: label,
          todoType: 16,
          body: body_content,
          extendinfo: "",
          msgid: msg_id,
          mtype: msg_attrs.msgType,
          time: time,
          from: from,
          realfrom: from,
          to: to,
          realto: to
        }
      end)

    Logger.debug("histories: #{inspect(histories)}")
    histories
  end

  def get_read_flag(conn) do
    time = Map.get(conn.body_params, "time", 0) |> get_time()
    id = Map.get(conn.body_params, "id", 0)
    [cookie] = get_req_header(conn, "cookie")
    cookies = URI.decode_query(cookie)
    ckey = Map.get(cookies, "q_ckey", nil)

    case ckey == nil do
      true ->
        Ejabberd.Util.success([])

      false ->
        {:ok, ckey_value} = Base.decode64(ckey)
        requests = URI.decode_query(ckey_value)
        Logger.debug("cookies: #{inspect(requests)}")
        user = Map.get(requests, "u", "")

        result =
          Persistence.MsgHistory.get_read_flag(user, time, id)
          |> Enum.map(fn [_id, msg_id, read_flag, _update_time] ->
            %{readflag: read_flag, msgid: msg_id}
          end)

        Ejabberd.Util.success(result)
    end
  end

  # defp get_user_from_ckey() do

  # end

  def get_user_history(user_id, key, limit, offset) do
    [_user_s_name, domain] = String.split(user_id, "@")
    host_info = Ejabberd.HostInfo.get_host_info(domain)

    histories =
      Persistence.MsgHistory.get_history_user(user_id, key, limit, offset)
      |> Enum.map(fn [
                       count,
                       date,
                       m_from,
                       fromhost,
                       realfrom,
                       m_to,
                       tohost,
                       realto,
                       msg,
                       _conversation,
                       msg_id,
                       _id
                     ] ->
        from = if realfrom !== "", do: realfrom, else: "#{m_from}@#{fromhost}"
        to = if realto !== "", do: realto, else: "#{m_to}@#{tohost}"
        other = if user_id == from, do: m_to, else: m_from
        other_user = Ejabberd.HostUsers.find_user(other, host_info.id)
        body = SweetXml.parse(msg)

        attrs = attrs_to_json(body)
        Logger.debug("attrs: #{inspect(attrs)} ")
        time = if attrs.msec_times !== nil, do: attrs.msec_times, else: ""
        msg_body = get_content(body, :name, :body)
        Logger.debug("msg_body: #{inspect(msg_body)}")
        msg_attrs = attrs_to_json(msg_body)

        body_content =
          get_content(msg_body, :type, :text)
          |> SweetXml.xmlText(:value)
          |> to_string()

        %{
          count: count,
          date:
            "#{date.year}-#{date.month}-#{date.day} #{date.hour}:#{date.minute}:#{date.second}",
          icon: "",
          from: from,
          to: to,
          realfrom: from,
          realto: to,
          label: other_user.user_name,
          todoType: 8,
          body: body_content,
          extendinfo: "",
          msgid: msg_id,
          mtype: msg_attrs.msgType,
          time: time
        }
      end)

    Logger.debug("histories: #{inspect(histories)}")
    histories
  end

  def get_rbl(conn) do
    user = Map.get(conn.body_params, "user", "f")
    domain = Map.get(conn.body_params, "domain", "f")
    msg_rbls = Persistence.MsgHistory.get_rbl(user, domain)
    muc_room_rbls = Persistence.MucRoomHistory.get_rbl(user, domain)

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

    Ejabberd.Util.success(result)
  end

  defp get_send_jid(attrs) do
    send_jid = Map.get(attrs, :sendjid, nil)
    real_from = Map.get(attrs, :realfrom, nil)

    cond do
      send_jid !== nil ->
        send_jid

      real_from !== nil ->
        real_from

      true ->
        ""
    end
  end

  defp translate_muc_history(muc, nick, packet, time, domain) do
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

    sendjid = get_send_jid(attrs)

    attrs =
      case Map.get(attrs, :sendjid, nil) == nil do
        true ->
          Map.put(attrs, :sendjid, sendjid)

        false ->
          attrs
      end

    attrs =
      case Map.get(attrs, :realfrom, nil) == nil do
        true ->
          Map.put(attrs, :realfrom, attrs.sendjid)

        false ->
          attrs
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

  def get_muc_msgs(conn) do
    time = Map.get(conn.body_params, "time", "time") |> trunc() |> get_time()
    Logger.debug("time: #{inspect(time)}")

    include = Map.get(conn.params, "include", "")
    direction = Map.get(conn.params, "direction", "")
    {direction, turn} = get_direction(include, direction)
    muc = Map.get(conn.params, "muc", "")
    num = Map.get(conn.params, "num", 50)

    result =
      Persistence.MucRoomHistory.select_msg_by_time(%{
        direction: direction,
        turn: turn,
        time: time,
        muc_room_name: muc,
        num: num
      })
      |> Enum.map(fn [muc, nick, packet, _create_time, time, domain] ->
        translate_muc_history(muc, nick, packet, time, domain)
      end)

    case turn == "desc" do
      true ->
        Enum.reverse(result)

      false ->
        result
    end

    Ejabberd.Util.success(result)
  end

  def get_time(time) do
    cond do
      time > 1_000_000_000_000 ->
        time

      time == 0 ->
        DateTime.utc_now() |> DateTime.to_unix(:millisecond)

      true ->
        time * 1000
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
      Map.get(conn.body_params, "time", 0) |> trunc() |> get_time() |> DateTime.from_unix()

    Logger.debug("time: #{inspect(time)}")

    include = Map.get(conn.params, "include", "")
    direction = Map.get(conn.params, "direction", "")

    {direction, turn} = get_direction(include, direction)

    Logger.debug("direction: #{inspect(direction)}, turn: #{inspect(turn)}")

    msgs =
      Persistence.MsgHistory.get_msgs(
        Map.merge(conn.params, %{direction: direction, turn: turn, time: time})
      )

    Logger.debug("histories: #{inspect(msgs)}")

    result =
      msgs
      |> Enum.map(fn msg -> translate_history(msg, read_flag) end)

    Ejabberd.Util.success(result)
  end

  def get_history(conn) do
    Logger.debug("get history requests: #{inspect(conn.body_params)}")
    user = Map.get(conn.body_params, "user", "")
    host = Map.get(conn.body_params, "domain", "")
    read_flag = Map.get(conn.body_params, "f", "f")
    num = Map.get(conn.body_params, "num", 500)
    time = Map.get(conn.body_params, "time", 0) |> get_time()
    Logger.debug("get history time: #{inspect(time)}")
    get_history_local(user, host, read_flag, num, time)
  end

  def get_history_local(user, host, read_flag, num, time) do
    histories = Persistence.MsgHistory.get_history(user, host, num, time)
    Logger.debug("histories: #{inspect(histories)}")

    result =
      histories
      |> Enum.map(fn [m_from, from_host, m_to, to_host, m_body, _create_time, date, r] ->
        history = %{
          m_body: m_body,
          m_from: m_from,
          from_host: from_host,
          m_to: m_to,
          to_host: to_host,
          read_flag: r,
          create_time: date
        }

        translate_history(history, read_flag)
      end)

    Logger.debug("get history :#{inspect(result)}")

    Ejabberd.Util.success(result)
  end

  def translate_history(history, read_flag) do
    Logger.debug("history: #{history.m_body}")
    body = SweetXml.parse(history.m_body)

    attrs = attrs_to_json(body)
    Logger.debug("attrs: #{inspect(attrs)} ")

    stime = body |> get_content(:name, :stime)
    stime = if stime == nil, do: %{stime: ""}, else: attrs_to_json(stime)
    Logger.debug("stime: #{inspect(stime)}")

    msg_body = get_content(body, :name, :body)
    Logger.debug("msg_body: #{inspect(msg_body)}")

    msg_content =
      case get_content(msg_body, :type, :text) do
        nil ->
          attrs_to_json(msg_body)

        msg_content ->
          attrs_content = SweetXml.xmlText(msg_content, :value) |> to_string()
          attrs_to_json(msg_body) |> Map.put(:content, attrs_content)
      end

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
end
