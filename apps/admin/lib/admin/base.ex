defmodule Admin.Router.Base do
  @moduledoc """
  host router
  """
  use Plug.Router
  require Logger

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  match "/time" do
    ret = Ejabberd.Util.success(DateTime.utc_now |> DateTime.to_unix(:millisecond))
    send_resp(conn, 200, ret)
  end
end
