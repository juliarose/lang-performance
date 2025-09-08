defmodule StringTrim do
  def create_list(s) do
    for _ <- 1..1_000_000, do: String.trim(s)
  end
end

s = "            The President of the United States   "
{time_in_microseconds, _ret_val} = :timer.tc(fn -> StringTrim.create_list(s) end)

IO.puts("#{time_in_microseconds / 1_000}ms")
