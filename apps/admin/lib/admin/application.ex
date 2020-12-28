defmodule Admin.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Admin.Worker.start_link(arg)
      # {Admin.Worker, arg}
      {Plug.Cowboy, scheme: :http, plug: Admin.Router, port: get_port()}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Admin.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp get_port do
	  Application.get_env(:admin, :port, 4040)
  end
end
