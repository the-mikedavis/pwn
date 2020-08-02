defmodule PwnTest do
  use ExUnit.Case
  doctest Pwn

  test "greets the world" do
    assert Pwn.hello() == :world
  end
end
