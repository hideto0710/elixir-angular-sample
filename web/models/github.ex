defmodule FridayFront.Github do
  alias FridayFront.GithubConstants, as: Constants

  def issues do
    base_url = "https://api.github.com"
    HTTPoison.start
    HTTPoison.get!(base_url <> "/repos/hideto0710/elixir-angular-sample/issues").body
    |> Poison.decode!
    |> Enum.map(&parse_response(&1, Constants.issues_fields))
  end

  defp parse_response(obj, expected_fields) do
    Map.take(obj, expected_fields)
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end
end
