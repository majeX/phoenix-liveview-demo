defmodule McfPhoenixWeb.Router do
  use McfPhoenixWeb, :router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", McfPhoenixWeb do
    pipe_through :browser

    get "/", PageController, :index
    live "/sv", SupervisorLive, layout: { McfPhoenixWeb.LayoutView, "empty.html" }
    live "/sv_new", SupervisorLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", McfPhoenixWeb do
  #   pipe_through :api
  # end
end
