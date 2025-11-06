defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    keys = String.split(path, ".")
    extract_value(data, keys)
  end

  defp extract_value(data, []), do: data
  defp extract_value(data, [key | rest]) do
    if data[key] do
      extract_value(data[key], rest)
    else
      nil
    end
  end

  def get_in_path(data, path) do
    Kernel.get_in(data, String.split(path, "."))
  end
end
