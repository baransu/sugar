defmodule Sugar.Tokenizer do

  def remove_by_regex({regex, type}, string) do
    case Regex.run(regex, string, return: :index) do
      [{_, e} | _] ->
        case String.split_at(string, e) do
          {head, tail} -> {[{type, head}], tail}
          _ -> {[], string}
        end
      _ -> {[], string}
    end
  end

  def process_regex(expression, {acc, string}) do
    {tokens, str} = remove_by_regex(expression, String.trim(string))
    {acc ++ tokens, str}
  end

  def tokenize("", acc), do: acc
  def tokenize(string, acc) do
    {tokens, str} =
      [ {~r/^[a-z]+(_[a-z]+)*/, :name},
        {~r/^([0-9]\.?[0-9]*)/, :number},
        {~r/^".*?"/, :string},
        {~r/^\(/, :l_paren},
        {~r/^\)/, :r_paren},
        {~r/^\,/, :coma},
      {~r/^->/, :r_arrow},
      {~r/^(\*|\/|\+|-|=)/, :operator},
        {~r/^[A-Z][a-z]+(?:[A-Z][a-z]+)*/, :type},
        {~r/^#.*/, :comment},
      ]
      |> Enum.reduce({[], string}, &process_regex/2)
    cond do
      str == string -> IO.puts(:stderr, "Undefined token: " <> str)
      true -> tokenize(str, acc ++ tokens)
    end
  end

  def get_indent(line) do
    case Regex.run(~r/^\s*/, line, return: :index) do
      [{s, e} | _] ->
        case String.split_at(line, e) do
          {_, tail} -> {e, tail}
          _ -> {e, line}
        end
      _ -> {0, line}
    end
  end

  @doc """
  Lexical analysis
  """
  def tokenizer(content) do
    content
    |> String.split("\n")
    |> Enum.filter(fn x -> String.length(x) > 0 end)
    |> Enum.map(&get_indent/1)
    |> Enum.reduce([], fn({indent, line}, acc) ->
      tokenize(line, acc ++ [{:indent, indent}])
    end)
  end
end
