defmodule MessageProtobuf.Encode.Iq do
  import Xml
  require Logger

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
          time = :qtalk_public.get_timestamp() |> Integer.to_string()
          headers = [{"time_value", time}, {"key_value", key}]
          Messagebody.new(headers: headers, value: cdata)
      end

    id = :qtalk_public.get_xml_attrs_id(packet)
    struct_pb_iq_msg(from, to, :SignalTypeIQ, "result", "bind", id, :undefined, body, [], [])
  end

  def get_pb_iq_user_mucs_bodys(packet) do
        case fxml:get_subtag(Packet,<<"query">>) of
        false ->
            ?INFO_MSG("get_pb_iq_user_mucs_bodys1 ~p ~n",[Packet]),
            [];
        Query ->
            Mucs = fxml:get_subtags(Query,<<"muc_rooms">>),
            Bodys =	lists:flatmap(fun(Xml) ->
                  Headers =
                     case is_record(Xml,xmlel) of
                     true ->
                    Host = proplists:get_value(<<"host">>,Xml#xmlel.attrs, qtalk_public:get_default_domain()),
                        case proplists:get_value(<<"name">>,Xml#xmlel.attrs) of
                        undefined ->
                            ?INFO_MSG("get_pb_iq no found name ~n",[]),
                            [];
                        Name ->
                            [{<<"name">>,Name},
                             {<<"host">>,Host}]
                        end;
                    _ ->
                        ?INFO_MSG("get_pb_iq_user_mucs_bodys ~p ~n",[Packet]),
                        []
                    end,
               [ejabberd_xml2pb_public:encode_messagebody(Headers,<<"muc_room">>)] end,Mucs),
            Bodys
        end.

  def encode_user_muc_pb(from,to,packet) do
    bodys = get_pb_iq_user_mucs_bodys(packet),
      ID = case  fxml:get_attr(<<"id">>,Packet#xmlel.attrs) of
      false ->
              integer_to_binary(qtalk_public:timestamp());
      {_, I} ->
              I
      end,
    struct_pb_iq_msg(From,To,'SignalTypeIQ',<<"result">>,<<"user_mucs">>,ID,'undefined','undefined',[],Bodys)
    end


  def encode_iq_result_pb_packet(statedata, from, to, packet) do
    case :qtalk_public.get_sub_xmlns_name(packet) do
      {"bind", "urn:ietf:params:xml:ns:xmpp-bind"} ->
        encode_pb_iq_bind_result(from, to, packet, statedata.key)

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

  def struct_pb_iq_msg(from, to, type, key, val, msg_id, header, body, haeders, bodys) do
    iq = encode_pb_iq_msg(key, val, msg_id, header, body, haeders, bodys)
    pb_msg = MessageProtobuf.Encode.encode_pb_protomessage(from, to, type, 0, iq)
    opt = MessageProtobuf.Encode.get_proto_header_opt(pb_msg)
    MessageProtobuf.Encode.encode_pb_protoheader(opt, pb_msg)
  end
end
