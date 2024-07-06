defmodule StringTrim do
  def create_list() do
    Stream.repeatedly(fn -> String.trim("            The President of the United States   ") end)
    |> Enum.take(1_000_000)
  end
end

{time_in_microseconds, _ret_val} = :timer.tc(&StringTrim.create_list/0)

IO.puts("#{time_in_microseconds / 1_000}ms")
