defmodule Mod.Protobuf.Handler do
  import Xml

  def generate_nav_version() do
    Jason.encode(%{navversion: Application.get_env(:protobuffer, :navversion, "10000")})
  end

  def generate_key() do
    [
      :random.uniform(65536) |> Integer.to_string()
      | :os.timestamp() |> :erlang.tuple_to_list() |> Enum.map(&Integer.to_string/1)
    ]
    |> :erlang.iolist_to_binary()
  end

  def set_redis_user_key(server, user, resource, key, mac_key) do
    Protobuffer.Redix.command(:key, ["HSET", user, resource, key])
    Protobuffer.Redix.command(:key, ["HSET", user <> "@" <> server, key, mac_key])
    Protobuffer.Redix.command(:key, ["HSET", user, key, mac_key])
  end

  def send_login_presence(user, server) do
    data =
      :ejabberd_sm.get_user_present_resources(user, server)
      |> Enum.map(fn {_, r} ->
        [_, p | _] = String.split(r, "_")
        p
      end)
      |> :jiffy.encode()

    user_str = :jid.make(user, server) |> :jid.to_string()

    attrs = [
      {"from", user_str},
      {"to", user_str},
      {"category", "9"},
      {"data", data},
      {"type", "notify"}
    ]

    children = [xmlel(name: "notify", attrs: [{"xmlns", "jabber:x:presence_notify"}])]
    xmlel(name: "presence", attrs: attrs, children: children)
  end
end
