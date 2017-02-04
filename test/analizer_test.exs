defmodule SugarTest.Analizer do
  use ExUnit.Case
  doctest Sugar

  alias Sugar.Analizer

  @ast {:program, [
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

  @intermediate_ast {:program, [
                      ]}

  test "should create intermediate ast" do
    assert Analizer.analize(@ast) == @intermediate_ast
  end
end
