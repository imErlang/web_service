defmodule Ejabberd.HostUsers do
  use Ecto.Schema

  require Logger

  import Ecto.Query, only: [from: 2]

  import Ecto.Changeset

  schema "host_users" do
    field(:host_id, :integer)
    field(:user_id, :string)
    field(:user_name, :string)
    field(:department, :string)
    field(:tel, :string)
    field(:email, :string, default: "")
    field(:dep1, :string)
    field(:dep2, :string)
    field(:dep3, :string)
    field(:dep4, :string)
    field(:dep5, :string)
    field(:pinyin, :string, default: "")
    field(:frozen_flag, :integer)
    field(:version, :integer)
    field(:user_type, :string)
    field(:hire_flag, :integer)
    field(:gender, :integer)
    field(:password, :string)
    field(:initialpwd, :integer)
    field(:pwd_salt, :string)
    field(:leader, :string)
    field(:hrbp, :string)
    field(:user_role, :integer)
    field(:approve_flag, :integer)
    field(:user_desc, :string)
    field(:user_origin, :integer)
    field(:hire_type, :string)
    field(:admin_flag, :string)
    field(:ps_deptid, :string)
    field(:create_time, :utc_datetime)
  end

  def findByUserId(user_id, host_id) do
    query = from(u in Ejabberd.HostUsers, where: u.user_id == ^user_id and u.host_id == ^host_id)
    Ejabberd.Repo.one(query)
  end

  def delete(userid, hostid, version) do
    user = findByUserId(userid, hostid)

    query =
      from(u in Ejabberd.HostUsers,
        where: u.user_id == ^userid and u.host_id == ^hostid,
        update: [set: [hire_flag: 0, version: ^version]]
      )

    case Ejabberd.Repo.update(query) do
      {:ok, succ} ->
        Logger.error("delete user succ #{inspect(succ)}")
        true

      {:error, changeset} ->
        Logger.error("delete user error #{inspect(changeset)}")
        false
    end
  end
end
