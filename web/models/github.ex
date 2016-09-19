defmodule FridayFront.Github do
  alias FridayFront.GithubConstants, as: Constants
  require Logger
  @config Application.get_env(:friday_front, :github)

  def issues(repository) do
    url = @config[:base_url] <> "/repos/#{repository}/issues"
    Logger.info("access to #{url}")
    HTTPoison.get!(url).body
    |> Poison.decode!
    |> Enum.map(&parse_response(&1, Constants.issues_fields))
  end

  defp parse_response(response, expected_fields) do
    Map.take(response, expected_fields)
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end
end
