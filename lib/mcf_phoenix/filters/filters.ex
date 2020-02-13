defmodule McfPhoenix.Filters do
  @moduledoc false
  require Logger
  alias __MODULE__

  @all "all"

  defstruct work_orders: [@all], plants: [@all]

  def all do
    @all
  end

  def apply_work_orders_filters(items, %Filters{work_orders: selected_orders}) do
    includes_all = selected_orders
      |> Enum.any?(fn order_id -> order_id === @all end)
    if (includes_all) do
      items
    else
      items
        |> Enum.filter(&filter_by_work_order_id(&1, selected_orders))
    end
  end
  def apply_work_orders_filters(items, _) do
    items
  end

  def apply_plants_filters(items, %Filters{plants: selected_plants}, type) do
    includes_all = selected_plants
      |> Enum.any?(fn plant_id -> plant_id === @all end)
    if (includes_all) do
      items
    else
      items
        |> Enum.filter(&filter_by_plant_id(&1, selected_plants, type))
    end
  end
  def apply_plants_filters(items, _, _) do
    items
  end

  defp filter_by_work_order_id(%{ "workOrderId" => work_order_id }, filters) do
    Enum.any?(filters, fn filter -> filter === to_string(work_order_id) end)
  end
  defp filter_by_work_order_id(_, _),do: false

  defp filter_by_plant_id(%{ "currentLocation" => %{ "plantId" => plant_id } }, filters, :bins) do
    Enum.any?(filters, fn filter -> filter === to_string(plant_id) end)
  end
  defp filter_by_plant_id(%{ "sourceLocation" => %{ "plantId" => plant_id } }, filters, :move_tickets) do
    Enum.any?(filters, fn filter -> filter === to_string(plant_id) end)
  end
  defp filter_by_plant_id(_, _, _), do: false
end
