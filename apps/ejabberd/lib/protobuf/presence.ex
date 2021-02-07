defmodule MessageProtobuf.Decode.Presence do
  import Xml

  @spec parse_presence_message(%Protomessage{}) :: any()
  def parse_presence_message(pb_msg) do
    presence = Presencemessage.decode(pb_msg.message)

    make_presence_message(
      presence.definedkey,
      presence.value,
      pb_msg.from,
      pb_msg.to,
      pb_msg.signaltype,
      presence.messageid,
      presence.body
    )
  end

  def make_presence_message(:PresenceKeyPriority, value, _from, _to, _type, _id, _body) do
    children = xmlel(name: "priority", children: [{:xmlcdata, value}])
    {:xmlstreamelement, xmlel(name: "presence", children: [children])}
  end

  def make_presence_message(:PresenceKeyVerifyFriend, _value, _from, to, _type, _id, body) do
    attrs = [{"xmlns", "jabber:x:verify_friend"}, {"to", to}, {"type", "verify_friend"}]

    header_attrs = header_attrs(body.headers)
    {:xmlstreamelement, xmlel(name: "presence", attrs: attrs ++ header_attrs)}
  end

  def make_presence_message(
        :PresenceKeyManualAuthenticationConfirm,
        _value,
        _from,
        to,
        _type,
        _id,
        body
      ) do
    attrs = [
      {"xmlns", "jabber:x:manual_authentication"},
      {"to", to},
      {"type", "manual_authentication_confirm"}
    ]

    header_attrs = header_attrs(body.headers)

    {:xmlstreamelement, xmlel(name: "presence", attrs: attrs ++ header_attrs)}
  end

  def header_attrs(headers) do
    headers
    |> Enum.map(fn header ->
      {MessageProtobuf.Decode.get_header_definedkey(header.definedkey), header.value}
    end)
  end
end
