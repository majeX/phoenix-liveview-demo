defmodule McfPhoenixWeb.PageView do
  use McfPhoenixWeb, :view

  def get_location_name(%{ "name" => name }) when is_bitstring(name) do
    name
  end

  def get_location_name(_) do
    "N/A"
  end
end
