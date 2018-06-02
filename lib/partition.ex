defmodule Partition do
  require Reducer
  require Terminate

  def start_link do
    Task.start_link(fn -> loop([], %{}) end)
  end

  defp loop(processes, values) do
    mapper_check(processes, values)
    receive do
      {:process_put, caller} ->
        loop([caller | processes], values)
      {:value_put, key} ->
        loop(processes, Map.put(values, key, 1))
    end
  end  

  defp mapper_check(processes, values) do
    check = Enum.filter(processes, fn process -> Process.alive?(process) == true end)
    uniques = Map.keys(values)
    if (length(check) == 0 && length(uniques) != 0), do: (
      terminate = elem(Terminate.start_link, 1)
      Enum.map(uniques, fn unique -> spawn(fn -> Reducer.reduce(Enum.filter(values, fn value -> elem(value, 0) == unique end), terminate) end) end)
    )
  end
end