defmodule McfPhoenix.Filters do
  @moduledoc false
  require Logger
  alias __MODULE__

  @all "all"

  defstruct work_orders: [@all], plants: [@all]

  def all do
    @all
  end

  def apply_work_order_filters(items, %Filters{work_orders: selected_orders}) do
    includes_all = selected_orders
      |> Enum.any?(fn order_id -> order_id === @all end)
    if (includes_all) do
      items
    else
      items
        |> Enum.filter(&filter_by_id(&1, selected_orders))
    end
  end
  def apply_work_order_filters(items, _) do
    items
  end


  defp filter_by_id(%{ "workOrderId" => work_order_id }, filters) do
    Enum.any?(filters, fn filter -> filter === to_string(work_order_id) end)
  end
  defp filter_by_id(_, _),do: false
end
