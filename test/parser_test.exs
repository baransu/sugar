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
           {:function_def, "add", [
               {:type_literal, "Int"},
               {:type_literal, "Int"}
             ], [
               {:type_literal, "Int"}
             ]},
           {:function_def, "add", [
               {:function_call, "x", []},
               {:function_call, "y", []}
             ], [
               {:function_call, "x", []},
               {:operator, "+"},
               {:function_call, "y", []},
             ]},
           {:function_def, "add", [
               {:function_call, "x", []},
               {:number_literal, "1"}
             ], [
               {:function_call, "x", []},
               {:operator, "*"},
               {:function_call, "x", []},
             ]},
         ]}

  test "should create correct AST" do
    assert Parser.parser(@tokens) == @ast
  end
end
