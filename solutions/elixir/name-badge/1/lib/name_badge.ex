defmodule NameBadge do
  def print(id, name, department) do
    department = if department == nil, do: "OWNER", else: String.upcase(department)
    if id == nil do
      "#{name} - #{department}"
    else
      "[#{id}] - #{name} - #{department}"
    end

  end
end
