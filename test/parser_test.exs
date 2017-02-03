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
           {:function_definition, "add", [
               {:type_literal, "Int"},
               {:type_literal, "Int"}
             ], [
               {:type_literal, "Int"}
             ]},
           {:function_definition, "add", [
               {:name, "x"},
               {:name, "y"}
             ], [
               {:variable, "x"},
               {:operator, "+"},
               {:variable, "y"},
             ]},
           {:function_definition, "add", [
               {:variable, "Int"},
               {:number_literal, "1"}
             ], [
               {:variable, "x"},
               {:operator, "+"},
               {:variable, "x"},
             ]},
         ]}

  test "should create correct AST" do
    assert Parser.parser(@tokens) == @ast
  end
end
