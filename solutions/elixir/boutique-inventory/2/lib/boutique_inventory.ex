defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, fn item -> item[:price] end, :asc)
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, fn item -> item[:price] == nil end)
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn item ->
      %{item | name: String.replace(item[:name], old_word, new_word)}
    end)
  end

  def increase_quantity(item, count) do
    item
    |> Map.update!(:quantity_by_size, fn quantities ->
      quantities
      |> Enum.into(%{})
      |> Enum.map(fn {size, qty} -> {size, qty + count} end)
      |> Map.new()
    end)
  end

  def total_quantity(item) do
    item[:quantity_by_size]
    |> Enum.reduce(0, fn {_size, qty}, acc -> acc + qty end)
  end
end
