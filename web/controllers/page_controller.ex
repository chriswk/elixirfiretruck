defmodule Elixirfiretruck.PageController do
  use Elixirfiretruck.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
