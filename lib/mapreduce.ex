defmodule MapReduce do
  require Formatter
  require Mapper
  require Reducer

  def main(args) do
    args |> parse_args |> pipeline
  end

  def pipeline([]) do
    IO.puts "No file given"
  end

  def pipeline(options) do
    Formatter.format("#{options[:file]}")
  end

  defp parse_args(args) do
    {options, _, _} = OptionParser.parse(args,
      switches: [file: :string]
    )
    options
  end
end