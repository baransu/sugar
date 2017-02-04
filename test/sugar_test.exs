defmodule SugarTest do
  use ExUnit.Case
  doctest Sugar

  @entry """
  (add 2 2.2)
  """

  @ast {:program, [
           {:call_expression, "add", [
               {:number_literal, "2"},
               {:number_literal, "2.2"},
             ]}
         ]}

  test "should compile source" do
    # assert Sugar.compile(@entry) == @ast
  end
end
