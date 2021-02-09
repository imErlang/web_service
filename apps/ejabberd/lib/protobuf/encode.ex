defmodule MessageProtobuf.Encode do
  import Xml

  def get_xml_attrs_to(packet, dt) do
    try do
      {_, to} = :fxml.get_attr("to", xmlel(packet, :attrs))
      to
    catch
      _ ->
        :jlib.jid_to_string(:jlib.make_jid(dt))
    end
  end

  def get_xml_attrs_from(packet, df) do
    try do
      {_, from} = :fxml.get_attr("from", xmlel(packet, :attrs))
      from
    catch
      _ ->
        :jlib.jid_to_string(:jlib.make_jid(df))
    end
  end

  def send_probuf_msg(statedata, packet) do
    to = get_xml_attrs_to(packet, {statedata.user, statedata.server, statedata.resource})
    from = get_xml_attrs_from(packet, {statedata.user, statedata.server, statedata.resource})
    do_send_probuf_msg(statedata, from, to, packet)
  end

  def do_send_probuf_msg(statedata, from, to, packet) do
    type = xmlel(packet, :name)
    do_send_probuf_msg(type, statedata, from, to, packet)
  end

  def encode_iq_result_pb_packet(statedata, from, to, packet) do
    case :qtalk_public.get_sub_xmlns_name(packet) do
      {"bind", "urn:ietf:params:xml:ns:xmpp-bind"} ->
        :ejabberd_xml2pb_iq.encode_pb_iq_bind_result(from, to, packet, statedata.key)

      {"query", "http://jabber.org/protocol/muc#user_mucs"} ->
        :ejabberd_xml2pb_iq.encode_user_muc_pb(from, to, packet)

      {"query", "http://jabber.org/protocol/create_muc"} ->
        :ejabberd_xml2pb_iq.encode_pb_iq_create_muc(from, to, packet)

      {"query", "http://jabber.org/protocol/muc#invite_v2"} ->
        :ejabberd_xml2pb_iq.encode_muc_invite_user_v2_pb(from, to, packet)

      {"query", "http://jabber.org/protocol/muc#register"} ->
        case :fxml.get_subtag(packet, "query") do
          false ->
            "error"

          query ->
            case :fxml.get_subtags(query, "m_user") == [] do
              true ->
                :ejabberd_xml2pb_iq.encode_pb_muc_user_register(from, to, packet)

              false ->
                :ejabberd_xml2pb_iq.encode_muc_user_pb(from, to, packet)
            end
        end

      {"query", "http://jabber.org/protocol/muc#del_register"} ->
        :ejabberd_xml2pb_iq.encode_pb_muc_user_del_register(from, to, packet)

      {"query", "http://jabber.org/protocol/muc#admin"} ->
        :ejabberd_xml2pb_iq.encode_pb_muc_amdin(from, to, packet)

      {"query", "http://jabber.org/protocol/muc#owner"} ->
        :ejabberd_xml2pb_iq.encode_pb_destroy_muc(from, to, packet)

      {"get_verify_friend_mode", "jabber:iq:verify_friend_mode"} ->
        :ejabberd_xml2pb_iq.encode_pb_get_friend_opt(from, to, packet)

      {"set_verify_friend_mode", "jabber:iq:verify_friend_mode"} ->
        :ejabberd_xml2pb_iq.encode_pb_set_friend_opt(from, to, packet)

      {"get_user_friends", "jabber:x:get_friend"} ->
        :ejabberd_xml2pb_iq.encode_pb_get_user_friends(from, to, packet)

      {"delete_friend", "jabber:x:delete_friend"} ->
        :ejabberd_xml2pb_iq.encode_pb_del_user_friend(from, to, packet)

      {"key", "urn:xmpp:key"} ->
        :ejabberd_xml2pb_iq.encode_pb_time_http_key(from, to, packet)

      {"query", "jabber:x:mask_user_v2"} ->
        :ejabberd_xml2pb_iq.encode_pb_get_mask_user(from, to, packet)

      {"query", "http://jabber.org/protocol/muc#muc_user_subscribe"} ->
        :ejabberd_xml2pb_iq.encode_pb_handle_user_subscribe(from, to, packet)

      {"query", "http://jabber.org/protocol/muc#muc_user_subscribe_v2"} ->
        :ejabberd_xml2pb_iq.encode_pb_handle_user_subscribe_v2(from, to, packet)

      {"mask_user", "jabber:x:mask_user"} ->
        :ejabberd_xml2pb_iq.encode_pb_set_mask_user(from, to, packet)

      {"cancel_mask_user", "jabber:x:mask_user"} ->
        :ejabberd_xml2pb_iq.encode_pb_cancel_mask_user(from, to, packet)

      {"virtual_user", "jabber:x:virtual_user"} ->
        :ejabberd_xml2pb_iq.encode_pb_get_virtual_user(from, to, packet)

      {"on_duty_virtual_user", "jabber:x:virtual_user"} ->
        :ejabberd_xml2pb_iq.encode_pb_get_vuser_role(from, to, packet)

      {"start_session", "jabber:x:virtual_user"} ->
        :ejabberd_xml2pb_iq.encode_pb_start_session(from, to, packet)

      {"end_session", "jabber:x:virtual_user"} ->
        :ejabberd_xml2pb_iq.encode_pb_end_session(from, to, packet)

      _ ->
        case :fxml.get_attr("type", xmlel(packet, :attrs)) do
          {:value, "result"} ->
            case xmlel(packet, :children) == [] do
              true ->
                :ejabberd_xml2pb_iq.encode_pb_ping(from, to, packet)

              false ->
                "error"
            end

          _ ->
            "error"
        end
    end
  end

  def encode_iq_pb_packet(statedata, from, to, packet) do
    case :fxml.get_attr("type", xmlel(packet, :attrs)) do
      {:value, "error"} ->
        encode_iq_error_pb_packet(from, to, packet)

      _ ->
        encode_iq_result_pb_packet(statedata, from, to, packet)
    end
  end

  def encode_pb_iq_msg(key, val, msg_id, header, body, headers, bodys) do
    recv_time = :qtalk_public.get_timestamp()

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

  def encode_pb_protomessage(
        from,
        to,
        type,
        opts,
        msg,
        realfrom \\ "",
        realto \\ "",
        originfrom \\ "",
        originto \\ "",
        origintype \\ "",
        sendjid \\ ""
      ) do
    Protomessage.new(
      options: opts,
      signaltype: type,
      from: from,
      to: to,
      realfrom: realfrom,
      realto: realto,
      originfrom: originfrom,
      originto: originto,
      origintype: origintype,
      sendjid: sendjid,
      message: msg
    )
    |> Protomessage.encode()
  end

  def get_proto_header_opt(pro_msg) do
    case :erlang.size(pro_msg) > 200 do
      true ->
        1

      false ->
        5
    end
  end

  def encode_pb_protoheader(opt, pro_msg) do
    msg =
      case opt do
        1 -> :zlib.gzip(pro_msg)
        5 -> :tea_crypto.encrypt(pro_msg, <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>>)
        _ -> pro_msg
      end

    Protoheader.new(options: opt, message: msg) |> Protoheader.encode()
  end

  def struct_pb_iq_msg(from, to, type, key, val, msg_id, header, body, haeders, bodys) do
    iq = encode_pb_iq_msg(key, val, msg_id, header, body, haeders, bodys)
    pb_msg = encode_pb_protomessage(from, to, type, 0, iq)
    opt = get_proto_header_opt(pb_msg)
    encode_pb_protoheader(opt, pb_msg)
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

    struct_pb_iq_msg(
      from,
      to,
      :SignalTypeIQ,
      "error",
      :undefined,
      id,
      :undefined,
      body,
      [],
      []
    )
  end

  def set_header_definedkey("chatid"), do: :StringHeaderTypeChatId
  def set_header_definedkey("channelid"), do: :StringHeaderTypeChannelId
  def set_header_definedkey("extendInfo"), do: :StringHeaderTypeExtendInfo
  def set_header_definedkey("backupinfo"), do: :StringHeaderTypeBackupInfo
  def set_header_definedkey("read_type"), do: :StringHeaderTypeReadType
  def set_header_definedkey("jid"), do: :StringHeaderTypeJid
  def set_header_definedkey("real_jid"), do: :StringHeaderTypeRealJid
  def set_header_definedkey("invite_jid"), do: :StringHeaderTypeInviteJid
  def set_header_definedkey("del_jid"), do: :StringHeaderTypeDeleleJid
  def set_header_definedkey("nick"), do: :StringHeaderTypeNick
  def set_header_definedkey("title"), do: :StringHeaderTypeTitle
  def set_header_definedkey("pic"), do: :StringHeaderTypePic
  def set_header_definedkey("version"), do: :StringHeaderTypeVersion
  def set_header_definedkey("method"), do: :StringHeaderTypeMethod
  def set_header_definedkey("body"), do: :StringHeaderTypeBody
  def set_header_definedkey("affiliation"), do: :StringHeaderTypeAffiliation
  def set_header_definedkey("type"), do: :StringHeaderTypeType
  def set_header_definedkey("result"), do: :StringHeaderTypeResult
  def set_header_definedkey("reason"), do: :StringHeaderTypeReason
  def set_header_definedkey("role"), do: :StringHeaderTypeRole
  def set_header_definedkey("domain"), do: :StringHeaderTypeDomain
  def set_header_definedkey("status"), do: :StringHeaderTypeStatus
  def set_header_definedkey("code"), do: :StringHeaderTypeCode
  def set_header_definedkey("cdata"), do: :StringHeaderTypeCdata
  def set_header_definedkey("time_value"), do: :StringHeaderTypeTimeValue
  def set_header_definedkey("key_value"), do: :StringHeaderTypeKeyValue
  def set_header_definedkey("name"), do: :StringHeaderTypeName
  def set_header_definedkey("host"), do: :StringHeaderTypeHost
  def set_header_definedkey("question"), do: :StringHeaderTypeQuestion
  def set_header_definedkey("answer"), do: :StringHeaderTypeAnswer
  def set_header_definedkey("friends"), do: :StringHeaderTypeFriends
  def set_header_definedkey("value"), do: :StringHeaderTypeValue
  def set_header_definedkey("masked_user"), do: :StringHeaderTypeMaskedUuser
  def set_header_definedkey("key"), do: :StringHeaderTypeKey
  def set_header_definedkey("mode"), do: :StringHeaderTypeMode
  def set_header_definedkey("carbon_message"), do: :StringHeaderTypeCarbon
  def set_header_definedkey(_), do: :none

  def encode_pb_stringheader([]), do: []
  def encode_pb_stringheader({_, ""}), do: []
  def encode_pb_stringheader({"", _}), do: []
  def encode_pb_stringheader({_, :undefined}), do: []

  def encode_pb_stringheader({k, v}) do
    case set_header_definedkey(k) do
      :none -> [Stringheader.new(key: k, value: v)]
      dv -> [Stringheader.new(key: dv, value: v)]
    end
  end

  def encode_pb_stringheaders(headers) do
    headers
    |> Enum.flat_map(fn header ->
      encode_pb_stringheader(header)
    end)
  end

  def do_send_probuf_msg("iq", statedata, from, to, packet) do
    pb_iq = encode_iq_pb_packet(statedata, from, to, packet)

    case pb_iq == :undefined do
      true ->
        :undefined

      false ->
        :ejabberd_encode_protobuf.uint32_pack(byte_size(pb_iq), pb_iq)
    end
  end

  def pack(pb_msg) do
    :ejabberd_encode_protobuf.uint32_pack(byte_size(pb_msg), pb_msg)
  end

  def do_send_probuf_msg("message", _statedata, from, to, packet) do
    pb_msg = :ejabberd_xml2pb_message.xml2pb_msg(from, to, packet)
    MessageProtobuf.Encode.Message.xml2pb_msg(from, to, packet)
  end

  def do_send_probuf_msg("presence", statedata, from, to, packet) do
    pb_presence =
      case :fxml.get_attr_s("xmlns", xmlel(packet, :attrs)) do
        "http://jabber.org/protocol/muc#invite" ->
          :ejabberd_xml2pb_presence.encode_presence_invite_muc(from, to, packet)

        "http://jabber.org/protocol/muc#del_register" ->
          :ejabberd_xml2pb_presence.encode_del_muc_register(from, to, packet)

        "http://jabber.org/protocol/muc#muc_user_subscribe_v2" ->
          :ejabberd_xml2pb_presence.encode_set_user_subscribe_v2(from, to, packet)

        "http://jabber.org/protocol/muc#vcard_update" ->
          :ejabberd_xml2pb_presence.encode_update_muc_vcard(from, to, packet)

        "jabber:x:verify_friend" ->
          case :proplists.get_value("result", xmlel(packet, :attrs)) do
            :undefined ->
              case :proplists.get_value("method", xmlel(packet, :attrs)) do
                "manual_authentication_confirm" ->
                  :ejabberd_xml2pb_presence.encode_manual_authentication_confirm(
                    from,
                    to,
                    packet
                  )

                _ ->
                  "error"
              end

            _ ->
              :ejabberd_xml2pb_presence.encode_verify_friend(from, to, packet)
          end

        "http://jabber.org/protocol/user#invite_rslt" ->
          case :proplists.get_value("result", xmlel(packet, :attrs)) do
            :undefined ->
              "error"

            _ ->
              :ejabberd_xml2pb_presence.encode_verify_friend(from, to, packet)
          end

        "jabber:x:delete_friend" ->
          :ejabberd_xml2pb_presence.encode_delete_friend(from, to, packet)

        "jabber:x:mask_user" ->
          :ejabberd_xml2pb_presence.encode_presence_mask_user(from, to, packet)

        "" ->
          case :qtalk_public.get_sub_xmlns_name(packet) do
            {"x", "http://jabber.org/protocol/muc#user"} ->
              case :fxml.get_attr("type", xmlel(packet, :attrs)) do
                "unavailable" ->
                  :ok

                _ ->
                  :ejabberd_xml2pb_presence.encode_x_user_packet(from, to, packet)
              end

            {"query", "http://jabber.org/protocol/muc#owner"} ->
              :ejabberd_xml2pb_presence.encode_update_muc_vcard(from, to, packet)

            {"notify", "jabber:x:presence_notify"} ->
              :ejabberd_xml2pb_presence.encode_notify_presence(from, to, packet)

            _ ->
              case :fxml.get_subtag(packet, "show") do
                false ->
                  "error"

                _ ->
                  :ejabberd_xml2pb_presence.enocde_status(from, to, packet)
              end
          end
      end

    case pb_presence do
      "error" ->
        :ok

      _ ->
        :ejabberd_encode_protobuf.uint32_pack(byte_size(pb_presence), pb_presence)
    end
  end
end
