defmodule Admin.Router.File do
  @moduledoc """
  host router
  """
  use Plug.Router
  require Logger
  import Helper

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  match "/v2/download/:key" do
    Handler.File.download(conn, key)
  end

  match "/v2/download/perm/:key" do
    Handler.File.download(conn, key)
  end

  match "/v2/inspection/:type" do
    body = Handler.File.inspect(conn, type)
    send_resp_json(conn, body)
  end

  match "/v2/upload/:type" do
    body = Handler.File.upload(conn)
    send_resp_json(conn, body)
  end

  match "/v2/emo/d/e/:package/:shortcut/:type" do
    Handler.File.download_emo(conn, package, shortcut, type)
  end
end
