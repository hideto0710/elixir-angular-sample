defmodule FridayFront.PageController do
  use FridayFront.Web, :controller

  def index(conn, _params) do
    issues = FridayFront.Github.issues
    render conn, "index.html", issues: issues
  end
end
