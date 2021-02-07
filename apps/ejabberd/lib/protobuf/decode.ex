defmodule MessageProtobuf.Decode do
  @moduledoc """
  protobuf decode protobuf and translate it to xml
  """
  require Record

  Record.defrecord(:xmlel, Record.extract(:xmlel, from_lib: "fast_xml/include/fxml.hrl"))

  def decode_pb_message(data) do
    pb_header = Protoheader.decode(data)
    get_potomessage_base_pbheader(pb_header)
  end

  @spec get_potomessage_base_pbheader(%Protoheader{}) :: any
  def get_potomessage_base_pbheader(pb_header) do
    pb_msg =
      case pb_header.options do
        1 ->
          :zlib.gunzip(pb_header.message)

        5 ->
          :tea_crypto.decrypt(
            pb_header.message,
            <<0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0>>
          )

        _ ->
          pb_header.message
      end

    pb_msg |> Protomessage.decode() |> handle_pro_msg()
  end

  @spec handle_pro_msg(%Protomessage{}) :: any()
  def handle_pro_msg(%Protomessage{signaltype: signaltype} = pb_msg) do
    handle_pro_msg(Signaltype.key(signaltype), pb_msg)
  end

  def handle_pro_msg(:SignalTypePresence, pb_msg) do
    Presencemessage.decode(pb_msg.message)
  end

  def handle_pro_msg(:SignalTypeIQ, pb_msg) do
    Iqmessage.decode(pb_msg.message)
  end

  def handle_pro_msg(:SignalStartTLS, pb_msg) do
    Starttls.decode(pb_msg.message)
  end

  def handle_pro_msg(:SignalTypeWelcome, pb_msg) do
    Welcomemessage.decode(pb_msg.message)
  end

  def handle_pro_msg(:SignalTypeAuth, pb_msg) do
    Authmessage.decode(pb_msg.message)
  end

  def handle_pro_msg(signal_type, pb_msg)
      when signal_type == :SignalTypeChat or
             signal_type == :SignalTypeGroupChat or
             signal_type == :SignalTypeSubscription or
             signal_type == :SignalTypeTyping or
             signal_type == :SignalTypeWebRtc or
             signal_type == :SignalTypeReadmark or
             signal_type == :SignalTypeRevoke or
             signal_type == :SignalTypeConsult or
             signal_type == :SignalTypeEncryption or
             signal_type == :SignalTypeHeadline do
    Xmppmessage.decode(pb_msg.message)
  end

  @spec make_welcome_xml(%Welcomemessage{}) :: {:xmlel, <<>>, [{<<_::40>>, <<_::104>>}, ...], []}
  def make_welcome_xml(welcome) do
    xmlel(
      name: "",
      attrs: [
        {"xmlns", "jabber:client"},
        {"xmlns:stream", "http://etherx.jabber.org/streams"},
        {"to", welcome.domain},
        {"version", welcome.version},
        {"id", "3754522579"},
        {"user", welcome.user},
        {"from", welcome.domain},
        {"xml:lang", "en"}
      ]
    )
  end

  def make_starttls_xml() do
    xmlel(name: "starttls", attrs: [{"xmlns", "urn:ietf:params:xml:ns:xmpp-tls"}])
  end

  def make_auth_xml(auth) do
    id = get_msgid(auth.msgid)
    attrs = [{"xmlns", "urn:ietf:params:xml:ns:xmpp-sasl"}, {"mechanism", Mechanism}, {"id", id}]
    xmlel(name: "auth", attrs: attrs, children: [{:xmlcdata, auth.authkey}])
  end

  def make_iq_message(pb_msg) do
    to = pb_msg.to
  end

  def get_msgid(:undefined) do
    "PBMSG_#{:random.uniform(65536)}#{:qtalk_public.get_exact_timestamp()}"
  end

  def get_iqKey_type(iq_key) do
    case iq_key do
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
      _ -> :none
    end
  end

  def make_iq_master_attrs(:undefined, id, type) do
    [{"id", id}, {"type", type}]
  end

  def make_iq_master_attrs(to, id, type) when is_binary(to) do
    [{"to", to}, {"id", id}, {"type", type}]
  end

  def make_iq_master_attrs(_, id, type) do
    [{"id", id}, {"type", type}]
  end

  def make_iq_message(:IQKeyBind, value, _from, to, _type, id, _body, _bodys) do
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

  def make_iq_message(:IQKeyMucCreate, value, _from, _to, _type, id, _body, _bodys) do
    attrs = make_iq_master_attrs(value, id, "set")
    children = xmlel(name: "query", attrs: [{"xmlns", "http://jabber.org/protocol/create_muc"}])
    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children, {:xmlcdata, ""}])}
  end

  def make_iq_message(:IQKeyMucCreateV2, _value, _from, to, _type, id, _body, _bodys) do
    attrs = make_iq_master_attrs(to, id, "set")
    children = xmlel(name: "query", attrs: [{"xmlns", "http://jabber.org/protocol/create_muc"}])
    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children, {:xmlcdata, ""}])}
  end

  def make_iq_message(:IQKeyMucInviteV2, _value, _from, to, _type, id, _body, bodys) do
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

  def make_iq_message(:IQKeyGetMucUser, _value, _from, to, _type, id, _body, _bodys) do
    attrs = make_iq_master_attrs(to, id, "get")
    children = xmlel(name: "query", attrs: [{"xmlns", "http://jabber.org/protocol/muc#register"}])
    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def make_iq_message(:IQKeySetMucUser, _value, _from, to, _type, id, _body, _bodys) do
    attrs = make_iq_master_attrs(to, id, "set")
    children = xmlel(name: "query", attrs: [{"xmlns", "http://jabber.org/protocol/muc#register"}])
    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def make_iq_message(:IQKeyDelMucUser, _value, _from, to, _type, id, _body, _bodys) do
    attrs = make_iq_master_attrs(to, id, "set")

    children =
      xmlel(name: "query", attrs: [{"xmlns", "http://jabber.org/protocol/muc#del_register"}])

    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def make_iq_message(:IQKeyAddUserSubscribe, _value, _from, to, _type, id, _body, _bodys) do
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

  def make_iq_message(:IQKeyDelUserSubscribe, _value, _from, to, _type, id, _body, _bodys) do
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

  def make_iq_message(:IQKeyGetUserSubScribe, _value, _from, to, _type, id, _body, _bodys) do
    attrs = make_iq_master_attrs(to, id, "get")

    children =
      xmlel(
        name: "query",
        attrs: [{"xmlns", "http://jabber.org/protocol/muc#muc_user_subscribe"}]
      )

    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def make_iq_message(:IQKeySetUserSubScribeV2, value, _from, to, _type, id, _body, _bodys) do
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

  def make_iq_message(:IQKeyGetUserSubScribeV2, _value, _from, to, _type, id, _body, _bodys) do
    attrs = make_iq_master_attrs(to, id, "get")

    children =
      xmlel(
        name: "query",
        attrs: [{"xmlns", "http://jabber.org/protocol/muc#muc_user_subscribe_v2"}]
      )

    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def make_iq_message(:IQKeyGetVerifyFriendOpt, value, _from, to, _type, id, _body, _bodys) do
    attrs = make_iq_master_attrs(to, id, "get")
    jid = remove_jid_domain(value)

    children =
      xmlel(
        name: "get_verify_friend_mode",
        attrs: [{"xmlns", "jabber:iq:verify_friend_mode"}, {"jid", jid}]
      )

    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def make_iq_message(:IQKeySetVerifyFriendOpt, _value, _from, to, _type, id, body, _bodys) do
    attrs = make_iq_master_attrs(to, id, "set")
    children = make_attrs_xmlel(body.value, body.headers, "jabber:iq:verify_friend_mode", [])
    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def make_iq_message(:IQKeyGetUserFriend, _value, _from, to, _type, id, _body, _bodys) do
    attrs = make_iq_master_attrs(to, id, "get")
    children = xmlel(name: "get_user_friends", attrs: [{"xmlns", "jabber:x:get_friend"}])
    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def make_iq_message(:IQKeyDelUserFriend, _value, _from, to, _type, id, body, _bodys) do
    attrs = make_iq_master_attrs(to, id, "set")
    children = make_attrs_xmlel(body.value, body.headers, "jabber:x:delete_friend", [])
    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def make_iq_message(:IQKeyGetUserKey, _value, _from, to, _type, id, _body, _bodys) do
    attrs = make_iq_master_attrs(to, id, "get")
    children = xmlel(name: "key", attrs: [{"xmlns", "urn:xmpp:key"}])
    {:xmlstreamelement, xmlel(name: "iq", attrs: attrs, children: [children])}
  end

  def make_iq_message(:IQKeySetAdmin, _value, _from, to, _type, id, body, _bodys) do
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
      when iq_type == :IQKeyCancelMember or iq_type == :IQKeySetMember do
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

  def make_iq_message(:IQKeyGetUserMucs, _value, _from, to, _type, id, body, _bodys) do
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

  # :IQKeyDelUserFriend -> "DEL_USER_FRIEND"
  # :IQKeyGetUserKey -> "GET_USER_KEY"
  # :IQKeyGetUserMask -> "GET_USER_MASK"
  # :IQKeySetUserMask -> "SET_USER_MASK"
  # :IQKeyCancelUSerMask -> "CANCEL_USER_MASK"
  # :IQKeySetAdmin -> "SET_ADMIN"
  # :IQKeySetMember -> "SET_MEMBER"
  # :IQKeyCancelMember -> "CANCEL_MEMBER"
  # :IQKeyGetUserMucs -> "USER_MUCS"
  # :IQKeyDestroyMuc -> "DESTROY_MUC"
  # :IQKeyPing -> "PING"
  # :IQKeyAddPush -> "ADD_PUSH"
  # :IQKeyCancelPush -> "CANCEL_PUSH"
  # :IQKeyResult -> "result"
  # :IQKeyError -> "error"
  # :IQKeyGetVUser -> "GET_VUSER"
  # :IQKeyGetVUserRole -> "GET_VUSER_ROLE"
  # :IQKeyStartSession -> "RUSER_START_SESSION"
  # :IQKeyEndSession -> "RUSER_END_SESSION"

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
end
