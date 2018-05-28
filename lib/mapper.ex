defmodule Mapper do
  def map(line, partition) do
    send(partition, {:process_put, self()})
    Enum.map(String.split(line, " "), fn key -> send(partition, {:value_put, key}) end)
  end
end