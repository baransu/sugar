defmodule SugarTest.Parser do
  use ExUnit.Case
  doctest Sugar

  alias Sugar.Parser

  @tokens [
    {:lparen, "("},
    {:function, "add"},
    {:number, "2"},
    {:lparen, "("},
    {:function, "multiply"},
    {:number, "10"},
    {:number, "4"},
    {:rparen, ")"},
    {:number, "2.2"},
    {:rparen, ")"},
    {:lparen, "("},
    {:function, "something"},
    {:rparen, ")"}
  ]

  @ast {:program, [
           {:call_expression, "add", [
               {:number_literal, "2"},
               {:call_expression, "multiply", [
                   {:number_literal, "10"},
                   {:number_literal, "4"}
                 ]},
               {:number_literal, "2.2"}
             ]},
           {:call_expression, "something", []}
         ]}

  test "should create correct AST" do
    assert Parser.parser(@tokens) == @ast
  end
end
