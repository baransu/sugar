defmodule Sugar do

  def compile(content) do
    content
    |> Sugar.Tokenizer.tokenizer
    |> Sugar.Parser.parser
  end

end
