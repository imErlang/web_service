defmodule Admin.Router.Muc do
  use Plug.Router
  require Logger
  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  match "/get_increment_mucs" do
    get_increment_mucs(conn)
  end

  def get_muc_vcard(conn) do
    requests = Map.get(conn.body_params, "_json", [])
    Logger.debug("get muc vcard request: #{inspect(requests)}")

    result =
      requests
      |> Enum.map(fn request ->
        mucnames =
          Map.get(request, "mucs", [])
          |> Enum.map(fn muc_request ->
            Map.get(muc_request, "muc_name", "")
          end)

        Logger.debug("mucnames: #{inspect(mucnames)}")

        mucs =
          Ejabberd.MucVcardInfo.get_mucs(mucnames)
          |> Enum.map(fn muc ->
            %{
              MN: muc.muc_name,
              SN: muc.show_name,
              MD: muc.muc_desc,
              MT: muc.muc_title,
              MP: muc.muc_pic,
              VS: muc.version,
              UT: muc.update_time
            }
          end)

        %{
          domain: Map.get(request, "domain", ""),
          mucs: mucs
        }
      end)

    Logger.debug("get muc vcard result: #{inspect(result)}")
    Ejabberd.Util.success(result)
  end

  def get_increment_mucs(conn) do
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
