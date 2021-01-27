defmodule Admin.Router.File do
  @moduledoc """
  file router
  """
  use Plug.Router
  require Logger

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  match "/file/v2/upload/file" do
    put_resp_header(conn, "content-type", "application/json")
    send_resp(conn, 200, Ejabberd.Util.success())
  end

  def upload(conn) do
    Logger.debug("body: #{inspect(conn.body_params)}, query: #{inspect(conn.query_params)}")
    path = Application.get_env(:admin, :base_dir, "")
    key = Map.get(conn.query_params, "key", "")
    key_ext = Path.extname(key)

    [result] =
      conn.body_params
      |> Enum.map(fn {filename, upload} ->
        Logger.debug("filename: #{inspect(filename)}, upload: #{inspect(upload)}")

        content_exts = MIME.extensions(upload.content_type)
        exts = content_exts |> Enum.filter(fn e -> e == key_ext end)
        ext = if exts == [], do: hd(content_exts), else: hd(exts)
        root_name = Path.rootname(key)

        key_with_type =
          cond do
            upload.content_type == "image" || upload.content_type == "img" ||
                upload.content_type == "avatar" ->
              root_name <> "." <> ext

            true ->
              key
          end

        Logger.debug("key_with_type: #{inspect(key_with_type)}")

        File.cp(upload.path, Path.join([path, key_with_type]))
        key_with_type
      end)

    Logger.debug("result: #{inspect(result)}")
    put_resp_header(conn, "content-type", "application/json")
    send_resp(conn, 200, Ejabberd.Util.success(make_url(result, result)))
  end

  def download(conn, key) do
    path = Application.get_env(:admin, :base_dir, "")

    filename = Path.join([path, key])
    Plug.Conn.send_file(conn, 200, filename)
  end

  def download_emo(conn, package, shortcut, type) do
    Logger.debug(
      "package: #{inspect(package)}, shortcut: #{inspect(shortcut)}, type: #{inspect(type)}"
    )

    path = Application.get_env(:admin, :emo_dir, "")

    filename = Path.join([path, package, shortcut <> ".png"])
    Plug.Conn.send_file(conn, 200, filename)
  end

  def inspect(conn, type) do
    key = Map.get(conn.query_params, "key", "")
    name = Map.get(conn.query_params, "name", "")
    Logger.debug("key: #{key}, name: #{name}, type: #{inspect(type)}")
    filename = get_name(key, name, type)
    Logger.debug("filename: #{filename}")
    path = Application.get_env(:admin, :base_dir, "")

    user_result =
      case File.exists?(Path.join([path, filename])) do
        true ->
          Ejabberd.Util.success(%{errmsg: "文件已存在"}, make_url(key, name))

        false ->
          # put_resp_header(conn, "X-QFProxy-Code", 202)
          Ejabberd.Util.success(%{errmsg: "文件不存在"}, nil)
      end

    put_resp_header(conn, "content-type", "application/json")
    send_resp(conn, 200, user_result)
  end

  defp make_url(key, name) do
    download_url = Application.get_env(:admin, :download_url)
    download_path = Application.get_env(:admin, :download_path)
    download_url <> download_path <> key <> "?name=" <> name
  end

  defp get_name(key, _name, "file") do
    key
  end

  defp get_name(key, name, _) do
    case Path.extname(key) !== "" do
      true ->
        key

      false ->
        key <> "." <> Path.extname(name)
    end
  end
end
