defmodule Sugar.Parser do

  def walk([], i, acc), do: {[], acc}
  def walk([{:r_paren, _} | tail], i, acc), do: {tail, acc}
  def walk([{:number, value} | tail], i, acc),
    do: walk(tail, i, acc ++ [{:number_literal, value}])

  def walk([{:type, value} | tail], i, acc),
    do: walk(tail, i, acc ++ [{:type_literal, value}])

  def walk([{:string, value} | tail], i, acc),
    do: walk(tail, i, acc ++ [{:string_literal, value}])

  def walk([{:operator, value} | tail], i, acc) do
    # TODO generate binary expression
    walk(tail, i, acc ++ [{:operator, value}])
  end

  def walk([{:indent, indent} | tail], i, acc) do
    cond do
      indent >= i -> {tail, acc}
      true -> walk(tail, indent, acc)
    end
  end

  def walk([{:name, value} | tail], indent, acc) do
    {tokens, args} =
      case tail do
        [{:l_paren, _} | t] -> walk(t, indent, [])
        _ -> {tail, []}
      end

    case tokens do
      [{:r_arrow, _} | tl] ->
        {toks, body} = walk(tl, indent, [])
        walk(
          toks,
          indent,
          acc ++ [{:function_def, value, args, body}])
      _ ->
        walk(tokens, indent, acc ++ [{:function_call, value, args}])
    end
  end

  def walk([head | tail], indent, acc) do
    walk(tail, indent, acc)
  end

  def parse([]), do: []
  def parse(tokens) do
    {tail, acc} = walk(tokens, 0, [])
    acc ++ parse(tail)
  end

  def parser(tokens) do
    {:program, parse(tokens)}
  end

end
