defmodule Sugar.Store do

  def start_link() do
    Agent.start_link(fn -> %{} end)
  end

  def get(store, key) do
    Agent.get(store, fn map ->
      if Map.has_key?(map, key) do
        {:ok, Map.get(map, key)}
      else
        {:error, :error}
      end
    end)
  end

  def get_all(store) do
    Agent.get(store, fn map -> map end)
  end

  def put(store, key, value) do
    Agent.update(store, &Map.put(&1, key, value))
  end

  def exist(store, key) do
    Agent.get(store, &Map.has_key?(&1, key))
  end
end
