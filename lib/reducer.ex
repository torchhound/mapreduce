defmodule Reducer do
  def reduce(tuples, output_writer) do
    send(output_writer, {:process_put, self()})
    case tuples do
      [] ->  IO.puts :stderr, "Empty List"
      tuples ->
        send(output_writer, {:value_put, "#{elem(hd(tuples), 0)} #{Enum.reduce(tuples, 0, fn ({_k, v}, total) -> v + total end)}"})
    end
  end
end