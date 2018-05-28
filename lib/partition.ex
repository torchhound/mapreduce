defmodule Partition do
  require Reducer

  def start_link do
    Task.start_link(fn -> loop([], %{}) end)
  end

  defp loop(processes, values) do
    life_check(processes, values)
    IO.inspect values
    receive do
      {:process_put, caller} ->
        loop([caller | processes], values)
      {:value_put, key} ->
        IO.puts key
        loop(processes, Map.put(values, key, 1))
    end
  end  

  defp life_check(processes, values) do
    check = Enum.filter(processes, fn process -> Process.alive?(process) == true end)
    uniques = Map.keys(values)
    IO.puts "life_check"
    if (length(check) == 0 && length(uniques) != 0), do: (
      IO.puts "life_check if"
      Enum.map(uniques, fn unique -> spawn(Reducer.reduce(Enum.reduce(values, fn value -> value == unique end))) end)
      Process.exit(self(), :kill)
    )
  end
end