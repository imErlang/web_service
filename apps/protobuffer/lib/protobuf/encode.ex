defmodule MessageProtobuf.Encode do
  import Xml
  require Logger

  def get_xml_attrs(packet, key, user) do
    case :fxml.get_attr(key, xmlel(packet, :attrs)) do
      {:value, from} ->
        from

      false ->
        user
    end
  end

  def send_probuf_msg(statedata, packet) do
    Logger.debug("from: #{inspect(statedata)}, packet: #{inspect(packet)}")

    user = :jid.make(statedata.user, statedata.server, statedata.resource)

    to = get_xml_attrs(packet, "to", user)
    from = get_xml_attrs(packet, "from", user)
    do_send_probuf_msg(statedata, from, to, packet)
  end

  def do_send_probuf_msg(statedata, from, to, packet) do
    type = xmlel(packet, :name)

    case do_send_probuf_msg(type, statedata, from, to, packet) do
      "error" ->
        "error"

      data ->
        pack(data)
    end
  end

  def encode_pb_protomessage(
        from,
        to,
        type,
        opts,
        msg,
        realfrom \\ nil,
        realto \\ nil,
        originfrom \\ nil,
        originto \\ nil,
        origintype \\ nil,
        sendjid \\ nil
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

  def do_send_probuf_msg("iq", statedata, from, to, packet) do
    MessageProtobuf.Encode.Iq.xml2pb_iq(statedata, from, to, packet)
  end

  def do_send_probuf_msg("message", _statedata, from, to, packet) do
    MessageProtobuf.Encode.Message.xml2pb_msg(from, to, packet)
  end

  def do_send_probuf_msg("presence", _statedata, from, to, packet) do
    MessageProtobuf.Encode.Presence.xml2pb_presence(from, to, packet)
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
      dv -> [Stringheader.new(definedkey: dv, value: v)]
    end
  end

  def encode_pb_stringheaders(headers) do
    headers
    |> Enum.flat_map(fn header ->
      encode_pb_stringheader(header)
    end)
  end

  def pack(pb_msg) do
    :ejabberd_protobuf.uint32_pack(byte_size(pb_msg), pb_msg)
  end

  def timestamp() do
    DateTime.utc_now() |> DateTime.to_unix(:second)
  end
end
