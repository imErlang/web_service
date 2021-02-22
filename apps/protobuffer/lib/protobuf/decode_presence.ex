defmodule MessageProtobuf.Decode.Presence do
  import Xml

  @spec parse_presence_message(%Protomessage{}) :: any()
  def parse_presence_message(pb_msg) do
    presence = Presencemessage.decode(pb_msg.message)

    case get_presencekey_type(presence.definedkey) do
      :none ->
        make_presence_message(
          presence.key,
          presence.value,
          pb_msg.from,
          pb_msg.to,
          pb_msg.signaltype,
          presence.messageid,
          presence.body
        )

      :PresenceKeyNotify ->
        children = xmlel(name: "notify", attrs: [{"xmlns", "jabber:x:presence_notify"}])

        xml =
          xmlel(
            name: "presence",
            attrs: [
              {"from", pb_msg.from},
              {"to", pb_msg.to},
              {"category", presence.categorytype},
              {"data", presence.body.value},
              {"type", "notify"}
            ],
            children: [children]
          )

        {:xmlstreamelement, xml}

      key ->
        make_presence_message(
          key,
          presence.value,
          pb_msg.from,
          pb_msg.to,
          pb_msg.signaltype,
          presence.messageid,
          presence.body
        )
    end
  end

  def get_presencekey_type(:PresenceKeyPriority), do: "priority"
  def get_presencekey_type(:PresenceKeyVerifyFriend), do: "verify_friend"

  def get_presencekey_type(:PresenceKeyManualAuthenticationConfirm),
    do: "manual_authentication_confirm"

  def get_presencekey_type(:PresenceKeyResult), do: "result"
  def get_presencekey_type(:PresenceKeyError), do: "error"
  def get_presencekey_type(:PresenceKeyNotify), do: :PresenceKeyNotify
  def get_presencekey_type(_), do: :none

  def make_presence_message("priority", value, _from, _to, _type, _id, _body) do
    children = xmlel(name: "priority", children: [{:xmlcdata, value}])
    {:xmlstreamelement, xmlel(name: "presence", children: [children])}
  end

  def make_presence_message("verify_friend", _value, _from, to, _type, _id, body) do
    attrs = [{"xmlns", "jabber:x:verify_friend"}, {"to", to}, {"type", "verify_friend"}]
    header_attrs = header_attrs(body.headers)
    {:xmlstreamelement, xmlel(name: "presence", attrs: attrs ++ header_attrs)}
  end

  def make_presence_message("status", _Value, _From, _To, _Type, _ID, body) do
    children = MessageProtobuf.Decode.make_cdata_xmlels(body.headers)
    xml = xmlel(name: "presence", children: children)
    {:xmlstreamelement, xml}
  end

  def make_presence_message(
        "manual_authentication_confirm",
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
