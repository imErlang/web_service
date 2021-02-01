defmodule Persistence.MucVcardInfo do
  use Ecto.Schema

  import Ecto.Query
  import Ecto.Changeset

  require Logger

  @primary_key false
  schema "muc_vcard_info" do
    field(:muc_name, :string, default: "", primary_key: true)
    field(:show_name, :string, default: "")
    field(:muc_desc, :string, default: "")
    field(:muc_title, :string, default: "")
    field(:muc_pic, :string, default: "/file/v2/download/eb574c5a1d33c72ba14fc1616cde3a42.png")
    field(:show_name_pinyin, :string, default: "")
    field(:update_time, :utc_datetime)
    field(:version, :integer, default: 1)
  end

  def get_mucs(mucs) do
    Persistence.MucVcardInfo
    |> where([muc], muc.muc_name in ^mucs)
    |> Ejabberd.Repo.all()
  end

  def get_muc(muc_name) do
    Persistence.MucVcardInfo
    |> where([muc], muc.muc_name == ^muc_name)
    |> Ejabberd.Repo.one()
  end

  def update_vcard_info(muc_vcard, changes) do
    muc_vcard
    |> change(changes)
    |> Ejabberd.Repo.update()
  end

  def select_increment_muc_vcard(username, update_time) do
    sql =
      "select muc_name, show_name, muc_desc, muc_title, muc_pic, show_name_pinyin, update_time, version from muc_vcard_info where muc_name in (select muc_name || '@' || domain from user_register_mucs where username = '#{
        username
      }' AND registed_flag=1) and update_time > to_timestamp(#{update_time}::double precision/1000)"

    Logger.debug("select increment muc vcard: #{sql}")
    {:ok, result} = Ecto.Adapters.SQL.query(Ejabberd.Repo, sql, [])
    Logger.debug("select increment result: #{inspect(result.rows)}")
    result.rows
  end
end
