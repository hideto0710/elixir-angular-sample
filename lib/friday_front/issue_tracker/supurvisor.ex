defmodule FridayFront.IssueTracker.Supurvisor do
  use Supervisor
  require Logger
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

  def get_issues(repository) do
    if check_worker(repository) do
      Logger.info("get from cache.")
      IssueTracker.Worker.issues(repository)
    else
      Logger.info("get from github repo.")
      Supervisor.start_child(__MODULE__, [repository])
      IssueTracker.Worker.issues(repository)
    end
  end

  def crash_worker(repository) do
    IssueTracker.Worker.crash(repository)
  end

  def count_workers do
    Supervisor.count_children(__MODULE__)
  end

  defp check_worker(repository) do
    case :gproc.where({:n, :l, {:repository_name, repository}}) do
      :undefined -> false
      _ -> true
    end
  end
end
