defmodule Mapper do
  def map(line, partition) do
    Enum.map(String.split(line, " "), fn key -> send partition, key)
  end
end