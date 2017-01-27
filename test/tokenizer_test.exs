defmodule SugarTest.Tokenizer do
  use ExUnit.Case
  doctest Sugar

  alias Sugar.Tokenizer

  @entry """
  ( add 2 2.2 ) FUNCTION #asdasd
  "asdasd"
  """

  @tokens [
    {:lparen, "("},
    {:function, "add"},
    {:number, "2"},
    {:number, "2.2"},
    {:rparen, ")"},
    {:function, "FUNCTION"},
    {:comment, "#asdasd"},
    {:string, "\"asdasd\""}
  ]

  test "should create tokens" do
    assert Tokenizer.tokenizer(@entry) == @tokens
  end
end
