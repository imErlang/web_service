defmodule Util do
  def get_timestamp() do
    DateTime.utc_now() |> DateTime.to_unix(:second)
  end

  def get_exact_timestamp() do
    DateTime.utc_now() |> DateTime.to_unix(:millisecond)
  end

  def get_default_domain() do
    :ejabberd_config.get_option(:default_domain, &(&1), "conference.localhost")
  end
end
