defmodule NameBadge do
  def print(id, name, department) do
    formated_id = if id == nil, do: "", else: "[#{id}] - "
    formated_department = if department == nil, do: "OWNER", else: String.upcase(department)
    "#{formated_id}#{name} - #{formated_department}"
  end
end
