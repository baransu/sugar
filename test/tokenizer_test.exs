defmodule SugarTest.Tokenizer do
  use ExUnit.Case
  doctest Sugar

  alias Sugar.Tokenizer

  @entry """
  add(Int, Int) -> Int
  add(x, y) -> x + y
  add(x, 1) ->
    y = x * x
  """

  @tokens [
    {:indent, 0},
    {:name, "add"},
    {:l_paren, "("},
    {:type, "Int"},
    {:coma, ","},
    {:type, "Int"},
    {:r_paren, ")"},
  {:r_arrow, "->"},
  {:type, "Int"},
    {:indent, 0},
  {:name, "add"},
  {:l_paren, "("},
  {:name, "x"},
  {:coma, ","},
  {:name, "y"},
  {:r_paren, ")"},
{:r_arrow, "->"},
    {:name, "x"},
  {:operator, "+"},
    {:name, "y"},
    {:indent, 0},
    {:name, "add"},
    {:l_paren, "("},
    {:name, "x"},
    {:coma, ","},
    {:number, "1"},
    {:r_paren, ")"},
  {:r_arrow, "->"},
  {:indent, 2},
  {:name, "y"},
    {:operator, "="},
  {:name, "x"},
  {:operator, "*"},
  {:name, "x"}
  ]

  test "should create tokens" do
    assert Tokenizer.tokenizer(@entry) == @tokens
  end
end
