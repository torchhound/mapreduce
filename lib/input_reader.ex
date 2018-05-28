defmodule InputReader do
  require Mapper

  def reader(file, partition) do
    case File.read(file) do
      {:ok, body}      -> Enum.map(Regex.split( ~r/\r|\n|\r\n/, String.trim(body)), fn line -> spawn(fn -> Mapper.map(line, partition) end) end)
      {:error, reason} -> IO.puts "File Error: #{reason}"
    end
  end
end