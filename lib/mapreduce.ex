defmodule MapReduce do
  require InputReader
  require Partition
  require OutputWriter

  def main(args) do
    args |> parse_args |> pipeline
  end

  def pipeline([]) do
    IO.puts "No file given"
  end

  def pipeline(options) do
    partition = elem(Partition.start(), 1)
    InputReader.reader("#{options[:file]}", partition)
    OutputWriter.start()
  end

  defp parse_args(args) do
    {options, _, _} = OptionParser.parse(args,
      switches: [file: :string]
    )
    options
  end
end