defmodule Handler.Dep do
  @moduledoc """
  dep handler
  """
  require Logger

  @department_separator "/"

  def add(conn) do
    params = conn.body_params
    dep_name = Map.get(params, "depName", "")

    dep_name =
      unless String.starts_with?(dep_name, @department_separator) do
        @department_separator <> dep_name
      else
        dep_name
      end

    dep = %Ejabberd.Department{
      dep_name: dep_name,
      dep_level: Map.get(params, "depLevel", 1),
      dep_vp: Map.get(params, "depVp", ""),
      dep_hr: Map.get(params, "depHr", ""),
      dep_visible: Map.get(params, "depVisible", ""),
      parent_id: Map.get(params, "parentId", 0),
      dep_leader: Map.get(params, "depLeader", ""),
      dep_desc: Map.get(params, "depDesc", "")
    }

    case Ejabberd.Department.create(dep) do
      {:ok, dep} ->
        Logger.debug("insert dep succ #{inspect(dep)}")

      {:error, error} ->
        Logger.debug("insert dep succ #{inspect(error)}")
    end

    Ejabberd.Util.success("")
  end

  def get(conn) do
    dep_id = Map.get(conn.body_params, "depId")

    case Ejabberd.Department.get(dep_id) do
      nil ->
        Ejabberd.Util.fail("dep not exist", -1)

      depInfo ->
        Logger.debug("depInfo #{inspect(depInfo)}")

        detail = %{
          createTime: depInfo.create_time,
          depDesc: depInfo.dep_desc,
          depHr: depInfo.dep_hr,
          depLeader: depInfo.dep_leader,
          depLevel: depInfo.dep_level,
          depName: depInfo.dep_name,
          depVisible: depInfo.dep_visible,
          depVp: depInfo.dep_vp,
          id: depInfo.id,
          updateTime: depInfo.update_time
        }

        Ejabberd.Util.success(detail)
    end
  end

  def delete(conn) do
    dep_id = Map.get(conn.body_params, "depId")

    case Ejabberd.Department.get(dep_id) do
      nil ->
        Ejabberd.Util.fail("dep not exist", -1)

      dep_info ->
        Ejabberd.Department.delete(dep_info.id)
        Ejabberd.Util.success("")
    end
  end

  def update(conn) do
    dep_id = Map.get(conn.body_params, "id")

    case Ejabberd.Department.get(dep_id) do
      nil ->
        Ejabberd.Util.fail("dep not exist", -1)

      depInfo ->
        Logger.debug("depInfo #{inspect(depInfo)}")

        depInfo = %{
          depInfo
          | dep_desc: Map.get(conn.body_params, "depDesc", depInfo.dep_desc),
            dep_hr: Map.get(conn.body_params, "depHr", depInfo.dep_hr),
            dep_leader: Map.get(conn.body_params, "depLeader", depInfo.dep_leader),
            dep_level: Map.get(conn.body_params, "depLevel", depInfo.dep_level),
            dep_name: Map.get(conn.body_params, "depName", depInfo.dep_name),
            dep_visible: Map.get(conn.body_params, "depVisible", depInfo.dep_visible),
            dep_vp: Map.get(conn.body_params, "dep_vp", depInfo.dep_vp)
        }

        Ejabberd.Repo.update(Ecto.Changeset.change(depInfo))
        Ejabberd.Util.success("")
    end
  end
end
