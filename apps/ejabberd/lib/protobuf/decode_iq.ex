defmodule MessageProtobuf.Decode.IQ do
  @moduledoc """
  protobuf decode protobuf and translate it to xml
  """

  import Xml

  def parse_iq(pb_msg) do
    iq_msg = Iqmessage.decode(pb_msg.message)

    iq_key =
      case get_iqkey_type(iq_msg.definedkey) do
        :undefined ->
          iq_msg.key

        key ->
          key
      end

    make_iq_message(
      iq_key,
      iq_msg.value,
      pb_msg.from,
      pb_msg.to,
      pb_msg.signaltype,
      iq_msg.messageid,
      iq_msg.body,
      iq_msg.bodys
    )
  end

  def make_iq_master_attrs(to, id, type) when is_binary(to) and to !== "" do
    [{"to", to}, {"id", id}, {"type", type}]
  end

  def make_iq_master_attrs(_, id, type) do
    [{"id", id}, {"type", type}]
  end

  def make_iq_message("BIND", value, _from, to, _type, id, _body, _bodys) do
    attrs = make_iq_master_attrs(to, id, "set")
    data = {:xmlcdata, value}
    resource = xmlel(name: "resource", children: [data])

    children =
      xmlel(
        name: "bind",
        attrs: [{"xmlns", "urn:ietf:params:xml:ns:xmpp-bind"}],
        children: [resource]
      )

    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def make_iq_message("CREATE_MUC", value, _from, _to, _type, id, _body, _bodys) do
    attrs = make_iq_master_attrs(value, id, "set")
    children = xmlel(name: "query", attrs: [{"xmlns", "http://jabber.org/protocol/create_muc"}])
    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children, {:xmlcdata, ""}])}
  end

  def make_iq_message("MUC_CREATE", _value, _from, to, _type, id, _body, _bodys) do
    attrs = make_iq_master_attrs(to, id, "set")
    children = xmlel(name: "query", attrs: [{"xmlns", "http://jabber.org/protocol/create_muc"}])
    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children, {:xmlcdata, ""}])}
  end

  def make_iq_message("MUC_INVITE_V2", _value, _from, to, _type, id, _body, bodys) do
    attrs = make_iq_master_attrs(to, id, "set")
    bodys_children = make_attrs_xmlels(bodys)

    children =
      xmlel(
        name: "query",
        attrs: [{"xmlns", "http://jabber.org/protocol/muc#invite_v2"}],
        children: bodys_children
      )

    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def make_iq_message("GET_MUC_USER", _value, _from, to, _type, id, _body, _bodys) do
    attrs = make_iq_master_attrs(to, id, "get")
    children = xmlel(name: "query", attrs: [{"xmlns", "http://jabber.org/protocol/muc#register"}])
    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def make_iq_message("SET_MUC_USER", _value, _from, to, _type, id, _body, _bodys) do
    attrs = make_iq_master_attrs(to, id, "set")
    children = xmlel(name: "query", attrs: [{"xmlns", "http://jabber.org/protocol/muc#register"}])
    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def make_iq_message("DEL_MUC_USER", _value, _from, to, _type, id, _body, _bodys) do
    attrs = make_iq_master_attrs(to, id, "set")

    children =
      xmlel(name: "query", attrs: [{"xmlns", "http://jabber.org/protocol/muc#del_register"}])

    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def make_iq_message("ADD_USER_SUBSCRIBE", _value, _from, to, _type, id, _body, _bodys) do
    attrs = make_iq_master_attrs(to, id, "set")
    action = xmlel(name: "subscribe", attrs: [{"action", "add"}])

    children =
      xmlel(
        name: "query",
        attrs: [{"xmlns", "http://jabber.org/protocol/muc#muc_user_subscribe"}],
        children: [action]
      )

    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def make_iq_message("DEL_USER_SUBSCRIBE", _value, _from, to, _type, id, _body, _bodys) do
    attrs = make_iq_master_attrs(to, id, "set")
    action = xmlel(name: "subscribe", attrs: [{"action", "delete"}])

    children =
      xmlel(
        name: "query",
        attrs: [{"xmlns", "http://jabber.org/protocol/muc#muc_user_subscribe"}],
        children: [action]
      )

    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def make_iq_message("GET_USER_SUBSCRIBE", _value, _from, to, _type, id, _body, _bodys) do
    attrs = make_iq_master_attrs(to, id, "get")

    children =
      xmlel(
        name: "query",
        attrs: [{"xmlns", "http://jabber.org/protocol/muc#muc_user_subscribe"}]
      )

    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def make_iq_message("SET_USER_SUBSCRIBE_V2", value, _from, to, _type, id, _body, _bodys) do
    attrs = make_iq_master_attrs(to, id, "set")
    action = xmlel(name: "subscribe", attrs: [{"action", value}])

    children =
      xmlel(
        name: "query",
        attrs: [{"xmlns", "http://jabber.org/protocol/muc#muc_user_subscribe_v2"}],
        children: [action]
      )

    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def make_iq_message("GET_USER_SUBSCRIBE_V2", _value, _from, to, _type, id, _body, _bodys) do
    attrs = make_iq_master_attrs(to, id, "get")

    children =
      xmlel(
        name: "query",
        attrs: [{"xmlns", "http://jabber.org/protocol/muc#muc_user_subscribe_v2"}]
      )

    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def make_iq_message("GET_USER_OPT", value, _from, to, _type, id, _body, _bodys) do
    attrs = make_iq_master_attrs(to, id, "get")
    jid = remove_jid_domain(value)

    children =
      xmlel(
        name: "get_verify_friend_mode",
        attrs: [{"xmlns", "jabber:iq:verify_friend_mode"}, {"jid", jid}]
      )

    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def make_iq_message("SET_USER_OPT", _value, _from, to, _type, id, body, _bodys) do
    attrs = make_iq_master_attrs(to, id, "set")
    children = make_attrs_xmlel(body.value, body.headers, "jabber:iq:verify_friend_mode", [])
    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def make_iq_message("GET_USER_FRIEND", _value, _from, to, _type, id, _body, _bodys) do
    attrs = make_iq_master_attrs(to, id, "get")
    children = xmlel(name: "get_user_friends", attrs: [{"xmlns", "jabber:x:get_friend"}])
    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def make_iq_message("DEL_USER_FRIEND", _value, _from, to, _type, id, body, _bodys) do
    attrs = make_iq_master_attrs(to, id, "set")
    children = make_attrs_xmlel(body.value, body.headers, "jabber:x:delete_friend", [])
    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def make_iq_message("GET_USER_KEY", _value, _from, to, _type, id, _body, _bodys) do
    attrs = make_iq_master_attrs(to, id, "get")
    children = xmlel(name: "key", attrs: [{"xmlns", "urn:xmpp:key"}])
    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def make_iq_message("SET_ADMIN", _value, _from, to, _type, id, body, _bodys) do
    set_admin_children = make_attrs_xmlel(body.value, body.headers, "jabber:x:mask_user", [])
    attrs = make_iq_master_attrs(to, id, "set")

    children =
      xmlel(
        name: "query",
        attrs: [{"xmlns", "http://jabber.org/protocol/muc#admin"}],
        children: [set_admin_children]
      )

    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def make_iq_message(iq_type, _value, _from, to, _type, id, body, _bodys)
      when iq_type == "CANCEL_MEMBER" or iq_type == "SET_MEMBER" do
    set_admin_children = make_attrs_xmlel(body.value, body.headers, "", [])
    attrs = make_iq_master_attrs(to, id, "set")

    children =
      xmlel(
        name: "query",
        attrs: [{"xmlns", "http://jabber.org/protocol/muc#admin"}],
        children: [set_admin_children]
      )

    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def make_iq_message("USER_MUCS", _value, _from, to, _type, id, body, _bodys) do
    set_admin_children = make_attrs_xmlel(body.value, body.headers, "", [])
    attrs = make_iq_master_attrs(to, id, "get")

    children =
      xmlel(
        name: "query",
        attrs: [{"xmlns", "http://jabber.org/protocol/muc#user_mucs"}],
        children: [set_admin_children]
      )

    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def make_iq_message("DESTROY_MUC", _value, _from, to, _type, id, _body, _bodys) do
    attrs = make_iq_master_attrs(to, id, "set")

    children =
      xmlel(
        name: "query",
        attrs: [{"xmlns", "http://jabber.org/protocol/muc#owner"}],
        children: [xmlel(name: "destroy")]
      )

    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def make_iq_message("PING", _value, _from, to, _type, id, _body, _bodys) do
    attrs = make_iq_master_attrs(to, id, "get")

    children =
      xmlel(
        name: "ping",
        attrs: [{"xmlns", "urn:xmpp:ping"}]
      )

    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def remove_jid_domain(jid) do
    [user | _] = String.split(jid, "@")
    user
  end

  def make_attrs_xmlels(bodys) do
    bodys
    |> Enum.flat_map(fn body ->
      [make_attrs_xmlel(body.value, body.headers, "", [])]
    end)
  end

  def make_attrs_xmlel(name, headers, xmlns, child) do
    attrs =
      headers
      |> Enum.flat_map(fn header ->
        handle_header_attrs(header)
      end)

    attrs =
      case xmlns do
        "" -> attrs
        _ -> [{"xmlns", xmlns}] ++ attrs
      end

    xmlel(name: name, attrs: attrs, children: child)
  end

  def handle_header_attrs(header) do
    v = get_header_definedkey(header.definedkey)
    [{v, header.value}]
  end

  def get_header_definedkey(header_key) do
    case header_key do
      :StringHeaderTypeChatId -> "chatid"
      :StringHeaderTypeChannelId -> "channelid"
      :StringHeaderTypeExtendInfo -> "extendInfo"
      :StringHeaderTypeBackupInfo -> "backupinfo"
      :StringHeaderTypeReadType -> "read_type"
      :StringHeaderTypeJid -> "jid"
      :StringHeaderTypeRealJid -> "real_jid"
      :StringHeaderTypeInviteJid -> "invite_jid"
      :StringHeaderTypeDeleleJid -> "del_jid"
      :StringHeaderTypeNick -> "nick"
      :StringHeaderTypeTitle -> "title"
      :StringHeaderTypePic -> "pic"
      :StringHeaderTypeVersion -> "version"
      :StringHeaderTypeMethod -> "method"
      :StringHeaderTypeBody -> "body"
      :StringHeaderTypeAffiliation -> "affiliation"
      :StringHeaderTypeType -> "type"
      :StringHeaderTypeResult -> "result"
      :StringHeaderTypeReason -> "reason"
      :StringHeaderTypeRole -> "role"
      :StringHeaderTypeDomain -> "domain"
      :StringHeaderTypeStatus -> "status"
      :StringHeaderTypeCode -> "code"
      :StringHeaderTypeCdata -> "cdata"
      :StringHeaderTypeTimeValue -> "time_value"
      :StringHeaderTypeKeyValue -> "key_value"
      :StringHeaderTypeName -> "name"
      :StringHeaderTypeHost -> "host"
      :StringHeaderTypeQuestion -> "question"
      :StringHeaderTypeAnswer -> "answer"
      :StringHeaderTypeFriends -> "friends"
      :StringHeaderTypeValue -> "value"
      :StringHeaderTypeMaskedUuser -> "masked_user"
      :StringHeaderTypeKey -> "key"
      :StringHeaderTypeMode -> "mode"
      :StringHeaderTypeCarbon -> "carbon_message"
    end
  end

  def get_iqkey_type(key) do
    case key do
      :IQKeyBind -> "BIND"
      :IQKeyMucCreate -> "CREATE_MUC"
      :IQKeyMucCreateV2 -> "MUC_CREATE"
      :IQKeyMucInviteV2 -> "MUC_INVITE_V2"
      :IQKeyGetMucUser -> "GET_MUC_USER"
      :IQKeySetMucUser -> "SET_MUC_USER"
      :IQKeyDelMucUser -> "DEL_MUC_USER"
      :IQKeyAddUserSubscribe -> "ADD_USER_SUBSCRIBE"
      :IQKeyDelUserSubscribe -> "DEL_USER_SUBSCRIBE"
      :IQKeyGetUserSubScribe -> "GET_USER_SUBSCRIBE"
      :IQKeySetUserSubScribeV2 -> "SET_USER_SUBSCRIBE_V2"
      :IQKeyGetUserSubScribeV2 -> "GET_USER_SUBSCRIBE_V2"
      :IQKeyGetVerifyFriendOpt -> "GET_USER_OPT"
      :IQKeySetVerifyFriendOpt -> "SET_USER_OPT"
      :IQKeyGetUserFriend -> "GET_USER_FRIEND"
      :IQKeyDelUserFriend -> "DEL_USER_FRIEND"
      :IQKeyGetUserKey -> "GET_USER_KEY"
      :IQKeyGetUserMask -> "GET_USER_MASK"
      :IQKeySetUserMask -> "SET_USER_MASK"
      :IQKeyCancelUSerMask -> "CANCEL_USER_MASK"
      :IQKeySetAdmin -> "SET_ADMIN"
      :IQKeySetMember -> "SET_MEMBER"
      :IQKeyCancelMember -> "CANCEL_MEMBER"
      :IQKeyGetUserMucs -> "USER_MUCS"
      :IQKeyDestroyMuc -> "DESTROY_MUC"
      :IQKeyPing -> "PING"
      :IQKeyAddPush -> "ADD_PUSH"
      :IQKeyCancelPush -> "CANCEL_PUSH"
      :IQKeyResult -> "result"
      :IQKeyError -> "error"
      :IQKeyGetVUser -> "GET_VUSER"
      :IQKeyGetVUserRole -> "GET_VUSER_ROLE"
      :IQKeyStartSession -> "RUSER_START_SESSION"
      :IQKeyEndSession -> "RUSER_END_SESSION"
      _ -> :undefined
    end
  end
end
