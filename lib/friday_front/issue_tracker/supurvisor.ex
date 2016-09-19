defmodule FridayFront.IssueTracker.Supurvisor do
  use Supervisor
  alias FridayFront.IssueTracker

  def start_link(stash_pid) do
    Supervisor.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def init(stash_pid) do
    children = [
      worker(IssueTracker.Worker, [stash_pid], restart: :transient)
    ]
    options = [strategy: :simple_one_for_one]
    supervise(children, options)
  end

  def start_worker(repository) do
    Supervisor.start_child(__MODULE__, [repository])
  end

  def count_workers do
    Supervisor.count_children(__MODULE__)
  end
end
