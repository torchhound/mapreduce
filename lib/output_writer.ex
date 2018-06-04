defmodule OutputWriter do
  def start do
    Task.start(fn -> stream() end)
  end

  defp stream do
    Enum.each(IO.stream(:stdio, :line), fn line -> File.write(Path.join("test", "output.txt"), line) end)
  end
end