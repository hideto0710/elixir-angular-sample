defmodule FridayFront.IssueTracker.Worker do
  use GenServer

  alias FridayFront.IssueTracker

  def start_link(stash_pid) do
    GenServer.start_link(__MODULE__, stash_pid)
  end

  def next_number(pid) do
    GenServer.call(pid, :next_number)
  end

  def crash(pid) do
    GenServer.cast(pid, :crash)
  end

  def init(stash_pid) do
    current_number = IssueTracker.Stash.get_value(stash_pid, :key1)
    {:ok, {current_number, stash_pid}}
  end

  def handle_call(:next_number, _from, {current_number, stash_pid}) do
    {:reply, current_number, {current_number+1, stash_pid}}
  end

  def handle_cast(:crash, {}) do
    "a" <> 1
  end

  def terminate(_reason, {current_number, stash_pid}) do
    IssueTracker.Stash.save_value(stash_pid, :key1, current_number)
  end
end
