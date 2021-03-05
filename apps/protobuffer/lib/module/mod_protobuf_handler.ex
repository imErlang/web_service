defmodule Mod.Protobuf.Handler do
  def generate_nav_version() do
    Jason.encode(%{navversion: Application.get_env(:protobuffer, :navversion, "10000")})
  end

  def generate_key() do
    [
      :random.uniform(65536) |> Integer.to_string()
      | :os.timestamp() |> :erlang.tuple_to_list() |> Enum.map(&Integer.to_string/1)
    ] |> :erlang.iolist_to_binary()
  end

  def set_redis_user_key(server, user, resource, key, mac_key) do
    Protobuffer.Redix.command(:key, ["HSET", user, resource, key])
    Protobuffer.Redix.command(:key, ["HSET", user <> "@" <> server, key, mac_key])
    Protobuffer.Redix.command(:key, ["HSET", user, key, mac_key])
  end
end
