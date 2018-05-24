defmodule Formatter do
  def format(file) do
    case File.read(file) do
      {:ok, body}      -> IO.puts body
      {:error, reason} -> IO.puts reason
    end
  end
end