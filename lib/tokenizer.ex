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
      [ {~r/^([a-z])+/i, :function},
        {~r/^([0-9]\.?[0-9]*)/, :number},
        {~r/^".*?"/, :string},
        {~r/^\(/, :lparen},
        {~r/^\)/, :rparen},
        {~r/^#.*/, :comment}
      ]
      |> Enum.reduce({[], string}, &process_regex/2)
    cond do
      str == string -> IO.puts(:stderr, "Undefined token: " <> str)
      true -> tokenize(str, acc ++ tokens)
    end
  end

  def tokenizer(content) do
    content
    |> String.split("\n")
    |> Enum.reduce([], &tokenize/2)
  end
end
