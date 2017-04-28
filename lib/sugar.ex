defmodule Sugar do

  def compile(content) do
    # tokenizer - should generate tokens from source file
    # parser - should generate ast from tokens
    # optimization - group function clauses, remove syntax sugars
    # converting ast from sugar to js
    # code generation
    content
    |> Sugar.Tokenizer.tokenizer
    |> Sugar.Parser.parser
  end

end
