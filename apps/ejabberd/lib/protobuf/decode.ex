defmodule MessageProtobuf.Decode do
  @moduledoc """
  protobuf decode protobuf and translate it to xml
  """
  import Xml

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
    MessageProtobuf.Decode.Presence.parse_presence_message(pb_msg)
  end

  def handle_pro_msg(:SignalTypeIQ, pb_msg) do
    iq_msg = Iqmessage.decode(pb_msg.message)

    MessageProtobuf.Decode.IQ.make_iq_message(
      iq_msg.definedkey,
      iq_msg.value,
      pb_msg.from,
      pb_msg.to,
      Signaltype.key(pb_msg.signaltype),
      iq_msg.messageid,
      iq_msg.body,
      iq_msg.bodys
    )
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
    MessageProtobuf.Decode.Message.parse_xmpp_message(pb_msg)
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

  def get_msgid(:undefined) do
    "PBMSG_#{:random.uniform(65536)}#{:qtalk_public.get_exact_timestamp()}"
  end

  def get_header_definedkey(key) do
    case key do
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
      _ -> :undefined
    end
  end

  def get_client_type(type) do
    case type do
      :ClientTypeMac -> "ClientTypeMac"
      :ClientTypeiOS -> "ClientTypeiOS"
      :ClientTypePC -> "ClientTypePC"
      :ClientTypeAndroid -> "ClientTypeAndroid"
      :ClientTypeLinux -> "ClientTypeLinux"
      :ClientTypeWeb -> "ClientTypeWeb"
      _ -> "ClientTypePC"
    end
  end

  def get_type(type) do
    case type do
      :SignalTypeChat -> "chat"
      :SignalTypeGroupChat -> "groupchat"
      :SignalTypeMState -> "mstat"
      :SignalTypeReadmark -> "readmark"
      :SignalTypeTyping -> "typing"
      :SignalTypeHeadline -> "headline"
      :SignalTypeWebRtc -> "webrtc"
      :SignalTypeSubscription -> "subscription"
      :SignalTypeRevoke -> "revoke"
      :SignalTypeConsult -> "consult"
      :SignalTypeEncryption -> "encrypt"
      _ -> "normal"
    end
  end
end
