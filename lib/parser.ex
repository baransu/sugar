defmodule Sugar.Parser do

  def walk([], i, acc), do: {[], acc}
  def walk([{:r_paren, _} | tail], i, acc), do: acc

  def walk([{:number, value} | tail], i, acc) do
    walk(tail, i, acc ++ [{:number_literal, value}])
  end

  def walk([{:type, value} | tail], i, acc) do
    walk(tail, i, acc ++ [{:type_literal, value}])
  end

  def walk([{:string, value} | tail], i, acc) do
    walk(tail, i, acc ++ [{:string_literal, value}])
  end

  def walk([{:name, value} | tail], indent, acc) do
    [h | t] = tail
    args =
      case h do
        {:l_paren, _} -> walk(t, indent, [])
        _ -> []
      end

    [next | tokens]  = t
    func =
      case next do
        {:r_arrow, _} ->
          {toks, body} = walk(tokens, indent, [])
          walk(
            toks,
            indent,
            acc ++ [{:function_expression, value, body}])
        _ ->
          walk(t, indent, acc ++ [{:call_expression, value, args}])
      end
  end

  def walk([head | tail], indent, acc) do
    walk(tail, indent, acc)
  end

  def walk([{:indent, i} | tail], indent, acc) when i < indent do
    {tail, acc}
  end

  def walk([{:indent, indent} | tail], _i, acc) do
    walk(tail, indent, acc)
  end

  def parser(tokens) do
    {tail, body} = walk(tokens, 0, [])
    {:program, body}
  end

end
