defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part(
        {:def, _, [{:when, _, [{operation, _, args} | _]} | _]} = ast,
        acc
      ) do
    arity = length(args || [])

    func_name =
      operation
      |> Atom.to_string()
      |> String.slice(0, arity)

    {ast, [func_name | acc]}
  end

  def decode_secret_message_part(
        {:defp, _, [{:when, _, [{operation, _, args} | _]} | _]} = ast,
        acc
      ) do
    arity = length(args || [])

    func_name =
      operation
      |> Atom.to_string()
      |> String.slice(0, arity)

    {ast, [func_name | acc]}
  end

  def decode_secret_message_part({:def, _, [{operation, _, args}, _]} = ast, acc) do
    arity = length(args || [])

    func_name =
      operation
      |> Atom.to_string()
      |> String.slice(0, arity)

    {ast, [func_name | acc]}
  end

  def decode_secret_message_part({:defp, _, [{operation, _, args}, _]} = ast, acc) do
    arity = length(args || [])

    func_name =
      operation
      |> Atom.to_string()
      |> String.slice(0, arity)

    {ast, [func_name | acc]}
  end

  def decode_secret_message_part(ast, acc) do
    {ast, acc}
  end

  def decode_secret_message(string) do
    ast = to_ast(string)
    {_, acc} = Macro.prewalk(ast, [], &decode_secret_message_part/2)

    acc
    |> Enum.reverse()
    |> Enum.join()
  end
end
