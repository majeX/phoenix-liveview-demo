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

    initial_filters = %Filters{}
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

  def handle_event("change_filter", %{"filter_work_orders" => %{ "work_orders" => selected_work_orders }} = params, socket) do
    new_filters = %Filters{ socket.assigns.filters | work_orders: selected_work_orders }
    {
      :noreply,
      assign(
        socket,
        filters: new_filters
      )
    }
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
end
