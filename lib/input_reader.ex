defmodule InputReader do
  use Mapper

  def reader(file, partition) do
    case File.read(file) do
      {:ok, body}      -> Enum.map(Regex.split( ~r/\r|\n|\r\n/, String.trim(text)), fn line -> spawn Mapper.map(line, partition))
      {:error, reason} -> IO.puts "File Error: #{reason}"
    end
  end
end