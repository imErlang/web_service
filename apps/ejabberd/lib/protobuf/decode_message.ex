defmodule MessageProtobuf.Decode.Message do
  import Xml
  require Logger

  def parse_xmpp_message(pb_msg) do
    message = Xmppmessage.decode(pb_msg.message)
    Logger.debug("pb_msg: #{inspect(pb_msg)} message: #{inspect(message)}")

    make_xmpp_message(
      pb_msg.from,
      pb_msg.to,
      pb_msg.realfrom,
      pb_msg.realto,
      pb_msg.signaltype,
      message.messagetype,
      message.clienttype,
      message.clientversion,
      message.messageid,
      message.headers,
      message.body.value
    )
  end

  def make_xmpp_message(
        from,
        to,
        realfrom,
        realto,
        type,
        msg_type,
        client_type,
        client_ver,
        id,
        headers,
        cdata
      ) do
    channel_id = get_header_key(:definedkey, :StringHeaderTypeChannelId, headers)
    ex_info = get_header_key(:definedkey, :StringHeaderTypeExtendInfo, headers)
    backup_info = get_header_key(:definedkey, :StringHeaderTypeBackupInfo, headers)
    read_type = get_header_key(:definedkey, :StringHeaderTypeReadType, headers)
    auto_reply = get_header_key(:key, "auto_reply", headers)

    qchat_id =
      case get_header_key(:key, "qchatid", headers) do
        "4" ->
          "4"

        "5" ->
          "5"

        _ ->
          :undefined
      end

    attrs =
      [
        {"from", from},
        {"to", to},
        {"type", MessageProtobuf.Decode.get_type(type)},
        {"client_type", MessageProtobuf.Decode.get_client_type(client_type)},
        {"client_ver", Integer.to_string(client_ver)},
        {"read_type", read_type},
        {"channelid", channel_id},
        {"qchatid", qchat_id},
        {"realfrom", realfrom},
        {"realto", realto},
        {"auto_reply", auto_reply}
      ]
      |> filter_attrs

    children =
      make_xmpp_body(msg_type, id, ex_info, backup_info, :unicode.characters_to_binary(cdata))

    {:xmlstreamelement, xmlel(name: "message", attrs: attrs, children: children)}
  end

  def filter_attrs(attrs) do
    attrs
    |> Enum.flat_map(fn attr ->
      case attr do
        {_attr_key, :undefined} ->
          []

        {_attr_key, nil} ->
          []

        {_attr_key, ""} ->
          []

        _ ->
          [attr]
      end
    end)
  end

  def make_xmpp_body(msg_type, chat_id, ex_info, backup_info, cdata) do
    attrs =
      [
        {"msgType", get_msg_type(msg_type)},
        {"id", chat_id},
        {"extendInfo", ex_info},
        {"backupinfo", backup_info}
      ]
      |> filter_attrs

    [xmlel(name: "body", attrs: attrs, children: [{:xmlcdata, cdata}])]
  end

  def get_msg_type(type) when is_integer(type) do
    Integer.to_string(type)
  end

  def get_msg_type(type) when is_binary(type) do
    type
  end

  def get_msg_type(_) do
    "1"
  end

  def get_header_key(type, key, headers) do
    headers
    |> Enum.find_value(:undefined, fn header ->
      find_key =
        case type do
          :definedkey ->
            header.definedkey

          :key ->
            header.key
        end

      case find_key == key do
        true ->
          header.value

        false ->
          false
      end
    end)
  end
end
