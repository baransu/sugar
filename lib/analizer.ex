defmodule Sugar.Analizer do

  alias Sugar.Store


  def is_signature({_, _, args, body}) do
    correct_args? = Enum.reduce(args, true, fn(a, acc) ->
      type? =
        case a do
          {:type_literal, _} -> true
          _ -> false
        end
      acc && type?
    end)
    correct_body? =
      case body do
        [{:type_literal, _} | nil] -> true
        _ -> false
      end
    correct_args? && correct_body?
  end

  def walk(store, {:function_def, name, args, body}) do
    case Store.get(store, name) do
      {:error, _} ->
        if is_signature({:function_def, name, args, body}) do
          [head | _] = body
          Store.put(store, name, {[args], head})
          {[args], head}
          #TODO walk body
          []
        else
          #TODO panic here
          []
        end
      {:ok, signature} -> [] # TODO walk body
    end
  end

  def walk(_store, something) do
    # TODO throw unexpected something
    []
  end

  def analize(ast) do
    {:ok, store} = Store.start_link()
    {:program, body} = ast
    new_body =
      body
      |> Enum.map(&walk(store, &1))
      |> Enum.filter(fn a -> Enum.count(a) > 0 end)
    {:program, new_body}
  end

end
