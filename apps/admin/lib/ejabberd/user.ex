defmodule Ejabberd.HostUsers do
  use Ecto.Schema

  require Logger

  import Ecto.Query, only: [from: 2, where: 3, update: 3, select: 3]

  schema "host_users" do
    field(:host_id, :integer, default: 1)
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

  def get_users(host_id) do
    Ejabberd.HostUsers
    |> where([u], u.hire_flag == 1 and u.frozen_flag == 0 and u.host_id == ^host_id)
    |> Ejabberd.Repo.all()
  end

  def create_user(user) do
    user |> Ejabberd.Repo.insert(on_conflict: :nothing)
  end

  def find_user(user_id, host_id) do
    query = from(u in Ejabberd.HostUsers, where: u.user_id == ^user_id and u.host_id == ^host_id)
    Ejabberd.Repo.one(query)
  end

  def get_update_users(host_id, version) do
    Ejabberd.HostUsers
    |> where([u], u.host_id == ^host_id and u.version > ^version)
    |> Ejabberd.Repo.all()
  end

  def max_version do
    Ejabberd.HostUsers
    |> select([u], max(u.version))
    |> Ejabberd.Repo.one()
  end

  def delete(user_id, host_id) do
    max_version = max_version()

    query =
      Ejabberd.HostUsers
      |> where([u], u.user_id == ^user_id and u.host_id == ^host_id)
      |> update([], set: [hire_flag: 0, version: ^(max_version + 1)])

    {num, _} = Ejabberd.Repo.update_all(query, [])
    num > 0
  end
end
