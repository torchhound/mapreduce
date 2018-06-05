defmodule Partition do
  require Reducer
  require Terminate

  def start_link do
    Task.start_link(fn -> loop([], []) end)
  end

  defp loop(processes, values) do
    mailbox_length = elem(Process.info(self(), :message_queue_len), 1)
    if (mailbox_length == 0), do: (
      mapper_check(processes, Keyword.delete(Keyword.delete(values, String.to_atom(~s(\s))), String.to_atom("")))
    )
    receive do
      {:process_put, caller} ->
        loop([caller | processes], values)
      {:value_put, key} ->
        loop(processes, [{String.to_atom(key), 1} | values])
      error -> IO.puts :stderr, "Partition Error: #{error}"
    end
  end  

  defp mapper_check(processes, values) do
    check = Enum.filter(processes, fn process -> Process.alive?(process) == true end)
    uniques = Enum.uniq(Keyword.keys(values))
    if (length(check) == 0 && length(uniques) != 0), do: (
      terminate = elem(Terminate.start_link, 1) 
      Enum.each(uniques, fn unique -> spawn(fn -> Reducer.reduce(Keyword.to_list(Keyword.take(values, [unique])), terminate) end) end)
    )
  end
end