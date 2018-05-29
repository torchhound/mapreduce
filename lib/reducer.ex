defmodule Reducer do
  def reduce(tuples) do
    IO.inspect tuples
    cond do
      is_list(tuples)  -> IO.puts elem(hd(tuples), 0) ++  " " ++ Enum.reduce(tuples, fn ({_, v}, total) -> v + total end)
      is_tuple(tuples) -> IO.puts elem(tuples, 0) ++ " " ++ elem(tuples, 1)
    end
  end
end