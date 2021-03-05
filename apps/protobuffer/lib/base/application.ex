defmodule Protobuffer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    redis_key_opts = Application.get_env(:protobuffer, :redis_key, %{}) |> Map.to_list()
    redis_key = Protobuffer.Redix.child_spec(:key, redis_key_opts)
    children = [
      # Starts a worker by calling: Admin.Worker.start_link(arg)
      # {Admin.Worker, arg}
      redis_key
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Protobuffer.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
