defmodule FridayFront.IssueTracker.Worker do
  use GenServer

  alias FridayFront.IssueTracker

  def start_link(stash_pid, repository) do
    GenServer.start_link(__MODULE__, [stash_pid, repository], name: via_tuple(repository))
  end

  def issues(repository) do
    GenServer.call(via_tuple(repository), :issues)
  end

  def crash(repository) do
    GenServer.cast(via_tuple(repository), :crash)
  end

  def init([stash_pid, repository]) do
    case IssueTracker.Stash.get_value(stash_pid, repository) do
      [] ->
        issues = FridayFront.Github.issues(repository)
        {:ok, {issues, stash_pid, repository}}
      issues ->
        {:ok, {issues, stash_pid, repository}}
    end
  end

  def handle_call(:issues, _from, {issues, _, _} = state) do
    {:reply, issues, state}
  end

  def handle_cast(:crash, {}) do
    raise "crash!"
  end

  def terminate(_reason, {issues, stash_pid, repository}) do
    IssueTracker.Stash.save_value(stash_pid, repository, issues)
  end

  defp via_tuple(repository) do
    {:via, :gproc, {:n, :l, {:repository_name, repository}}}
  end
end
