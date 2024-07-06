defmodule Formatter do
  def num_to_thousands(number) do
    number
    |> Integer.to_string()
    |> String.reverse()
    |> String.graphemes()
    |> Enum.chunk_every(3)
    |> Enum.join(",")
    |> String.reverse()
  end
end

defmodule NumberList do
  def create_list do
    Stream.repeatedly(fn -> :rand.uniform(1_000_000) end)
    |> Enum.take(1_000_000)
    |> Enum.sort()
    |> Stream.map(&Formatter.num_to_thousands/1)
  end
end

{time_in_microseconds, _ret_val} = :timer.tc(&NumberList.create_list/0)

IO.puts("#{time_in_microseconds / 1_000}ms")
