defmodule MessageProtobuf.Encode.Presence do
  import Xml
  require Logger

  def set_presencekey_type("result"), do: :PresenceKeyResult
  def set_presencekey_type(_), do: :none

  def encode_pb_presence_msg(
        key,
        val,
        msg_id,
        header,
        body,
        headers,
        bodys,
        definedkey,
        categorytype
      ) do
    presence_pb =
      Presencemessage.new(
        key: key,
        value: val,
        messageid: msg_id,
        header: header,
        body: body,
        receivedtime: :qtalk_public.get_timestamp(),
        headers: headers,
        bodys: bodys,
        categorytype: categorytype,
        definedkey: definedkey
      )

    presence_pb =
      case set_presencekey_type(key) do
        :none ->
          presence_pb

        presence_type ->
          %{presence_pb | definedkey: presence_type}
      end

    presence_pb |> Presencemessage.encode()
  end

  def struct_pb_presence_msg(
        from,
        to,
        type,
        key,
        val,
        msg_id,
        header,
        body,
        haeders,
        bodys,
        definedkey \\ "",
        catagory \\ ""
      ) do
    presence =
      encode_pb_presence_msg(key, val, msg_id, header, body, haeders, bodys, definedkey, catagory)

    pb_msg = MessageProtobuf.Encode.encode_pb_protomessage(from, to, type, 0, presence)
    opt = MessageProtobuf.Encode.get_proto_header_opt(pb_msg)
    MessageProtobuf.Encode.encode_pb_protoheader(opt, pb_msg)
  end

  def encode_presence_invite_muc(from, to, packet) do
    attrs = xmlel(packet, :attrs)
    jid = :proplists.get_value("invite_jid", attrs)
    status = :proplists.get_value("status", attrs)

    headers =
      MessageProtobuf.Encode.encode_pb_stringheaders([{"invite_jid", jid}, {"status", status}])

    msg_body = Messagebody.new(headers: headers, value: "invite_info")

    struct_pb_presence_msg(
      from,
      to,
      :SignalTypePresence,
      "result",
      "invite_user",
      "",
      :undefined,
      msg_body,
      [],
      []
    )
  end

  def encode_del_muc_register(from, to, packet) do
    del_jid = :proplists.get_value("del_jid", xmlel(packet, :attrs))
    headers = [{"del_jid", del_jid}]
    body = Messagebody.new(headers: headers, value: "del_muc_register")

    struct_pb_presence_msg(
      from,
      to,
      :SignalTypePresence,
      "result",
      "del_muc_register",
      "",
      :undefined,
      body,
      [],
      []
    )
  end

  def encode_set_user_subscribe_v2(from, to, packet) do
    subscribe = :fxml.get_subtag(packet, "subscribe_updte")
    status = :proplists.get_value("status", xmlel(subscribe, :attrs), "0")
    headers = [{"status", status}]
    body = Messagebody.new(headers: headers, value: "subscribe_update")

    struct_pb_presence_msg(
      from,
      to,
      :SignalTypePresence,
      "result",
      "subscribe_update",
      "",
      :undefined,
      body,
      [],
      []
    )
  end

  def encode_update_muc_vcard(from, to, packet) do
    els = :fxml.get_subtag(packet, "vcard_updte")
    attrs = xmlel(els, :attrs)
    nick = :proplists.get_value("nick", attrs)
    desc = :proplists.get_value("desc", attrs)
    title = :proplists.get_value("title", attrs)
    pic = :proplists.get_value("pic", attrs)
    version = :proplists.get_value("version", attrs)

    headers = [
      {"nick", nick},
      {"desc", desc},
      {"title", title},
      {"pic", pic},
      {"version", version}
    ]

    body = Messagebody.new(headers: headers, value: "update_muc_vcard")

    struct_pb_presence_msg(
      from,
      to,
      :SignalTypePresence,
      "result",
      "update_muc_vcard",
      "",
      :undefined,
      body,
      [],
      []
    )
  end

  def encode_manual_authentication_confirm(from, to, packet) do
    attrs = xmlel(packet, :attrs)
    friend_num = :proplists.get_value("friend_num", attrs, "")
    type = :proplists.get_value("type", attrs, "")
    reason = :proplists.get_value("reason", attrs, "")
    method = :proplists.get_value("method", attrs, "")
    body1 = :proplists.get_value("body", attrs, "")

    headers = [
      {"type", type},
      {"reason", reason},
      {"method", method},
      {"body", body1},
      {"friend_num", friend_num}
    ]

    body = Messagebody.new(headers: headers, value: "verify_friend")

    struct_pb_presence_msg(
      from,
      to,
      :SignalTypePresence,
      "manual_authentication_confirm",
      "confirm_verify_friend",
      "",
      :undefined,
      body,
      [],
      []
    )
  end

  def encode_verify_friend(from, to, packet) do
    attrs = xmlel(packet, :attrs)
    type = :proplists.get_value("type", attrs)
    rslt = :proplists.get_value("result", attrs, "")
    reason = :proplists.get_value("reason", attrs, "")
    method = :proplists.get_value("method", attrs, "")
    body1 = :proplists.get_value("body", attrs, "")

    headers = [
      {"type", type},
      {"result", rslt},
      {"reason", reason},
      {"method", method},
      {"body", body1}
    ]

    body = Messagebody.new(headers: headers, value: "verify_friend")

    struct_pb_presence_msg(
      from,
      to,
      :SignalTypePresence,
      "result",
      "verify_friend",
      "",
      :undefined,
      body,
      [],
      []
    )
  end

  def encode_delete_friend(from, to, packet) do
    attrs = xmlel(packet, :attrs)
    type = :proplists.get_value("type", attrs, "")
    rslt = :proplists.get_value("result", attrs, "")
    jid = :proplists.get_value("jid", attrs, "")
    domain = :proplists.get_value("domain", attrs, "")
    headers = [{"type", type}, {"result", rslt}, {"jid", jid}, {"domain", domain}]
    body = Messagebody.new(headers: headers, value: "delete_friend")

    struct_pb_presence_msg(
      from,
      to,
      :SignalTypePresence,
      "result",
      "delete_friend",
      "",
      :undefined,
      body,
      [],
      []
    )
  end

  def encode_mask_user(from, to, packet) do
    jid = :proplists.get_value("jid", xmlel(packet, :attrs), "")
    headers = [{"jid", jid}]
    body = Messagebody.new(headers: headers, value: "mask_user")

    struct_pb_presence_msg(
      from,
      to,
      :SignalTypePresence,
      "result",
      "mask_user",
      "",
      :undefined,
      body,
      [],
      []
    )
  end

  def encode_cancel_mask_user(from, to, packet) do
    jid = :proplists.get_value("jid", xmlel(packet, :attrs), "")
    headers = [{"jid", jid}]
    body = Messagebody.new(headers: headers, value: "cancel_mask_user")

    struct_pb_presence_msg(
      from,
      to,
      :SignalTypePresence,
      "result",
      "cancel_mask_user",
      "",
      :undefined,
      body,
      [],
      []
    )
  end

  def encode_presence_mask_user(from, to, packet) do
    case :fxml.get_subtag(packet, "mask_user") do
      false ->
        cancel_mask = :fxml.get_subtag(packet, "cancel_masked_user")
        encode_cancel_mask_user(from, to, cancel_mask)

      mask ->
        encode_mask_user(from, to, mask)
    end
  end

  def encode_presence_del_muc_user(from, to, packet) do
    els = :fxml.get_subtag(packet, "x")
    item = :fxml.get_subtag(els, "item")
    item_attrs = xmlel(item, :attrs)
    affiliation = :proplists.get_value("affiliation", item_attrs)
    role = :proplists.get_value("role", item_attrs)
    status = :fxml.get_subtag(els, "status")
    code = :proplists.get_value("code", xmlel(status, :attrs))

    headers = [{"affiliation", affiliation}, {"role", role}, {"code", code}]
    body = Messagebody.new(headers: headers, value: "item")

    struct_pb_presence_msg(
      from,
      to,
      :SignalTypePresence,
      "result",
      "del_muc_user",
      "",
      :undefined,
      body,
      [],
      []
    )
  end

  def encode_presence_muc_destory(from, to, packet) do
    els = :fxml.get_subtag(packet, "x")
    item = :fxml.get_subtag(els, "item")
    item_attrs = xmlel(item, :attrs)
    affiliation = :proplists.get_value("affiliation", item_attrs)
    role = :proplists.get_value("role", item_attrs)

    headers = [{"affiliation", affiliation}, {"role", role}]
    body = Messagebody.new(headers: headers, value: "item")

    struct_pb_presence_msg(
      from,
      to,
      :SignalTypePresence,
      "result",
      "destory_muc",
      "",
      :undefined,
      body,
      [],
      []
    )
  end

  def encode_presence_muc_notice_add_user(from, to, packet) do
    els = :fxml.get_subtag(packet, "x")
    item = :fxml.get_subtag(els, "item")
    item_attrs = xmlel(item, :attrs)
    real_jid = :proplists.get_value("real_jid", item_attrs, "")
    jid = :proplists.get_value("jid", item_attrs, real_jid)
    affiliation = :proplists.get_value("affiliation", item_attrs)
    domain = :proplists.get_value("domain", item_attrs)

    headers = [
      {"jid", :qtalk_public.tokens_jid(jid)},
      {"affiliation", affiliation},
      {"domain", domain}
    ]

    body = Messagebody.new(headers: headers, value: "user_info")

    struct_pb_presence_msg(
      from,
      to,
      :SignalTypePresence,
      "result",
      "user_join_muc",
      "",
      :undefined,
      body,
      [],
      []
    )
  end

  def encode_x_user_packet(from, to, packet) do
    case :fxml.get_attr_s("type", xmlel(packet, :attrs)) do
      "unavailable" ->
        packet1 = :fxml.get_subtag(packet, "x")

        case :fxml.get_subtag(packet1, "destroy") == false do
          true ->
            encode_presence_del_muc_user(from, to, packet)

          false ->
            encode_presence_muc_destory(from, to, packet)
        end

      _ ->
        encode_presence_muc_notice_add_user(from, to, packet)
    end
  end

  def encode_notify_presence(from, to, packet) do
    attrs = xmlel(packet, :attrs)
    data = :proplists.get_value("data", attrs, "")
    category = :proplists.get_value("category", attrs, "1") |> String.to_integer()
    body = Messagebody.new(value: data)

    struct_pb_presence_msg(
      from,
      to,
      :SignalTypePresence,
      "result",
      "notify",
      "",
      :undefined,
      body,
      [],
      [],
      :PresenceKeyNotify,
      category
    )
  end

  def enocde_status(from, to, packet) do
    show = :fxml.get_subtag_cdata(packet, "show")
    priority = :fxml.get_subtag_cdata(packet, "priority")
    headers = [{"show", show}, {"priority", priority}]
    body = Messagebody.new(headers: headers, value: "user_update_status")

    struct_pb_presence_msg(
      from,
      to,
      :SignalTypePresence,
      "result",
      "update_user_status",
      "",
      :undefined,
      body,
      [],
      []
    )
  end

  def xml2pb_presence(from, to, packet) do
    case :fxml.get_attr_s("xmlns", xmlel(packet, :attrs)) do
      "http://jabber.org/protocol/muc#invite" ->
        encode_presence_invite_muc(from, to, packet)

      "http://jabber.org/protocol/muc#del_register" ->
        encode_del_muc_register(from, to, packet)

      "http://jabber.org/protocol/muc#muc_user_subscribe_v2" ->
        encode_set_user_subscribe_v2(from, to, packet)

      "http://jabber.org/protocol/muc#vcard_update" ->
        encode_update_muc_vcard(from, to, packet)

      "jabber:x:verify_friend" ->
        attrs = xmlel(packet, :attrs)

        case :proplists.get_value("result", attrs, :undefined) do
          :undefined ->
            case :proplists.get_value("method", attrs) == "manual_authentication_confirm" do
              true ->
                encode_manual_authentication_confirm(from, to, packet)

              false ->
                "error"
            end

          _ ->
            encode_verify_friend(from, to, packet)
        end

      "http://jabber.org/protocol/user#invite_rslt" ->
        encode_verify_friend(from, to, packet)

      "jabber:x:delete_friend" ->
        encode_delete_friend(from, to, packet)

      "jabber:x:mask_user" ->
        encode_presence_mask_user(from, to, packet)

      "" ->
        case :qtalk_public.get_sub_xmlns_name(packet) do
          {"x", "http://jabber.org/protocol/muc#user"} ->
            case :fxml.get_attr("type", xmlel(packet, :attrs)) do
              false ->
                :ok

              _ ->
                encode_x_user_packet(from, to, packet)
            end

          {"query", "http://jabber.org/protocol/muc#owner"} ->
            encode_update_muc_vcard(from, to, packet)

          {"notify", "jabber:x:presence_notify"} ->
            encode_notify_presence(from, to, packet)

          _ ->
            case :fxml.get_subtag(packet, "show") do
              false ->
                "error"

              _ ->
                enocde_status(from, to, packet)
            end
        end
    end
  end
end
