defmodule Admin.Router do
  @moduledoc """
  endpoint for admin http service
  """

  use Plug.Router
  use Plug.ErrorHandler

  plug(Plug.Logger)
  plug(:match)

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(:dispatch)

  forward("/im_http_service/newapi/update", to: Admin.Router.User)

  def handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    send_resp(conn, conn.status, "Something went wrong")
  end
end
