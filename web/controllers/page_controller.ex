defmodule FridayFront.PageController do
  use FridayFront.Web, :controller

  @config Application.get_env(:friday_front, :github)

  def index(conn, _params) do
    issues = FridayFront.Github.issues(@config[:repository])
    render conn,
           "index.html",
           issues: issues |> Enum.map(&(&1 |> camelize_keys))
  end

  defp camelize_keys(list) do
    Enum.map(list, fn ({k, v}) -> {Inflex.camelize(k, :lower), v} end)
  end
end
