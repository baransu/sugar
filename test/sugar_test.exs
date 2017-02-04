defmodule SugarTest do
  use ExUnit.Case
  doctest Sugar

  @entry """
  add(Int, Int) -> Int
  add(x, y) -> x + y
  add(x, 1) ->
    y = 1 + 1
  """

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
               {:function_call, "y", []},
               {:assignment, [
                   {:number_literal, "1"},
                   {:operator, "+"},
                   {:number_literal, "1"},
                 ]},
             ]},
         ]}

  test "should compile source" do
    assert Sugar.compile(@entry) == @ast
  end
end
