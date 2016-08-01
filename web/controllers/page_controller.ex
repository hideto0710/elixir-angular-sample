defmodule FridayFront.PageController do
  use FridayFront.Web, :controller

  def index(conn, _params) do
    FridayFront.Endpoint.broadcast! "room:lobby", "new_msg", %{body: "some one try rto join."}
    render conn, "index.html"
  end
end
