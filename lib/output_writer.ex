defmodule OutputWriter do
  def start_link do
    Task.start_link(fn -> loop() end)
  end

  defp loop() do
    IO.puts "output loop"
    IO.stream(:stdio, :line) |> Enum.into(File.stream!(Path.join("test", "output.txt")))
    loop()
  end
end