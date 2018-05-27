defmodule Partition do
  def start do
    Task.start_link(fn -> loop(%{}, %{}) end)
  end

  defp loop(processes, values) do
    life_check(processes)
    receive do
      {:process_put, _, caller} ->
        Map.put(processes, caller, Process.alive?(caller))
        loop(processes, values)
      {:value_put, key, caller} ->
        Map.put(values, key, 1)
        loop(processes, values)
    end
  end  

  defp life_check(processes) do
    Enum.map(processes, fn {process, alive} -> ) #check if all processes are dead
    #spawn a reduce process with all unique keys tuples
  end

end