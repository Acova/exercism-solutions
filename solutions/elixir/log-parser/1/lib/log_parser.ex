defmodule LogParser do
  def valid_line?(line) do
    line =~ ~r/(^\[DEBUG\]|\[INFO\]|\[WARNING\]|\[ERROR\])/
  end

  def split_line(line) do
    String.split(line, ~r/<[=~*-]*>/)
  end

  def remove_artifacts(line) do
    String.replace(line, ~r/end-of-line[0-9]+/i, "")
  end

  def tag_with_user_name(line) do
    username = Regex.run(~r/User\s*(\S+)/, line, capture: :all_but_first)
    cond do
      username == nil -> line
      true -> "[USER] #{username} " <> line
    end
  end
end
