defmodule FridayFront.Github do
  alias FridayFront.GithubConstants, as: Constants

  def issues do
    base_url = "https://api.github.com"
    token = ""
    headers = [{"Authorization", "token #{token}"}]
    HTTPoison.start
    HTTPoison.get!(base_url <> "/repos/Atrae/wevox/issues", headers).body
    |> Poison.decode!
    |> Enum.map(&parse_response(&1, Constants.issues_fields))
  end

  defp parse_response(obj, expected_fields) do
    Map.take(obj, expected_fields)
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end
end
