defmodule Reducer do
  def reduce(tuples) do
   values = Enum.map(tuples, fn tuple -> Map.get(key, :value) end)
   IO.puts elem(hd Map.to_list(tuples), 0) ++ Enum.reduce(values, fn total -> total++ end)
  end
end