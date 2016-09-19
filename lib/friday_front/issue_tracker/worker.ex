defmodule FridayFront.IssueTracker.Worker do
  use GenServer

  alias FridayFront.IssueTracker

  def start_link(stash_pid, repository) do
    GenServer.start_link(__MODULE__, [stash_pid, repository], name: via_tuple(repository))
  end

  def next_number(repository) do
    GenServer.call(via_tuple(repository), :next_number)
  end

  def crash(repository) do
    GenServer.cast(via_tuple(repository), :crash)
  end

  def init([stash_pid, repository]) do
    current_number = IssueTracker.Stash.get_value(stash_pid, repository)
    {:ok, {current_number, stash_pid, repository}}
  end

  def handle_call(:next_number, _from, {current_number, stash_pid, repository}) do
    {:reply, current_number, {current_number+1, stash_pid, repository}}
  end

  def handle_cast(:crash, {}) do
    raise "crash!"
  end

  def terminate(_reason, {current_number, stash_pid, repository}) do
    IssueTracker.Stash.save_value(stash_pid, repository, current_number)
  end

  defp via_tuple(repository) do
    {:via, :gproc, {:n, :l, {:repository_name, repository}}}
  end
end
