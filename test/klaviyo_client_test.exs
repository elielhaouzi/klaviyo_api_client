defmodule KlaviyoClientTest do
  use ExUnit.Case
  doctest KlaviyoClient

  test "greets the world" do
    assert KlaviyoClient.hello() == :world
  end
end
