defmodule Ejabberd.Department do
  use Ecto.Schema

  import Ecto.Query
  import Ecto.Changeset

  require Logger

  schema "startalk_dep_table" do
    field(:dep_name, :string)
    field(:dep_level, :integer)
    field(:dep_vp, :string, default: "")
    field(:dep_hr, :string)
    field(:dep_visible, :string)
    field(:parent_id, :integer)
    field(:dep_leader, :string)
    field(:delete_flag, :integer, default: 0)
    field(:dep_desc, :string)
    field(:create_time, :utc_datetime)
    field(:update_time, :utc_datetime)
  end

  @fields ~w(dep_name dep_level dep_vp dep_hr dep_visible parent_id dep_leader delete_flag dep_desc create_time update_time)a

  def changeset(data, params \\ %{}) do
    data
    |> cast(params, @fields)
    |> unique_constraint(:dep_name)
  end

  def get(dep_id) do
    Ejabberd.Department
    |> where([d], d.id == ^dep_id)
    |> Ejabberd.Repo.one
  end

  def get_all() do
    Ejabberd.Department
    |> Ejabberd.Repo.all
  end

  @spec create(%{}) :: boolean()
  def create(params) do
    cs = changeset(%Ejabberd.Department{}, params)
    Logger.info("insert dep #{inspect(cs)}")

    if cs.valid? do
      case Ejabberd.Repo.insert(cs) do
        {:ok, _} ->
          true
        {:error, _} ->
          false
      end
    else
      false
    end
  end

end
