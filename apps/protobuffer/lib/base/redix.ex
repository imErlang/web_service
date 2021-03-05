defmodule Protobuffer.Redix do
  @pool_size 5

  def child_spec(name, args) do
    # Specs for the Redix connections.
    children =
      for index <- 0..(@pool_size - 1) do
        Supervisor.child_spec({Redix, [name: :"#{name}_#{index}"] ++ args}, id: {Redix, index})
      end

    # Spec for the supervisor that will supervise the Redix connections.
    %{
      id: name,
      type: :supervisor,
      start: {Supervisor, :start_link, [children, [strategy: :one_for_one]]}
    }
  end

  def command(name, command) do
    Redix.command(:"#{name}_#{random_index()}", command)
  end

  defp random_index() do
    Enum.random(0..@pool_size - 1)
  end
end
