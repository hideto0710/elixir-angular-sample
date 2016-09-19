defmodule FridayFront.IssueTracker do
  use Supervisor

  alias FridayFront.IssueTracker

  def start_link do
    result = { :ok, sup } = Supervisor.start_link(__MODULE__, [])
    start_workers(sup)
    result
  end

  def start_workers(sup) do
    {:ok, stash} = Supervisor.start_child(sup, worker(IssueTracker.Stash, []))
    Supervisor.start_child(sup, supervisor(IssueTracker.Supervisor, [stash]))
  end

  def init(_) do
    options = [ strategy: :one_for_one ]
    supervise([], options)
  end
end
