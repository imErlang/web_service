defmodule Ejabberd.Department do
  use Ecto.Schema

  import Ecto.Query

  require Logger

  schema "startalk_dep_table" do
    field(:dep_name, :string, default: "")
    field(:dep_level, :integer, default: 1)
    field(:dep_vp, :string, default: "")
    field(:dep_hr, :string, default: "")
    field(:dep_visible, :string, default: "")
    field(:parent_id, :integer, default: 0)
    field(:dep_leader, :string, default: "")
    field(:delete_flag, :integer, default: 0)
    field(:dep_desc, :string, default: "")
    field(:create_time, :utc_datetime)
    field(:update_time, :utc_datetime)
  end

  def delete(dep_id) do
    Ejabberd.Department
    |> where([d], d.id == ^dep_id)
    |> Ejabberd.Repo.delete_all()
  end

  def get(dep_id) do
    Ejabberd.Department
    |> where([d], d.id == ^dep_id)
    |> Ejabberd.Repo.one()
  end

  def get_all() do
    Ejabberd.Department
    |> Ejabberd.Repo.all()
  end

  def create(params) do
    params |> Ejabberd.Repo.insert(on_conflict: :nothing)
  end
end
