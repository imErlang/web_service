defmodule ProtobufferTest do
  use ExUnit.Case
  doctest Protobuffer

  test "greets the world" do
    assert Protobuffer.hello() == :world
  end
end
