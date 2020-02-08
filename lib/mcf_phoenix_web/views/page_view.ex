defmodule McfPhoenixWeb.PageView do
  use McfPhoenixWeb, :view
  alias McfPhoenix.Filters

  def get_location_name(%{ "name" => name }) when is_bitstring(name) do
    name
  end

  def get_location_name(_) do
    "N/A"
  end

  def get_work_orders_options(work_orders) when length(work_orders) !== 0 do
    options =
      work_orders
      |> Enum.map(fn %{"name" => name, "id" => id} -> { name, id } end)
    [{:"All Work Orders", Filters.all()} | options]
  end

  def get_work_orders_options(_) do
    []
  end

  def get_bins(bins, filters) do
    bins
    |> Filters.apply_work_order_filters(filters)
  end

  def get_move_tickets(move_tickets, type, filters) do
    move_tickets
    |> Filters.apply_work_order_filters(filters)
    |> Enum.filter(&(&1["type"] === type))
  end
end
