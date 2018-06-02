defmodule Terminate do
  def start_link do
    Task.start_link(fn -> loop([]) end)
  end

  defp loop(processes) do
    reducer_check(processes)
    receive do
      {:process_put, caller} ->
        loop([caller | processes])
    end
  end  

  defp reducer_check(processes) do
    check = Enum.filter(processes, fn process -> Process.alive?(process) == true end)
    if length(check) == 0, do: (
      Process.exit(self(), :kill)
    )
  end
end