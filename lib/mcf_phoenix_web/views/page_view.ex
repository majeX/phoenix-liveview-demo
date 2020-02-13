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

  def get_plants_options(plants) when length(plants) !== 0 do
    options =
      plants
      |> Enum.map(fn %{"name" => name, "id" => id} -> { name, id } end)
    [{:"All Plants", Filters.all()} | options]
  end

  def get_plants_options(_) do
    []
  end

  def get_bins(bins, filters) do
    bins
    |> Filters.apply_work_orders_filters(filters)
    |> Filters.apply_plants_filters(filters, :bins)
  end

  def get_move_tickets(move_tickets, type, filters) do
    move_tickets
    |> Filters.apply_work_orders_filters(filters)
    |> Filters.apply_plants_filters(filters, :move_tickets)
    |> Enum.filter(&(&1["type"] === type))
  end

  def get_plant(%{ "currentLocation" => %{ "plantId" => plant_id } }, plants), do: get_plant_name(plant_id, plants)
  def get_plant(%{ "sourceLocation" => %{ "plantId" => plant_id } }, plants), do: get_plant_name(plant_id, plants)

  def get_plant_name(plant_id, plants) do
    plant = Enum.find(plants, &(&1["id"] === plant_id))
    plant["name"]
  end
end
