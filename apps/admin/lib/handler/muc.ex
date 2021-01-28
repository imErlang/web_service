defmodule Handler.Muc do
  require Logger

  def set_muc_vcard(conn) do
    requests = Map.get(conn.body_params, "_json", [])
    Logger.debug("requests: #{inspect(requests)}")

    requests
    |> Enum.map(fn muc ->
      muc_domain_name = Map.get(muc, "muc_name", "")
      [muc_name, _muc_domain] = String.split(muc_domain_name, "@")

      case Persistence.MucRoom.get_muc(muc_name) == nil do
        true ->
          :nonexist

        false ->
          old_vcard_config =
            case Persistence.MucVcardInfo.get_muc(muc_domain_name) do
              nil ->
                Persistence.MucVcardInfo

              old_config ->
                old_config
            end

          changes = %{
            show_name: Map.get(muc, "nick", old_vcard_config.show_name),
            show_name_pinyin: Map.get(muc, "nick", old_vcard_config.show_name_pinyin),
            muc_title: Map.get(muc, "title", old_vcard_config.muc_title),
            muc_desc: Map.get(muc, "desc", old_vcard_config.muc_desc)
          }

          {:ok, new_vcard} = Persistence.MucVcardInfo.update_vcard_info(old_vcard_config, changes)
          Admin.Ejabberd.notify_muc_vcard(muc_name)
          %{
            muc_name: new_vcard.muc_name,
            version: new_vcard.version,
            show_name: new_vcard.show_name,
            muc_title: new_vcard.muc_title,
            muc_desc: new_vcard.muc_desc
          }
      end
    end)

    Ejabberd.Util.success()
  end

  def get_muc_vcard(conn) do
    requests = Map.get(conn.body_params, "_json", [])
    Logger.debug("get muc vcard params: #{inspect(conn.body_params)} requests: #{inspect(requests)}")

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
          Persistence.MucVcardInfo.get_mucs(mucnames)
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
          T: muc.created_at |> DateTime.to_unix(:millisecond),
          F: muc.registed_flag,
          M: muc.muc_name
        }
      end)

    Logger.debug("mucs: #{inspect(mucs)}")

    version =
      case length(mucs) > 0 do
        true ->
          Map.get(hd(mucs), :T, version)

        false ->
          version
      end

      Logger.debug("get increment mucs new version #{version}, mucs: #{inspect(mucs)}")

    Ejabberd.Util.success(%{version: version}, mucs)
  end
end
