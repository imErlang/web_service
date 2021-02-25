defmodule Mod.Protobuf.C2s do
  @behaviour :xmpp_stream_in

  @impl :xmpp_stream_in
  def init(args) do
    :ejabberd_c2s.init(args)
  end
end
