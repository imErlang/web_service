defmodule MessageProtobuf.Encode.Iq do
  import Xml
  require Logger
  require Record

  def xml2pb_iq(statedata, from, to, packet) do
    case :fxml.get_attr("type", xmlel(packet, :attrs)) do
      {:value, "error"} ->
        encode_iq_error_pb_packet(from, to, packet)

      _ ->
        encode_iq_result_pb_packet(statedata, from, to, packet)
    end
  end

  def encode_pb_iq_bind_result(from, to, packet, key) do
    body =
      case :fxml.get_subtag(packet, "bind") do
        false ->
          :undefined

        bind ->
          cdata = :fxml.get_subtag_cdata(bind, "jid")
          time = Util.get_timestamp() |> Integer.to_string()
          headers = [{"time_value", time}, {"key_value", key}]
          Messagebody.new(headers: headers, value: cdata)
      end

    id = :qtalk_public.get_xml_attrs_id(packet)

    struct_pb_iq_msg(%{
      from: from,
      to: to,
      type: :SignalTypeIQ,
      key: "result",
      value: "bind",
      msg_id: id,
      body: body
    })
  end

  def get_pb_iq_user_mucs_bodys(packet) do
    case :fxml.get_subtag(packet, "query") do
      false ->
        []

      query ->
        mucs = :fxml.get_subtags(query, "muc_rooms")

        :lists.flatmap(
          fn xml ->
            headers =
              case Record.is_record(xml, Xml) do
                true ->
                  host =
                    :proplists.get_value(
                      "host",
                      xmlel(xml, :attrs),
                      :qtalk_public.get_default_domain()
                    )

                  case :proplists.get_value("name", xmlel(xml, :attrs)) do
                    :undefined ->
                      []

                    name ->
                      [{"name", name}, {"host", host}]
                  end

                false ->
                  []
              end

            [:ejabberd_xml2pb_public.encode_messagebody(headers, "muc_room")]
          end,
          mucs
        )
    end
  end

  def encode_user_muc_pb(from, to, packet) do
    bodys = get_pb_iq_user_mucs_bodys(packet)

    id =
      case :fxml.get_attr("id", xmlel(packet, :attrs)) do
        false ->
          Integer.to_string(Util.get_timestamp())

        {_, i} ->
          i
      end

    struct_pb_iq_msg(%{
      from: from,
      to: to,
      type: :SignalTypeIQ,
      key: "result",
      value: "user_mucs",
      msg_id: id,
      bodys: bodys
    })
  end

  def encode_pb_iq_create_muc(from, to, packet) do
    body =
      case :fxml.get_subtag(packet, "query") do
        false ->
          :undefined

        query ->
          case :fxml.get_subtag(query, "create_muc") do
            false ->
              :undefined

            muc_res ->
              case :fxml.get_attr("result", xmlel(muc_res, :attrs)) do
                false ->
                  :undefined

                {:value, res} ->
                  headers = MessageProtobuf.Encode.encode_pb_stringheaders([])
                  Messagebody.new(headers: headers, value: res)
              end
          end
      end

    id = :qtalk_public.get_xml_attrs_id(packet)

    struct_pb_iq_msg(%{
      from: from,
      to: to,
      type: :SignalTypeIQ,
      key: "result",
      value: "create_muc",
      msg_id: id,
      body: body
    })
  end

  def get_pb_iq_invite_muc_user_bodys(packet) do
    case :fxml.get_subtag(packet, "query") do
      false ->
        []

      query ->
        :fxml.get_subtags(query, "muc_invites")
        |> Enum.flat_map(fn xml ->
          header =
            case Record.is_record(xml, Xml) do
              true ->
                jid = :proplists.get_value("jid", xmlel(xml, :attrs), "")

                case :proplists.get_value("status", xmlel(xml, :attrs)) do
                  :undefined ->
                    [{"jid", jid}]

                  status ->
                    [{"jid", jid}, {"status", status}]
                end

              false ->
                []
            end

          headers = MessageProtobuf.Encode.encode_pb_stringheaders(header)
          Messagebody.new(headers: headers, value: "muc_invites")
        end)
    end
  end

  def encode_muc_invite_user_v2_pb(from, to, packet) do
    bodys = get_pb_iq_invite_muc_user_bodys(packet)
    id = :qtalk_public.get_xml_attrs_id(packet)

    struct_pb_iq_msg(%{
      from: from,
      to: to,
      type: :SignalTypeIQ,
      key: "result",
      value: "muc_invite_user_v2",
      msg_id: id,
      bodys: bodys
    })
  end

  def encode_pb_muc_user_register(from, to, packet) do
    body =
      case :fxml.get_subtag(packet, "query") do
        false ->
          :undefined

        query ->
          [xml] = xmlel(query, :children)

          case xmlel(xml, :name) do
            "set_register" ->
              Messagebody.new(headers: [], value: "muc_invites")

            _ ->
              :undefined
          end
      end

    id = :qtalk_public.get_xml_attrs_id(packet)

    struct_pb_iq_msg(%{
      from: from,
      to: to,
      type: :SignalTypeIQ,
      key: "result",
      value: "muc_set_register",
      msg_id: id,
      body: body
    })
  end

  def get_pb_iq_muc_user_bodys(packet) do
    case :fxml.get_subtag(packet, "query") do
      false ->
        []

      query ->
        :fxml.get_subtags(query, "m_user")
        |> Enum.flat_map(fn xml ->
          header =
            case Record.is_record(xml, Xml) do
              true ->
                jid = :proplists.get_value("jid", xmlel(xml, :attrs), "")

                case :proplists.get_value("affiliation", xmlel(xml, :attrs), :undefined) do
                  :undefined ->
                    [{"jid", jid}]

                  aff ->
                    [{"jid", jid}, {"affiliation", aff}]
                end

              false ->
                []
            end

          headers = MessageProtobuf.Encode.encode_pb_stringheaders(header)
          Messagebody.new(headers: headers, value: "m_user")
        end)
    end
  end

  def encode_muc_user_pb(from, to, packet) do
    bodys = get_pb_iq_muc_user_bodys(packet)

    id = :qtalk_public.get_xml_attrs_id(packet)

    struct_pb_iq_msg(%{
      from: from,
      to: to,
      type: :SignalTypeIQ,
      key: "result",
      value: "muc_users",
      msg_id: id,
      bodys: bodys
    })
  end

  def encode_pb_muc_user_del_register(from, to, packet) do
    body =
      case :fxml.get_subtag(packet, "query") do
        false ->
          :undefined

        _ ->
          Messagebody.new(headers: [], value: "del_register")
      end

    id = :qtalk_public.get_xml_attrs_id(packet)

    struct_pb_iq_msg(%{
      from: from,
      to: to,
      type: :SignalTypeIQ,
      key: "result",
      value: "muc_del_register",
      msg_id: id,
      body: body
    })
  end

  def encode_pb_muc_amdin(from, to, packet) do
    id = :qtalk_public.get_xml_attrs_id(packet)
    struct_pb_iq_msg(%{
      from: from,
      to: to,
      type: :SignalTypeIQ,
      key: "result",
      value: "muc_admin",
      msg_id: id
    })
  end

  def encode_pb_destroy_muc(from, to, packet) do
    id = :qtalk_public.get_xml_attrs_id(packet)
    headers = MessageProtobuf.Encode.encode_pb_stringheaders([{"result", "success"}])
    body = Messagebody.new(headers: headers, value: "desctroy_muc")
    struct_pb_iq_msg(%{
      from: from,
      to: to,
      type: :SignalTypeIQ,
      key: "result",
      value: "desctroy_muc",
      msg_id: id,
      body: body
    })
  end

  def make_friend_opt_headers(attrs) do
    jid = :proplists.get_value("jid", attrs, "")
    mode = :proplists.get_value("mode", attrs, "")
    question = :proplists.get_value("question", attrs, "")
    answer = :proplists.get_value("answer", attrs, "")
    [{"jid", jid}, {"mode", mode}, {"question", question}, {"answer", answer}]
  end

  def encode_pb_get_friend_opt(from, to, packet) do
    body =
      case :fxml.get_subtag(packet, "get_verify_friend_mode") do
        false ->
          :undefined

        query ->
          headers =
            MessageProtobuf.Encode.encode_pb_stringheaders(
              make_friend_opt_headers(xmlel(query, :attrs))
            )

          Messagebody.new(headers: headers, value: "result")
      end

    id = :qtalk_public.get_xml_attrs_id(packet)
    struct_pb_iq_msg(%{
      from: from,
      to: to,
      type: :SignalTypeIQ,
      key: "result",
      value: "get_verify_friend_mode",
      msg_id: id,
      body: body
    })
  end

  def encode_pb_set_friend_opt(from, to, packet) do
    body =
      case :fxml.get_subtag(packet, "set_verify_friend_mode") do
        false ->
          :undefined

        query ->
          header =
            case :fxml.get_attr("result", xmlel(query, :attrs)) do
              false ->
                [{"result", "false"}]

              {:value, res} ->
                [{"result", res}]
            end

          headers = MessageProtobuf.Encode.encode_pb_stringheaders(header)

          Messagebody.new(headers: headers, value: "set_verify_friend_mode")
      end

    id = :qtalk_public.get_xml_attrs_id(packet)
    struct_pb_iq_msg(%{
      from: from,
      to: to,
      type: :SignalTypeIQ,
      key: "result",
      value: "set_verify_friend_mode",
      msg_id: id,
      body: body
    })
  end

  def encode_pb_get_user_friends(from, to, packet) do
    body =
      case :fxml.get_subtag(Packet, "get_user_friends") do
        false ->
          :undefined

        query ->
          header =
            case :fxml.get_attr("friends", xmlel(query, :attrs)) do
              false ->
                []

              {:value, res} ->
                [{"friends", res}]
            end

          headers = MessageProtobuf.Encode.encode_pb_stringheaders(header)

          Messagebody.new(headers: headers, value: "get_friends")
      end

    id = :qtalk_public.get_xml_attrs_id(packet)

    struct_pb_iq_msg(%{
      from: from,
      to: to,
      type: :SignalTypeIQ,
      key: "result",
      value: "user_get_friends",
      msg_id: id,
      body: body
    })
  end

  def encode_pb_del_user_friend(from, to, packet) do
    body =
      case :fxml.get_subtag(Packet, "delete_friend") do
        false ->
          :undefined

        query ->
          header =
            case :fxml.get_attr("jid", xmlel(query, :attrs)) do
              false ->
                []

              {:value, res} ->
                case :fxml.get_attr("result", xmlel(query, :attrs)) do
                  false ->
                    []

                  {:value, result} ->
                    [{"jid", res}, {"result", result}]
                end
            end

          headers = MessageProtobuf.Encode.encode_pb_stringheaders(header)

          Messagebody.new(headers: headers, value: "del_user_friend")
      end

    id = :qtalk_public.get_xml_attrs_id(packet)
    struct_pb_iq_msg(%{
      from: from,
      to: to,
      type: :SignalTypeIQ,
      key: "result",
      value: "user_del_friend",
      msg_id: id,
      body: body
    })
  end

  def encode_pb_time_http_key(from, to, packet) do
    body =
      case :fxml.get_subtag(packet, "key") do
        false ->
          :undefined

        query ->
          header =
            case :fxml.get_attr("value", xmlel(query, :attrs)) do
              false ->
                []

              {:value, res} ->
                time = MessageProtobuf.Encode.timestamp() |> Integer.to_string()
                [{"time_key", time}, {"key", res}]
            end

          headers = MessageProtobuf.Encode.encode_pb_stringheaders(header)

          Messagebody.new(headers: headers, value: "get_key")
      end

    id = :qtalk_public.get_xml_attrs_id(packet)
    struct_pb_iq_msg(%{
      from: from,
      to: to,
      type: :SignalTypeIQ,
      key: "result",
      value: "get_key",
      msg_id: id,
      body: body
    })
  end

  def encode_pb_get_mask_user(from, to, packet) do
    bodys =
      :fxml.get_subtags(packet, "get_mask_user")
      |> Enum.flat_map(fn xml ->
        header =
          case Record.is_record(xml, Xml) do
            true ->
              case Keyword.get(xmlel(xml, :attrs), "masked_user", :undefined) do
                :undefined ->
                  []

                jid ->
                  [{"masked_user", jid}]
              end

            false ->
              []
          end

        headers = MessageProtobuf.Encode.encode_pb_stringheaders(header)

        Messagebody.new(headers: headers, value: "get_mask_user")
      end)

    id = :qtalk_public.get_xml_attrs_id(packet)
    struct_pb_iq_msg(%{
      from: from,
      to: to,
      type: :SignalTypeIQ,
      key: "result",
      value: "get_mask_users",
      msg_id: id,
      bodys: bodys
    })
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

  def encode_pb_handle_user_subscribe(from, to, packet) do
    body =
      case :fxml.get_subtag(packet, "query") do
        false ->
          :undefined

        query ->
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
      end

    id = :qtalk_public.get_xml_attrs_id(packet)
    struct_pb_iq_msg(%{
      from: from,
      to: to,
      type: :SignalTypeIQ,
      key: "result",
      value: "subscribe",
      msg_id: id,
      body: body
    })
  end

  def encode_pb_handle_user_subscribe_v2(from, to, packet) do
    body =
      case :fxml.get_subtag(packet, "query") do
        false ->
          :undefined

        query ->
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
      end

    id = :qtalk_public.get_xml_attrs_id(packet)
    struct_pb_iq_msg(%{
      from: from,
      to: to,
      type: :SignalTypeIQ,
      key: "result",
      value: "subscribe",
      msg_id: id,
      body: body
    })
  end

  def encode_pb_set_mask_user(from, to, packet) do
    body =
      case :fxml.get_subtag(packet, "mask_user") do
        false ->
          :undefined

        query ->
          header =
            case :fxml.get_attr("result", xmlel(query, :attrs)) do
              false ->
                [{"result", "failed"}]

              {:value, res} ->
                [{"result", res}]
            end

          headers = MessageProtobuf.Encode.encode_pb_stringheaders(header)

          Messagebody.new(headers: headers, value: "mask_user")
      end

    id = :qtalk_public.get_xml_attrs_id(packet)
    struct_pb_iq_msg(%{
      from: from,
      to: to,
      type: :SignalTypeIQ,
      key: "result",
      value: "set_mask_user",
      msg_id: id,
      body: body
    })
  end

  def encode_pb_cancel_mask_user(from, to, packet) do
    body =
      case :fxml.get_subtag(packet, "cancel_mask_user") do
        false ->
          :undefined

        query ->
          header =
            case :fxml.get_attr("result", xmlel(query, :attrs)) do
              false ->
                [{"result", "failed"}]

              {:value, res} ->
                [{"result", res}]
            end

          headers = MessageProtobuf.Encode.encode_pb_stringheaders(header)

          Messagebody.new(headers: headers, value: "mask_user")
      end

    id = :qtalk_public.get_xml_attrs_id(packet)
    struct_pb_iq_msg(%{
      from: from,
      to: to,
      type: :SignalTypeIQ,
      key: "result",
      value: "cancel_mask_user",
      msg_id: id,
      body: body
    })
  end

  def encode_pb_get_virtual_user(from, to, packet) do
    bodys =
      :fxml.get_subtags(packet, "virtual_user")
      |> Enum.flat_map(fn xml ->
        header =
          case Record.is_record(xml, Xml) do
            true ->
              case Keyword.get(xmlel(xml, :attrs), "virtual_user", :undefined) do
                :undefined ->
                  []

                [vu] ->
                  [{"vuser", vu}]
              end

            false ->
              []
          end

        headers = MessageProtobuf.Encode.encode_pb_stringheaders(header)

        Messagebody.new(headers: headers, value: "get_vuser")
      end)

    id = :qtalk_public.get_xml_attrs_id(packet)
    struct_pb_iq_msg(%{
      from: from,
      to: to,
      type: :SignalTypeIQ,
      key: "result",
      value: "get_vuser",
      msg_id: id,
      bodys: bodys
    })
  end

  def encode_pb_get_vuser_role(from, to, packet) do
    body =
      case :fxml.get_subtag(Packet, "on_duty_virtual_user") do
        false ->
          :undefined

        xml ->
          header =
            case :proplists.get_value("virtual_user", xmlel(xml, :attrs)) do
              :undefined ->
                [{"vitual_user", ""}]

              [vu] ->
                [{"vitual_user", vu}]
            end

          headers = MessageProtobuf.Encode.encode_pb_stringheaders(header)

          Messagebody.new(headers: headers, value: "on_duty_virtual_user")
      end

    id = :qtalk_public.get_xml_attrs_id(packet)
    struct_pb_iq_msg(%{
      from: from,
      to: to,
      type: :SignalTypeIQ,
      key: "result",
      value: "on_duty_virtual_user",
      msg_id: id,
      body: body
    })
  end

  def encode_pb_start_session(from, to, packet) do
    body =
      case :fxml.get_subtag(packet, "start_session") do
        false ->
          :undefined

        xml ->
          header =
            case :proplists.get_value("result", xmlel(xml, :attrs)) do
              :undefined ->
                [{"start_session", "failed"}]

              "start session sucess" ->
                ruser = :proplists.get_value("real_user", xmlel(xml, :attrs), "")
                [{"start_session", "success"}, {"real_user", ruser}]

              "start session failed" ->
                [{"start_session", "failed"}]
            end

          headers = MessageProtobuf.Encode.encode_pb_stringheaders(header)

          Messagebody.new(headers: headers, value: "start_session")
      end

    id = :qtalk_public.get_xml_attrs_id(packet)
    struct_pb_iq_msg(%{
      from: from,
      to: to,
      type: :SignalTypeIQ,
      key: "result",
      value: "start_session",
      msg_id: id,
      body: body
    })
  end

  def encode_pb_end_session(from, to, packet) do
    body =
      case :fxml.get_subtag(Packet, "end_session") do
        false ->
          :undefined

        xml ->
          header =
            case :proplists.get_value("result", xmlel(xml, :attrs)) do
              :undefined ->
                [{"result", "failed"}]

              res ->
                [{"result", res}]
            end

          headers = MessageProtobuf.Encode.encode_pb_stringheaders(header)

          Messagebody.new(headers: headers, value: "end_session")
      end

    id = :qtalk_public.get_xml_attrs_id(packet)
    struct_pb_iq_msg(%{
      from: from,
      to: to,
      type: :SignalTypeIQ,
      key: "result",
      value: "end_session",
      msg_id: id,
      body: body
    })
  end

  def encode_pb_ping(from, to, packet) do
    id = :qtalk_public.get_xml_attrs_id(packet)
    struct_pb_iq_msg(%{
      from: from,
      to: to,
      type: :SignalTypeIQ,
      key: "result",
      value: "ping",
      msg_id: id
    })
  end

  def encode_iq_result_pb_packet(statedata, from, to, packet) do
    case :qtalk_public.get_sub_xmlns_name(packet) do
      {"bind", "urn:ietf:params:xml:ns:xmpp-bind"} ->
        encode_pb_iq_bind_result(from, to, packet, statedata.key)

      {"query", "http://jabber.org/protocol/muc#user_mucs"} ->
        encode_user_muc_pb(from, to, packet)

      {"query", "http://jabber.org/protocol/create_muc"} ->
        encode_pb_iq_create_muc(from, to, packet)

      {"query", "http://jabber.org/protocol/muc#invite_v2"} ->
        encode_muc_invite_user_v2_pb(from, to, packet)

      {"query", "http://jabber.org/protocol/muc#register"} ->
        case :fxml.get_subtag(packet, "query") do
          false ->
            "error"

          query ->
            case :fxml.get_subtags(query, "m_user") == [] do
              true ->
                encode_pb_muc_user_register(from, to, packet)

              false ->
                encode_muc_user_pb(from, to, packet)
            end
        end

      {"query", "http://jabber.org/protocol/muc#del_register"} ->
        encode_pb_muc_user_del_register(from, to, packet)

      {"query", "http://jabber.org/protocol/muc#admin"} ->
        encode_pb_muc_amdin(from, to, packet)

      {"query", "http://jabber.org/protocol/muc#owner"} ->
        encode_pb_destroy_muc(from, to, packet)

      {"get_verify_friend_mode", "jabber:iq:verify_friend_mode"} ->
        encode_pb_get_friend_opt(from, to, packet)

      {"set_verify_friend_mode", "jabber:iq:verify_friend_mode"} ->
        encode_pb_set_friend_opt(from, to, packet)

      {"get_user_friends", "jabber:x:get_friend"} ->
        encode_pb_get_user_friends(from, to, packet)

      {"delete_friend", "jabber:x:delete_friend"} ->
        encode_pb_del_user_friend(from, to, packet)

      {"key", "urn:xmpp:key"} ->
        encode_pb_time_http_key(from, to, packet)

      {"query", "jabber:x:mask_user_v2"} ->
        encode_pb_get_mask_user(from, to, packet)

      {"query", "http://jabber.org/protocol/muc#muc_user_subscribe"} ->
        encode_pb_handle_user_subscribe(from, to, packet)

      {"query", "http://jabber.org/protocol/muc#muc_user_subscribe_v2"} ->
        encode_pb_handle_user_subscribe_v2(from, to, packet)

      {"mask_user", "jabber:x:mask_user"} ->
        encode_pb_set_mask_user(from, to, packet)

      {"cancel_mask_user", "jabber:x:mask_user"} ->
        encode_pb_cancel_mask_user(from, to, packet)

      {"virtual_user", "jabber:x:virtual_user"} ->
        encode_pb_get_virtual_user(from, to, packet)

      {"on_duty_virtual_user", "jabber:x:virtual_user"} ->
        encode_pb_get_vuser_role(from, to, packet)

      {"start_session", "jabber:x:virtual_user"} ->
        encode_pb_start_session(from, to, packet)

      {"end_session", "jabber:x:virtual_user"} ->
        encode_pb_end_session(from, to, packet)

      _ ->
        case :fxml.get_attr("type", xmlel(packet, :attrs)) do
          {:value, "result"} ->
            case xmlel(packet, :children) == [] do
              true ->
                encode_pb_ping(from, to, packet)

              false ->
                "error"
            end

          _ ->
            "error"
        end
    end
  end

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
    Iqmessage.encode(fpb_iq)
  end

  def handle_pb_iq_key(key, iq) do
    case set_iqkey_type(Key) do
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

  def encode_iq_error_pb_packet(from, to, packet) do
    body =
      case :fxml.get_subtag(packet, "error") do
        false ->
          :undefined

        error ->
          case :fxml.get_attr("code", xmlel(error, :attrs)) do
            false ->
              :undefined

            {:value, code} ->
              cdata = :fxml.get_subtag_cdata(error, "text")
              headers = [{"code", code}, {"data", cdata}]
              :ejabberd_xml2pb_public.encode_messagebody(headers, "error_info")
          end
      end

    id = :qtalk_public.get_xml_attrs_id(packet)

    struct_pb_iq_msg(%{
      from: from,
      to: to,
      type: :SignalTypeIQ,
      key: "error",
      msg_id: id,
      body: body
    })
  end

  def struct_pb_iq_msg(params) do
    from = Map.get(params, :from)
    to = Map.get(params, :to)
    type = Map.get(params, :type)
    key = Map.get(params, :key)
    val = Map.get(params, :val, "")
    msg_id = Map.get(params, :msg_id)
    header = Map.get(params, :header, nil)
    body = Map.get(params, :body, nil)
    headers = Map.get(params, :headers, [])
    bodys = Map.get(params, :bodys, [])

    iq = encode_pb_iq_msg(key, val, msg_id, header, body, headers, bodys)
    pb_msg = MessageProtobuf.Encode.encode_pb_protomessage(from, to, type, 0, iq)
    opt = MessageProtobuf.Encode.get_proto_header_opt(pb_msg)
    MessageProtobuf.Encode.encode_pb_protoheader(opt, pb_msg)
  end
end
