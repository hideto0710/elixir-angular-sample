defmodule FridayFront.IssueTracker.Stash do
  use GenServer

  def start_link(initial_map \\ %{}) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, initial_map)
  end

  def save_value(pid, key, value) do
    GenServer.cast(pid, {:save_value, key, value})
  end

  def get_value(pid, key) do
    GenServer.call(pid, {:get_value, key})
  end

  def handle_call({:get_value, key}, _from, map) do
    {:reply, Map.get(map, key, 0), map}
  end

  def handle_cast({:save_value, key, value}, map) do
    {:noreply, Map.put(map, key, value)}
  end
end
