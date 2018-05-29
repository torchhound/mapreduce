defmodule OutputWriter do
  def start do
    Task.start(fn -> loop() end)
  end

  defp loop do
    IO.stream(:stdio, :line) |> Enum.into(File.stream!(Path.join("test", "output.txt")))
    loop() 
    #Process.exit(self(), :kill)
  end
end