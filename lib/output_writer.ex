defmodule OutputWriter do
  def start do
    Task.start(fn -> stream() end)
  end

  defp stream do
    IO.stream(:stdio, :line) |> write_output
  end

  defp write_output(stream) do
  	data = Enum.to_list(stream)
  	:ok = File.write(Path.join("test", "output.txt"), data)
  	#Enum.each(stream, fn line -> File.write(Path.join("test", "output.txt"), line) end)
  end
end