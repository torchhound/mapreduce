defmodule Reducer do
  def reduce(tuples) do
   IO.puts elem(hd(Map.to_list(tuples)), 0) ++ Enum.reduce(tuples, fn ({_, v}, total) -> v + total end)
  end
end