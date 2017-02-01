defmodule SugarTest.Parser do
  use ExUnit.Case
  doctest Sugar

  alias Sugar.Parser

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
  {:name, "x"},
    {:operator, "*"},
  {:name, "x"}
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
