defmodule MessageProtobuf.Encode.Presence do
  import Xml
  require Logger

  def struct_pb_presence_msg(params) do
    Logger.debug("presence params: #{inspect(params)}")
    from = Map.get(params, :from)
    to = Map.get(params, :to)
    type = Map.get(params, :type)
    key = Map.get(params, :key, "result")
    val = Map.get(params, :value, "")
    msg_id = Map.get(params, :msg_id, "")
    header = Map.get(params, :header, nil)
    body = Map.get(params, :body, nil)
    headers = Map.get(params, :headers, [])
    bodys = Map.get(params, :bodys, [])

    definedkey =
      case Map.get(params, :definedkey, nil) do
        nil ->
          case key == "result" do
            true ->
              :PresenceKeyResult

            false ->
              nil
          end

        definedkeyvalue ->
          definedkeyvalue
      end

    catagory = Map.get(params, :category, nil)

    presence =
      Presencemessage.new(
        key: key,
        value: val,
        messageid: msg_id,
        header: header,
        body: body,
        receivedtime: :qtalk_public.get_timestamp(),
        headers: headers,
        bodys: bodys,
        categorytype: catagory,
        definedkey: definedkey
      )
      |> Presencemessage.encode()

    pb_msg = MessageProtobuf.Encode.encode_pb_protomessage(from, to, type, 0, presence)
    opt = MessageProtobuf.Encode.get_proto_header_opt(pb_msg)
    pb = MessageProtobuf.Encode.encode_pb_protoheader(opt, pb_msg)

    Logger.debug(
      "presence = #{inspect(presence, limit: :infinity)} iq = #{inspect(pb_msg, limit: :infinity)} pb = #{
        inspect(pb, limit: :infinity)
      } "
    )

    pb
  end

  def encode_presence_invite_muc(packet) do
    attrs = xmlel(packet, :attrs)
    jid = :proplists.get_value("invite_jid", attrs)
    status = :proplists.get_value("status", attrs)

    headers =
      [{"invite_jid", jid}, {"status", status}]
      |> MessageProtobuf.Encode.encode_pb_stringheaders()

    body = Messagebody.new(headers: headers, value: "invite_info")
    %{value: "invite_user", body: body}
  end

  def encode_del_muc_register(packet) do
    del_jid = :proplists.get_value("del_jid", xmlel(packet, :attrs))
    headers = [{"del_jid", del_jid}] |> MessageProtobuf.Encode.encode_pb_stringheaders()
    body = Messagebody.new(headers: headers, value: "del_muc_register")
    %{value: "del_muc_register", body: body}
  end

  def encode_set_user_subscribe_v2(packet) do
    subscribe = :fxml.get_subtag(packet, "subscribe_updte")
    status = :proplists.get_value("status", xmlel(subscribe, :attrs), "0")
    headers = [{"status", status}] |> MessageProtobuf.Encode.encode_pb_stringheaders()
    body = Messagebody.new(headers: headers, value: "subscribe_update")
    %{value: "subscribe_update", body: body}
  end

  def encode_update_muc_vcard(packet) do
    els = :fxml.get_subtag(packet, "vcard_updte")
    attrs = xmlel(els, :attrs)
    nick = :proplists.get_value("nick", attrs)
    desc = :proplists.get_value("desc", attrs)
    title = :proplists.get_value("title", attrs)
    pic = :proplists.get_value("pic", attrs)
    version = :proplists.get_value("version", attrs)

    headers =
      [
        {"nick", nick},
        {"desc", desc},
        {"title", title},
        {"pic", pic},
        {"version", version}
      ]
      |> MessageProtobuf.Encode.encode_pb_stringheaders()

    body = Messagebody.new(headers: headers, value: "update_muc_vcard")
    %{value: "update_muc_vcard", body: body}
  end

  def encode_manual_authentication_confirm(packet) do
    attrs = xmlel(packet, :attrs)
    friend_num = :proplists.get_value("friend_num", attrs, "")
    type = :proplists.get_value("type", attrs, "")
    reason = :proplists.get_value("reason", attrs, "")
    method = :proplists.get_value("method", attrs, "")
    body1 = :proplists.get_value("body", attrs, "")

    headers =
      [
        {"type", type},
        {"reason", reason},
        {"method", method},
        {"body", body1},
        {"friend_num", friend_num}
      ]
      |> MessageProtobuf.Encode.encode_pb_stringheaders()

    body = Messagebody.new(headers: headers, value: "verify_friend")
    %{key: "manual_authentication_confirm", value: "confirm_verify_friend", body: body}
  end

  def encode_verify_friend(packet) do
    attrs = xmlel(packet, :attrs)
    type = :proplists.get_value("type", attrs)
    rslt = :proplists.get_value("result", attrs, "")
    reason = :proplists.get_value("reason", attrs, "")
    method = :proplists.get_value("method", attrs, "")
    body1 = :proplists.get_value("body", attrs, "")

    headers =
      [
        {"type", type},
        {"result", rslt},
        {"reason", reason},
        {"method", method},
        {"body", body1}
      ]
      |> MessageProtobuf.Encode.encode_pb_stringheaders()

    body = Messagebody.new(headers: headers, value: "verify_friend")
    %{value: "verify_friend", body: body}
  end

  def encode_delete_friend(packet) do
    attrs = xmlel(packet, :attrs)
    type = :proplists.get_value("type", attrs, "")
    rslt = :proplists.get_value("result", attrs, "")
    jid = :proplists.get_value("jid", attrs, "")
    domain = :proplists.get_value("domain", attrs, "")

    headers =
      [{"type", type}, {"result", rslt}, {"jid", jid}, {"domain", domain}]
      |> MessageProtobuf.Encode.encode_pb_stringheaders()

    body = Messagebody.new(headers: headers, value: "delete_friend")
    %{value: "delete_friend", body: body}
  end

  def encode_mask_user(packet) do
    jid = :proplists.get_value("jid", xmlel(packet, :attrs), "")
    headers = [{"jid", jid}] |> MessageProtobuf.Encode.encode_pb_stringheaders()
    body = Messagebody.new(headers: headers, value: "mask_user")
    %{value: "mask_user", body: body}
  end

  def encode_cancel_mask_user(packet) do
    jid = :proplists.get_value("jid", xmlel(packet, :attrs), "")
    headers = [{"jid", jid}] |> MessageProtobuf.Encode.encode_pb_stringheaders()
    body = Messagebody.new(headers: headers, value: "cancel_mask_user")
    %{value: "cancel_mask_user", body: body}
  end

  def encode_presence_mask_user(packet) do
    case :fxml.get_subtag(packet, "mask_user") do
      false ->
        cancel_mask = :fxml.get_subtag(packet, "cancel_masked_user")
        encode_cancel_mask_user(cancel_mask)

      mask ->
        encode_mask_user(mask)
    end
  end

  def encode_presence_del_muc_user(packet) do
    els = :fxml.get_subtag(packet, "x")
    item = :fxml.get_subtag(els, "item")
    item_attrs = xmlel(item, :attrs)
    affiliation = :proplists.get_value("affiliation", item_attrs)
    role = :proplists.get_value("role", item_attrs)
    status = :fxml.get_subtag(els, "status")
    code = :proplists.get_value("code", xmlel(status, :attrs))

    headers =
      [{"affiliation", affiliation}, {"role", role}, {"code", code}]
      |> MessageProtobuf.Encode.encode_pb_stringheaders()

    body = Messagebody.new(headers: headers, value: "item")
    %{value: "del_muc_user", body: body}
  end

  def encode_presence_muc_destory(packet) do
    els = :fxml.get_subtag(packet, "x")
    item = :fxml.get_subtag(els, "item")
    item_attrs = xmlel(item, :attrs)
    affiliation = :proplists.get_value("affiliation", item_attrs)
    role = :proplists.get_value("role", item_attrs)

    headers =
      [{"affiliation", affiliation}, {"role", role}]
      |> MessageProtobuf.Encode.encode_pb_stringheaders()

    body = Messagebody.new(headers: headers, value: "item")
    %{value: "destory_muc", body: body}
  end

  def encode_presence_muc_notice_add_user(packet) do
    els = :fxml.get_subtag(packet, "x")
    item = :fxml.get_subtag(els, "item")
    item_attrs = xmlel(item, :attrs)
    real_jid = :proplists.get_value("real_jid", item_attrs, "")
    jid = :proplists.get_value("jid", item_attrs, real_jid)
    affiliation = :proplists.get_value("affiliation", item_attrs)
    domain = :proplists.get_value("domain", item_attrs)

    headers =
      [
        {"jid", :qtalk_public.tokens_jid(jid)},
        {"affiliation", affiliation},
        {"domain", domain}
      ]
      |> MessageProtobuf.Encode.encode_pb_stringheaders()

    body = Messagebody.new(headers: headers, value: "user_info")
    %{value: "user_join_muc", body: body}
  end

  def encode_x_user_packet(packet) do
    case :fxml.get_attr_s("type", xmlel(packet, :attrs)) do
      "unavailable" ->
        packet1 = :fxml.get_subtag(packet, "x")

        case :fxml.get_subtag(packet1, "destroy") == false do
          true ->
            encode_presence_del_muc_user(packet)

          false ->
            encode_presence_muc_destory(packet)
        end

      _ ->
        encode_presence_muc_notice_add_user(packet)
    end
  end

  def encode_notify_presence(packet) do
    attrs = xmlel(packet, :attrs)
    data = :proplists.get_value("data", attrs, "")
    category = :proplists.get_value("category", attrs, "1") |> String.to_integer()
    body = Messagebody.new(value: data)

    %{
      value: "notify",
      body: body,
      definedkey: :PresenceKeyNotify,
      category: category
    }
  end

  def enocde_status(packet) do
    show = :fxml.get_subtag_cdata(packet, "show")
    priority = :fxml.get_subtag_cdata(packet, "priority")

    headers =
      [{"show", show}, {"priority", priority}] |> MessageProtobuf.Encode.encode_pb_stringheaders()

    body = Messagebody.new(headers: headers, value: "user_update_status")
    %{value: "update_user_status", body: body}
  end

  def xml2pb_presence(from, to, packet) do
    ns = :fxml.get_attr_s("xmlns", xmlel(packet, :attrs))

    case xml2pb_presence_ns(ns, packet) do
      "error" ->
        Logger.debug("encode presence error #{inspect(packet)}")
        "error"

      params ->
        Map.merge(%{from: from, to: to, type: :SignalTypePresence}, params)
        |> struct_pb_presence_msg
    end
  end

  @muc_invite "http://jabber.org/protocol/muc#invite"
  @muc_del_register "http://jabber.org/protocol/muc#del_register"
  @muc_user_subscribe_v2 "http://jabber.org/protocol/muc#muc_user_subscribe_v2"
  @muc_vcard_update "http://jabber.org/protocol/muc#vcard_update"
  @verify_friend "jabber:x:verify_friend"
  @invite_rslt "http://jabber.org/protocol/user#invite_rslt"
  @delete_friend "jabber:x:delete_friend"
  @mask_user "jabber:x:mask_user"
  @muc_user "http://jabber.org/protocol/muc#user"
  @muc_owner "http://jabber.org/protocol/muc#owner"
  @presence_notify "jabber:x:presence_notify"

  def xml2pb_presence_ns(@muc_invite, packet),
    do: encode_presence_invite_muc(packet)

  def xml2pb_presence_ns(@muc_del_register, packet),
    do: encode_del_muc_register(packet)

  def xml2pb_presence_ns(@muc_user_subscribe_v2, packet),
    do: encode_set_user_subscribe_v2(packet)

  def xml2pb_presence_ns(@muc_vcard_update, packet),
    do: encode_update_muc_vcard(packet)

  def xml2pb_presence_ns(@verify_friend, packet) do
    attrs = xmlel(packet, :attrs)

    case :proplists.get_value("result", attrs, :undefined) do
      :undefined ->
        case :proplists.get_value("method", attrs) == "manual_authentication_confirm" do
          true ->
            encode_manual_authentication_confirm(packet)

          false ->
            "error"
        end

      _ ->
        encode_verify_friend(packet)
    end
  end

  def xml2pb_presence_ns(@invite_rslt, packet),
    do: encode_verify_friend(packet)

  def xml2pb_presence_ns(@delete_friend, packet),
    do: encode_delete_friend(packet)

  def xml2pb_presence_ns(@mask_user, packet),
    do: encode_presence_mask_user(packet)

  def xml2pb_presence_ns("", packet) do
    case :qtalk_public.get_sub_xmlns_name(packet) do
      {"x", @muc_user} ->
        case :fxml.get_attr("type", xmlel(packet, :attrs)) do
          false ->
            "error"

          _ ->
            encode_x_user_packet(packet)
        end

      {"query", @muc_owner} ->
        encode_update_muc_vcard(packet)

      {"notify", @presence_notify} ->
        encode_notify_presence(packet)

      _ ->
        case :fxml.get_subtag(packet, "show") do
          false ->
            "error"

          _ ->
            enocde_status(packet)
        end
    end
  end
end
