defmodule McfPhoenixWeb.SupervisorLive do
  use Phoenix.LiveView
  require Logger
  alias McfPhoenixWeb.PageView
  alias McfPhoenix.Api
  alias McfPhoenix.Filters

  def render(assigns), do: PageView.render("supervisor_new.html", assigns)

  def mount(_session, socket) do
    if connected?(socket), do: :timer.send_interval(500000, self(), :poll)
    %{ bins: bins, move_tickets: move_tickets, work_orders: work_orders } = get_poll_items()
    %{ plants: plants, users: users } = get_permanent_items()

    filter_changeset = get_filter_changeset()

    initial_state = %{
      bins: bins,
      move_tickets: move_tickets,
      work_orders: work_orders,
      plants: plants,
      users: users,
      filters: %{
        work_order: ["all"],
        plant: ["all"]
      },
      filters_changeset: %{

      }
    }
    {:ok, assign(socket, initial_state)}
  end

  def handle_info(:poll, socket) do
    items = get_poll_items()

    {:noreply, assign(socket, items)}
  end

  def handle_event("load", _, socket) do
    url = "http://localhost:8080/api/v1/users"
    response = HTTPoison.get!(url)
    req = Poison.decode!(response.body)
    Logger.debug req
    {:noreply, assign(socket, users: req)}
  end

  defp get_poll_items do
    bins = Api.bins()
    move_tickets = Api.move_tickets()
    work_orders = Api.work_orders()
    %{ bins: bins, move_tickets: move_tickets, work_orders: work_orders }
  end

  defp get_permanent_items do
    plants = Api.plants()
    users = Api.users()
    %{ plants: plants, users: users }
  end

  defp get_filter_changeset do
    filters = %Filters{}
  end
end
