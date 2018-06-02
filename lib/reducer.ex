defmodule Reducer do
  def reduce(tuples, terminate) do
    send(terminate, {:process_put, self()})
    case tuples do
      [] ->  IO.puts :stderr, "Empty List"
      tuples -> IO.puts "#{elem(hd(tuples), 0)} #{Enum.reduce(tuples, 0, fn ({_k, v}, total) -> v + total end)}"
    end
  end
end