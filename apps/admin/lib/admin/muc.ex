defmodule Admin.Router.Muc do
  use Plug.Router
  require Logger
  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  match "/get_increment_mucs" do
    user = Map.get(conn.body_params, "u")
    host = Map.get(conn.body_params, "d")
    version = Map.get(conn.body_params, "t")
    time = version |> DateTime.from_unix!(:millisecond)

    mucs =
      Ejabberd.UserRegisterMucs.get_increment_mucs(user, host, time)
      |> Enum.map(fn muc ->
        %{
          D: muc.domain,
          T: muc.created_at,
          F: muc.registed_flag,
          M: muc.muc_name
        }
      end)

    Logger.debug("mucs: #{inspect(mucs)}")

    version =
      case length(mucs) > 0 do
        true ->
          Map.get(hd(mucs), "T", version)

        false ->
          version
      end

    succ = Ejabberd.Util.success(%{version: version}, mucs)
    send_resp(conn, 200, succ)
  end
end
