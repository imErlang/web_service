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

    result =
      conn.body_params
      |> Enum.map(fn {filename, upload} ->
        Logger.debug("filename: #{inspect(filename)}, upload: #{inspect(upload)}")

        content_exts = MIME.extensions(upload.content_type)
        exts = content_exts |> Enum.filter(fn e -> e == key_ext end)
        ext = if exts == [], do: hd(content_exts), else: hd(exts)
        root_name = Path.rootname(key)
        key_with_type =
          cond do
            upload.content_type == "image" || upload.content_type == "img" || upload.content_type == "avatar" ->
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
    send_resp(conn, 200, Ejabberd.Util.success())
  end


  def download(conn, key) do
    path = Application.get_env(:admin, :base_dir, "")

    filename = Path.join([path, key])
    Plug.Conn.send_file(conn, 200, filename)
  end
end
