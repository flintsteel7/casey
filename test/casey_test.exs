defmodule CaseyTest do
  use ExUnit.Case
  doctest Casey

  test "greets the world" do
    assert Casey.hello() == :world
  end
end
