defmodule McfPhoenixWeb.SupervisorLive do
  use Phoenix.LiveView
  require Logger
  alias McfPhoenixWeb.PageView
  alias McfPhoenix.Api
  alias McfPhoenix.Filters

  def render(assigns), do: PageView.render("supervisor.html", assigns)

  def mount(_session, socket) do
    if connected?(socket), do: :timer.send_interval(500000, self(), :poll)
    { bins, move_tickets, work_orders } = get_poll_items()
    { plants, users } = get_permanent_items()

    initial_state = %{
      bins: bins,
      move_tickets: move_tickets,
      work_orders: work_orders,
      plants: plants,
      users: users,
      filters: %Filters{},
    }
    {:ok, assign(socket, initial_state)}
  end

  def handle_info(:poll, socket) do
    items = get_poll_items()

    {:noreply, assign(socket, items)}
  end

  def handle_info({:filter_changed, %{ id: :work_orders, selected: selected }}, socket) do
    new_filters = %Filters{ socket.assigns.filters | work_orders: selected }
    {:noreply, assign(socket, filters: new_filters)}
  end
  def handle_info({:filter_changed, %{ id: :plants, selected: selected }}, socket) do
    new_filters = %Filters{ socket.assigns.filters | plants: selected }
    {:noreply, assign(socket, filters: new_filters)}
  end

  defp get_poll_items do
    bins = Api.bins()
    move_tickets = Api.move_tickets()
    work_orders = Api.work_orders()
    { bins, move_tickets, work_orders }
  end

  defp get_permanent_items do
    plants = Api.plants()
    users = Api.users()
    { plants, users }
  end
end
