defmodule Partition do
  require Reducer

  def start do
    Task.start(fn -> loop([], %{}) end)
  end

  defp loop(processes, values) do
    life_check(processes, values)
    receive do
      {:process_put, caller} ->
        loop([caller | processes], values)
      {:value_put, key} ->
        loop(processes, Map.put(values, key, 1))
    end
  end  

  defp life_check(processes, values) do
    check = Enum.filter(processes, fn process -> Process.alive?(process) == true end)
    uniques = Map.keys(values)
    if (length(check) == 0 && length(uniques) != 0), do: (
      Enum.map(uniques, fn unique -> spawn(fn -> Reducer.reduce([Enum.reduce(values, fn value -> value == unique end) | []]) end) end)
      #Process.exit(self(), :kill)
    )
  end
end