defmodule McfPhoenixWeb.PageController do
  use McfPhoenixWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
