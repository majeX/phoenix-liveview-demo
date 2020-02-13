defmodule McfPhoenixWeb.Components.MultiSelectComponent do
  use Phoenix.LiveComponent
  alias McfPhoenixWeb.MultiSelectView
  require Logger

  def render(assigns), do: MultiSelectView.render("multi_select.html", assigns)

  def handle_event("change_filter", params, socket) do
    id = socket.assigns.id
    string_id = to_string(id)
    selected = params
      |> Map.get(string_id)
      |> Map.get("selected")
    send(self(), {:filter_changed, %{ id: id, selected: selected }})

    { :noreply, socket }
  end
end
