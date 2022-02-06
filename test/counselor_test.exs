defmodule CounselorTest do
  use ExUnit.Case
  doctest Counselor

  test "greets the world" do
    assert Counselor.hello() == :world
  end
end
