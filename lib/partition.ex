defmodule Partition do
  use Reducer

  def start do
    Task.start(fn -> loop([], %{}) end)
  end

  defp loop(processes, values) do
    life_check(processes)
    receive do
      {:process_put, _, caller} ->
        [caller] ++ processes
        loop(processes, values)
      {:value_put, key, caller} ->
        Map.put(values, key, 1)
        loop(processes, values)
    end
  end  

  defp life_check(processes) do
    check = Enum.filter(processes, fn process -> Process.alive?(process) != true end)
    if length(check) == 0, do: (
      uniques = Map.keys(values)
      Enum.map(uniques, fn unique -> spawn Reducer.reduce(Enum.reduce(values, fn value -> value == unique end)) end) #all of each key to unique process
      Process.exit(self())
    )
  end

end