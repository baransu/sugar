defmodule Sugar.Parser do

  def walk([], acc), do: {[], acc}
  def walk([{:lparen, _} | tail], acc) do
    [{_, value} | t] = tail
    {tokens, params} = walk(t, [])
    walk(tokens, acc ++ [{:call_expression, value, params}])
  end

  def walk([{:number, value} | tail], acc) do
    walk(tail, acc ++ [{:number_literal, value}])
  end

  def walk([{:string, value} | tail], acc) do
    walk(tail, acc ++ [{:string_literal, value}])
  end

  def walk([head | tail], acc) do
    case head do
      {:rparen, _} -> {tail, acc}
      {:function, value} -> IO.puts(:stderr, "Unexpected function: " <> value)
      _ -> walk(tail, acc)
    end
  end

  def parser(tokens) do
    {tail, body} = walk(tokens, [])
    {:program, body}
  end

end
