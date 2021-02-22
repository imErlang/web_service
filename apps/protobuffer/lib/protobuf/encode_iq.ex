defmodule MessageProtobuf.Encode.Iq do
  import Xml
  require Logger
  require Record

  def xml2pb_iq(statedata, from, to, packet) do
    case :fxml.get_attr("type", xmlel(packet, :attrs)) do
      {:value, "error"} ->
        encode_iq_error_pb_packet(packet) |> struct_pb_iq_msg()

      _ ->
        encode_iq_result_pb_packet(statedata, from, to, packet)
    end
  end

  def encode_pb_iq_bind_result(packet, key) do
    cdata = :fxml.get_subtag(packet, "bind") |> :fxml.get_subtag_cdata("jid")
    time = Util.get_timestamp() |> Integer.to_string()
    headers = [{"time_value", time}, {"key_value", key}] |> MessageProtobuf.Encode.encode_pb_stringheaders
    body = Messagebody.new(headers: headers, value: cdata)
    %{value: "bind", body: body}
  end

  def encode_user_muc_pb(packet) do
    mucs =
      :fxml.get_subtag(packet, "query")
      |> :fxml.get_subtags("muc_rooms")
      |> Enum.map(fn xml ->
        attrs = xmlel(xml, :attrs)
        {_, host} = List.keyfind(attrs, "host", 1, Util.get_default_domain())
        {_, name} = List.keyfind(attrs, "name", 1, "")
        headers = MessageProtobuf.Encode.encode_pb_stringheaders([{"name", name}, {"host", host}])
        Messagebody.new(headers: headers, value: "muc_room")
      end)

    %{
      value: "user_mucs",
      bodys: mucs
    }
  end

  def encode_pb_iq_create_muc(packet) do
    attrs = :fxml.get_subtag(packet, "query") |> :fxml.get_subtag("create_muc") |> xmlel(:attrs)
    {:value, res} = :fxml.get_attr("result", attrs)
    headers = MessageProtobuf.Encode.encode_pb_stringheaders([])
    body = Messagebody.new(headers: headers, value: res)

    %{
      value: "create_muc",
      body: body
    }
  end

  def encode_muc_invite_user_v2_pb(packet) do
    bodys =
      :fxml.get_subtag(packet, "query")
      |> :fxml.get_subtags("muc_invites")
      |> Enum.map(fn xml ->
        attrs = xmlel(xml, :attrs)
        {_, jid} = List.keyfind(attrs, "jid", 0, "")

        header =
          case List.keyfind(attrs, "status", 0, nil) do
            nil ->
              [{"jid", jid}]

            {_, status} ->
              [{"jid", jid}, {"status", status}]
          end

        headers = MessageProtobuf.Encode.encode_pb_stringheaders(header)
        Messagebody.new(headers: headers, value: "muc_invites")
      end)

    %{
      value: "muc_invite_user_v2",
      bodys: bodys
    }
  end

  def encode_pb_muc_user_register() do
    %{
      value: "muc_set_register",
      body: Messagebody.new(headers: [], value: "muc_invites")
    }
  end

  def encode_muc_user_pb(packet) do
    Logger.error("packet: #{inspect(packet, limit: :infinity)}")
    bodys =
      :fxml.get_subtag(packet, "query")
      |> :fxml.get_subtags("m_user")
      |> Enum.map(fn xml ->
        attrs = xmlel(xml, :attrs)
        {_, jid} = List.keyfind(attrs, "jid", 0, "")

        header =
          case List.keyfind(attrs, "affiliation", 0, :undefined) do
            :undefined ->
              [{"jid", jid}]

            {_, aff} ->
              [{"jid", jid}, {"affiliation", aff}]
          end

        headers = MessageProtobuf.Encode.encode_pb_stringheaders(header)
        Messagebody.new(headers: headers, value: "m_user")
      end)

    %{value: "muc_users", bodys: bodys}
  end

  def encode_pb_muc_user_del_register() do
    %{value: "muc_del_register", body: Messagebody.new(headers: [], value: "del_register")}
  end

  def encode_pb_destroy_muc() do
    headers = MessageProtobuf.Encode.encode_pb_stringheaders([{"result", "success"}])
    body = Messagebody.new(headers: headers, value: "desctroy_muc")

    %{
      value: "desctroy_muc",
      body: body
    }
  end

  def make_friend_opt_headers(attrs) do
    jid = :proplists.get_value("jid", attrs, "")
    mode = :proplists.get_value("mode", attrs, "")
    question = :proplists.get_value("question", attrs, "")
    answer = :proplists.get_value("answer", attrs, "")
    [{"jid", jid}, {"mode", mode}, {"question", question}, {"answer", answer}]
  end

  def encode_pb_get_friend_opt(packet) do
    headers =
      :fxml.get_subtag(packet, "get_verify_friend_mode")
      |> xmlel(:attrs)
      |> make_friend_opt_headers
      |> MessageProtobuf.Encode.encode_pb_stringheaders()

    body = Messagebody.new(headers: headers, value: "result")

    %{
      value: "get_verify_friend_mode",
      body: body
    }
  end

  def encode_pb_set_friend_opt(packet) do
    attrs = :fxml.get_subtag(packet, "set_verify_friend_mode") |> xmlel(:attrs)

    header =
      case :fxml.get_attr("result", attrs) do
        false ->
          [{"result", "false"}]

        {:value, res} ->
          [{"result", res}]
      end

    headers = MessageProtobuf.Encode.encode_pb_stringheaders(header)

    body = Messagebody.new(headers: headers, value: "set_verify_friend_mode")

    %{value: "set_verify_friend_mode", body: body}
  end

  def encode_pb_get_user_friends(packet) do
    attrs = :fxml.get_subtag(packet, "get_user_friends") |> xmlel(:attrs)
    {:value, res} = :fxml.get_attr("friends", attrs)
    headers = MessageProtobuf.Encode.encode_pb_stringheaders([{"friends", res}])
    body = Messagebody.new(headers: headers, value: "get_friends")
    %{value: "user_get_friends", body: body}
  end

  def encode_pb_del_user_friend(packet) do
    attrs = :fxml.get_subtag(packet, "delete_friend") |> xmlel(:attrs)
    {:value, jid} = :fxml.get_attr("jid", attrs)
    {:value, result} = :fxml.get_attr("result", attrs)
    headers = MessageProtobuf.Encode.encode_pb_stringheaders([{"jid", jid}, {"result", result}])
    body = Messagebody.new(headers: headers, value: "del_user_friend")
    %{value: "user_del_friend", body: body}
  end

  def encode_pb_time_http_key(packet) do
    query = :fxml.get_subtag(packet, "key")
    {:value, res} = :fxml.get_attr("value", xmlel(query, :attrs))
    time = MessageProtobuf.Encode.timestamp() |> Integer.to_string()
    headers = MessageProtobuf.Encode.encode_pb_stringheaders([{"time_key", time}, {"key", res}])
    body = Messagebody.new(headers: headers, value: "get_key")
    %{value: "get_key", body: body}
  end

  def encode_pb_get_mask_user(packet) do
    bodys =
      :fxml.get_subtags(packet, "get_mask_user")
      |> Enum.map(fn xml ->
        header =
          case List.keyfind(xmlel(xml, :attrs), "masked_user", 0, :undefined) do
            :undefined ->
              []

            {_, jid} ->
              [{"masked_user", jid}]
          end

        headers = MessageProtobuf.Encode.encode_pb_stringheaders(header)

        Messagebody.new(headers: headers, value: "get_mask_user")
      end)

    %{value: "get_mask_users", bodys: bodys}
  end

  def handle_subscribe_xml(packet, key) do
    case :fxml.get_subtag(packet, key) do
      false ->
        []

      sub ->
        case :fxml.get_attr("status", xmlel(sub, :attrs)) do
          {:value, v} ->
            [{"status", v}]

          _ ->
            [{"status", "false"}]
        end
    end
  end

  def encode_pb_handle_user_subscribe(packet) do
    query = :fxml.get_subtag(packet, "query")

    body =
      case handle_subscribe_xml(query, "subscribe") do
        [] ->
          case handle_subscribe_xml(query, "add_subscribe") do
            [] ->
              case handle_subscribe_xml(query, "delete_subscribe") do
                [] ->
                  :undefined

                del ->
                  headers = MessageProtobuf.Encode.encode_pb_stringheaders(del)

                  Messagebody.new(headers: headers, value: "delete_subscribe")
              end

            add ->
              headers = MessageProtobuf.Encode.encode_pb_stringheaders(add)

              Messagebody.new(headers: headers, value: "add_subscribe")
          end

        sub ->
          headers = MessageProtobuf.Encode.encode_pb_stringheaders(sub)

          Messagebody.new(headers: headers, value: "subscribe")
      end

    %{value: "subscribe", body: body}
  end

  def encode_pb_handle_user_subscribe_v2(packet) do
    query = :fxml.get_subtag(packet, "query")

    body =
      case handle_subscribe_xml(query, "subscribe") do
        [] ->
          case handle_subscribe_xml(query, "add_subscribe") do
            [] ->
              :undefined

            add ->
              headers = MessageProtobuf.Encode.encode_pb_stringheaders(add)

              Messagebody.new(headers: headers, value: "add_subscribe")
          end

        sub ->
          headers = MessageProtobuf.Encode.encode_pb_stringheaders(sub)

          Messagebody.new(headers: headers, value: "subscribe")
      end

    %{value: "subscribe", body: body}
  end

  def encode_pb_set_mask_user(packet) do
    query = :fxml.get_subtag(packet, "mask_user")

    header =
      case :fxml.get_attr("result", xmlel(query, :attrs)) do
        false ->
          [{"result", "failed"}]

        {:value, res} ->
          [{"result", res}]
      end

    headers = MessageProtobuf.Encode.encode_pb_stringheaders(header)

    body = Messagebody.new(headers: headers, value: "mask_user")

    %{
      value: "set_mask_user",
      body: body
    }
  end

  def encode_pb_cancel_mask_user(packet) do
    query = :fxml.get_subtag(packet, "cancel_mask_user")

    header =
      case :fxml.get_attr("result", xmlel(query, :attrs)) do
        false ->
          [{"result", "failed"}]

        {:value, res} ->
          [{"result", res}]
      end

    headers = MessageProtobuf.Encode.encode_pb_stringheaders(header)

    body = Messagebody.new(headers: headers, value: "mask_user")

    %{
      key: "result",
      value: "cancel_mask_user",
      body: body
    }
  end

  def encode_pb_get_virtual_user(packet) do
    bodys =
      :fxml.get_subtags(packet, "virtual_user")
      |> Enum.map(fn xml ->
        header =
          case List.keyfind(xmlel(xml, :attrs), "virtual_user", 1, :undefined) do
            :undefined ->
              []

            {_, [vu]} ->
              [{"vuser", vu}]
          end

        headers = MessageProtobuf.Encode.encode_pb_stringheaders(header)

        Messagebody.new(headers: headers, value: "get_vuser")
      end)

    %{
      key: "result",
      value: "get_vuser",
      bodys: bodys
    }
  end

  def encode_pb_get_vuser_role(packet) do
    xml = :fxml.get_subtag(packet, "on_duty_virtual_user")

    headers =
      [{"vitual_user", :proplists.get_value("virtual_user", xmlel(xml, :attrs), "")}]
      |> MessageProtobuf.Encode.encode_pb_stringheaders()

    body = Messagebody.new(headers: headers, value: "on_duty_virtual_user")

    %{
      value: "on_duty_virtual_user",
      body: body
    }
  end

  def encode_pb_start_session(packet) do
    xml = :fxml.get_subtag(packet, "start_session")

    header =
      case :proplists.get_value("result", xmlel(xml, :attrs), "failed") do
        "start session sucess" ->
          ruser = :proplists.get_value("real_user", xmlel(xml, :attrs), "")
          [{"start_session", "success"}, {"real_user", ruser}]

        _ ->
          [{"start_session", "failed"}]
      end

    headers = MessageProtobuf.Encode.encode_pb_stringheaders(header)

    body = Messagebody.new(headers: headers, value: "start_session")

    %{
      value: "start_session",
      body: body
    }
  end

  def encode_pb_end_session(packet) do
    xml = :fxml.get_subtag(packet, "end_session")

    headers =
      [{"result", :proplists.get_value("result", xmlel(xml, :attrs), "failed")}]
      |> MessageProtobuf.Encode.encode_pb_stringheaders()

    body = Messagebody.new(headers: headers, value: "end_session")

    %{value: "end_session", body: body}
  end

  def encode_iq_result_pb_packet(statedata, from, to, packet) do
    params = :qtalk_public.get_sub_xmlns_name(packet) |> encode_iq_ns(statedata, from, to, packet)
    id = :qtalk_public.get_xml_attrs_id(packet)

    Map.merge(
      %{
        from: from,
        to: to,
        type: :SignalTypeIQ,
        msg_id: id
      },
      params
    )
    |> struct_pb_iq_msg
  end

  @bind "urn:ietf:params:xml:ns:xmpp-bind"
  @user_mucs "http://jabber.org/protocol/muc#user_mucs"
  @create_muc "http://jabber.org/protocol/create_muc"
  @muc_invite_v2 "http://jabber.org/protocol/muc#invite_v2"
  @muc_register "http://jabber.org/protocol/muc#register"
  @muc_del_register "http://jabber.org/protocol/muc#del_register"
  @muc_admin "http://jabber.org/protocol/muc#admin"
  @muc_owner "http://jabber.org/protocol/muc#owner"
  @verify_friend "jabber:iq:verify_friend_mode"
  @get_friend "jabber:x:get_friend"
  @delete_friend "jabber:x:delete_friend"
  @xmpp_key "urn:xmpp:key"
  @mask_user "jabber:x:mask_user"
  @mask_user_v2 "jabber:x:mask_user_v2"
  @muc_user_subscribe "http://jabber.org/protocol/muc#muc_user_subscribe"
  @muc_user_subscribe_v2 "http://jabber.org/protocol/muc#muc_user_subscribe_v2"
  @virtual_user "jabber:x:virtual_user"

  def encode_iq_ns({"bind", @bind}, statedata, _from, _to, packet),
    do: encode_pb_iq_bind_result(packet, statedata.key)

  def encode_iq_ns({"query", @user_mucs}, _statdata, _from, _to, packet),
    do: encode_user_muc_pb(packet)

  def encode_iq_ns({"query", @create_muc}, _statdata, _from, _to, packet),
    do: encode_pb_iq_create_muc(packet)

  def encode_iq_ns({"query", @muc_invite_v2}, _statdata, _from, _to, packet),
    do: encode_muc_invite_user_v2_pb(packet)

  def encode_iq_ns({"query", @muc_register}, _statdata, _from, _to, packet) do
    m_user = :fxml.get_subtag(packet, "query") |> :fxml.get_subtags("m_user")

    case m_user == [] do
      true ->
        encode_pb_muc_user_register()

      false ->
        encode_muc_user_pb(packet)
    end
  end

  def encode_iq_ns({"query", @muc_del_register}, _statdata, _from, _to, _packet),
    do: encode_pb_muc_user_del_register()

  def encode_iq_ns({"query", @muc_admin}, _statdata, _from, _to, _packet),
    do: %{key: "result", value: "muc_admin"}

  def encode_iq_ns({"query", @muc_owner}, _statdata, _from, _to, _packet),
    do: encode_pb_destroy_muc()

  def encode_iq_ns({"get_verify_friend_mode", @verify_friend}, _statdata, _from, _to, packet),
    do: encode_pb_get_friend_opt(packet)

  def encode_iq_ns({"set_verify_friend_mode", @verify_friend}, _statdata, _from, _to, packet),
    do: encode_pb_set_friend_opt(packet)

  def encode_iq_ns({"get_user_friends", @get_friend}, _statdata, _from, _to, packet),
    do: encode_pb_get_user_friends(packet)

  def encode_iq_ns({"delete_friend", @delete_friend}, _statdata, _from, _to, packet),
    do: encode_pb_del_user_friend(packet)

  def encode_iq_ns({"key", @xmpp_key}, _statdata, _from, _to, packet),
    do: encode_pb_time_http_key(packet)

  def encode_iq_ns({"query", @mask_user_v2}, _statdata, _from, _to, packet),
    do: encode_pb_get_mask_user(packet)

  def encode_iq_ns({"query", @muc_user_subscribe}, _statdata, _from, _to, packet),
    do: encode_pb_handle_user_subscribe(packet)

  def encode_iq_ns({"query", @muc_user_subscribe_v2}, _statdata, _from, _to, packet),
    do: encode_pb_handle_user_subscribe_v2(packet)

  def encode_iq_ns({"mask_user", @mask_user}, _statdata, _from, _to, packet),
    do: encode_pb_set_mask_user(packet)

  def encode_iq_ns({"cancel_mask_user", @mask_user}, _statdata, _from, _to, packet),
    do: encode_pb_cancel_mask_user(packet)

  def encode_iq_ns({"virtual_user", @virtual_user}, _statdata, _from, _to, packet),
    do: encode_pb_get_virtual_user(packet)

  def encode_iq_ns({"on_duty_virtual_user", @virtual_user}, _statdata, _from, _to, packet),
    do: encode_pb_get_vuser_role(packet)

  def encode_iq_ns({"start_session", @virtual_user}, _statdata, _from, _to, packet),
    do: encode_pb_start_session(packet)

  def encode_iq_ns({"end_session", @virtual_user}, _statdata, _from, _to, packet),
    do: encode_pb_end_session(packet)

  def encode_iq_ns(_, _statdata, _from, _to, _packet), do: %{key: "result", value: "ping"}

  def encode_pb_iq_msg(key, val, msg_id, header, body, headers, bodys) do
    recv_time = Util.get_timestamp()

    pb_iq =
      Iqmessage.new(
        value: val,
        messageid: msg_id,
        header: header,
        body: body,
        receivedtime: recv_time,
        headers: headers,
        bodys: bodys
      )

    fpb_iq = handle_pb_iq_key(key, pb_iq)
    iq = Iqmessage.encode(fpb_iq)
    Logger.debug("key: #{inspect(key)} fpb_iq: #{inspect(fpb_iq)}, iq: #{inspect(iq)}")
    iq
  end

  def handle_pb_iq_key(key, iq) do
    case set_iqkey_type(key) do
      :none ->
        %{iq | key: key}

      v ->
        %{iq | definedkey: v}
    end
  end

  def set_iqkey_type(key) do
    case key do
      "result" -> :IQKeyResult
      "error" -> :IQKeyError
      _ -> :none
    end
  end

  def encode_iq_error_pb_packet(packet) do
    error = :fxml.get_subtag(packet, "error")
    {:value, code} = :fxml.get_attr("code", xmlel(error, :attrs))
    cdata = :fxml.get_subtag_cdata(error, "text")

    headers =
      [{"code", code}, {"data", cdata}]
      |> MessageProtobuf.Encode.encode_pb_stringheaders()

    body = Messagebody.new(headers: headers, value: "error_info")

    %{
      key: "error",
      body: body
    }
  end

  def struct_pb_iq_msg(params) do
    Logger.debug("params: #{inspect(params)}")
    from = Map.get(params, :from)
    to = Map.get(params, :to)
    type = Map.get(params, :type)
    key = Map.get(params, :key, "result")
    val = Map.get(params, :value, "")
    msg_id = Map.get(params, :msg_id)
    header = Map.get(params, :header, nil)
    body = Map.get(params, :body, nil)
    headers = Map.get(params, :headers, [])
    bodys = Map.get(params, :bodys, [])

    iq = encode_pb_iq_msg(key, val, msg_id, header, body, headers, bodys)
    pb_msg = MessageProtobuf.Encode.encode_pb_protomessage(from, to, type, 1, iq)
    opt = MessageProtobuf.Encode.get_proto_header_opt(pb_msg)
    pb = MessageProtobuf.Encode.encode_pb_protoheader(opt, pb_msg)
    Logger.debug("iq = #{inspect(iq, limit: :infinity)} pb = #{inspect(pb, limit: :infinity)} pb_msg = #{inspect(pb_msg, limit: :infinity)} ")
    pb
  end
end
