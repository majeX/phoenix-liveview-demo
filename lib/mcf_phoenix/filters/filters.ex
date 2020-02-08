defmodule McfPhoenix.Filters do
  @moduledoc false

  @all "all"

  defstruct work_order: [@all], plant: [@all]

  def types do
    %{
      work_order: {:array, :string},
      plant: {:array, :string}
    }
  end
end
