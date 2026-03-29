defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class() do
    Enum.random(@planetary_classes)
  end

  def random_ship_registry_number() do
    "NCC-" <> Integer.to_string(:rand.uniform(9000) + 999)
  end

  def random_stardate() do
    :rand.uniform() * 1000.0 + 41000.0
  end

  def format_stardate(stardate) when is_float(stardate) do
    (stardate * 10)
    |> :erlang.round()
    |> Kernel./(10)
    |> Float.to_string()
  end

  def format_stardate(_stardate) do
    raise ArgumentError, "stardate must be a float"
  end
end
