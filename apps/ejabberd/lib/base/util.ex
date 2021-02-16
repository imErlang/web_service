defmodule Util do
  def get_timestamp() do
    DateTime.utc_now() |> DateTime.to_unix(:second)
  end

  def get_exact_timestamp() do
    DateTime.utc_now() |> DateTime.to_unix(:millisecond)
  end
end
