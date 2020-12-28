defmodule Admin.Router do
  @moduledoc """
  endpoint for admin http service
  """

  use Plug.Router

  plug Plug.Logger
  plug :match
  plug :dispatch

  get "/hello" do
    send_resp(conn, 200, "world")
  end

  match _ do
    send_resp(conn, 400, "not found")
  end

end
