defmodule SugarTest.Store do
  use ExUnit.Case, async: true
  doctest Sugar

  alias Sugar.Store

  test "should store by value by key" do
    {:ok, pid} = Store.start_link()
    Store.put(pid, :key, :value)
    assert Store.get(pid, :key) == {:ok, :value}
  end

  test "should return error if has no key" do
    {:ok, pid} = Store.start_link()
    assert Store.get(pid, :key) == {:error, :error}
  end

  test "should contain key" do
    {:ok, pid} = Store.start_link()
    Store.put(pid, :key, :value)
    assert Store.exist(pid, :key) == true
  end

  test "should contain no key" do
    {:ok, pid} = Store.start_link()
    assert Store.exist(pid, :key) == false
  end
end
