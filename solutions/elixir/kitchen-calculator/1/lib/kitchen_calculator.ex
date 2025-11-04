defmodule KitchenCalculator do
  def get_volume({_, volume} = _volume_pair) do
    volume
  end

  def to_milliliter({:milliliter = _unit, volume} = _volume_pair) do
    {:milliliter, volume}
  end

  def to_milliliter({:cup = _unit, volume} = _volume_pair) do
    {:milliliter, volume * 240}
  end

  def to_milliliter({:fluid_ounce = _unit, volume} = _volume_pair) do
    {:milliliter, volume * 30}
  end

  def to_milliliter({:teaspoon = _unit, volume} = _volume_pair) do
    {:milliliter, volume * 5}
  end

  def to_milliliter({:tablespoon = _unit, volume} = _volume_pair) do
    {:milliliter, volume * 15}
  end

  def from_milliliter({_, volume} = _volume_pair, :milliliter = _unit) do
    {:milliliter, volume}
  end

  def from_milliliter({_, volume} = _volume_pair, :cup = _unit) do
    {:cup, volume / 240}
  end

  def from_milliliter({_, volume} = _volume_pair, :fluid_ounce = _unit) do
    {:fluid_ounce, volume / 30}
  end

  def from_milliliter({_, volume} = _volume_pair, :teaspoon = _unit) do
    {:teaspoon, volume / 5}
  end

  def from_milliliter({_, volume} = _volume_pair, :tablespoon = _unit) do
    {:tablespoon, volume / 15}
  end

  def convert(volume_pair, to_unit) do
    from_milliliter(to_milliliter(volume_pair), to_unit)
  end
end
