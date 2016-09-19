defmodule FridayFront.IssueTracker.Supurvisor do
  use Supervisor
  alias FridayFront.IssueTracker

  def start_link(stash_pid) do
    Supervisor.start_link(__MODULE__, stash_pid, name: __MODULE__)
    Agent.start_link(fn -> %{} end, name: :workers)
  end

  def init(stash_pid) do
    children = [
      worker(IssueTracker.Worker, [stash_pid], restart: :transient)
    ]
    options = [strategy: :simple_one_for_one]
    supervise(children, options)
  end

  def start_worker(key) do
    worker = get_worker(key)
    if is_nil(worker) do
      result = {:ok, pid} = Supervisor.start_child(__MODULE__, [])
      Agent.update(:workers, &Map.put(&1, key, pid))
      result
    else
      {:ok, worker}
    end
  end

  def get_worker(key) do
    Agent.get(:workers, &Map.get(&1, key))
  end

  def count_workers do
    Supervisor.count_children(__MODULE__)
  end
end
