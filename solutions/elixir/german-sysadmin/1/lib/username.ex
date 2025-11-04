defmodule Username do
  def sanitize([]), do: []
  def sanitize([username_head | username_tail]) do
    case username_head do
      ?ä -> ~c"ae" ++ sanitize(username_tail)
      ?ö -> ~c"oe" ++ sanitize(username_tail)
      ?ü -> ~c"ue" ++ sanitize(username_tail)
      ?ß -> ~c"ss" ++ sanitize(username_tail)
      ?_ -> [?_ | sanitize(username_tail)]
      username_head when username_head not in ?a..?z -> sanitize(username_tail)
      _ -> [username_head | sanitize(username_tail)]
    end

  end
end
