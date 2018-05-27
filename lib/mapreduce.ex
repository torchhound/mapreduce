defmodule MapReduce do
  use InputReader
  use Partition
  use OutputWriter

  def main(args) do
    args |> parse_args |> pipeline
  end

  def pipeline([]) do
    IO.puts "No file given"
  end

  def pipeline(options) do
    partition = Partition.start()
    output = OutputWriter.start()
    InputReader.reader("#{options[:file]}", partition)
  end

  defp parse_args(args) do
    {options, _, _} = OptionParser.parse(args,
      switches: [file: :string]
    )
    options
  end
end