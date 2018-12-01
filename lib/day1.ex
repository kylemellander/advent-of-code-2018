defmodule Day1 do
  @moduledoc """
  After feeling like you've been falling for a few minutes, you look at the
  device's tiny screen. "Error: Device must be calibrated before first use.
  Frequency drift detected. Cannot maintain destination lock." Below the
  message, the device shows a sequence of changes in frequency (your puzzle
  input). A value like +6 means the current frequency increases by 6; a value
  like -3 means the current frequency decreases by 3.

  For example, if the device displays frequency changes of +1, -2, +3, +1, then
  starting from a frequency of zero, the following changes would occur:

  ```
  Current frequency  0, change of +1; resulting frequency  1.
  Current frequency  1, change of -2; resulting frequency -1.
  Current frequency -1, change of +3; resulting frequency  2.
  Current frequency  2, change of +1; resulting frequency  3.
  In this example, the resulting frequency is 3.
  ```

  Here are other example situations:

  ```
  +1, +1, +1 results in  3
  +1, +1, -2 results in  0
  -1, -2, -3 results in -6
  ```
  """

  @doc """
  For the first star of Day 1

  Starting with a frequency of zero, what is the resulting frequency after all
  of the changes in frequency have been applied?

  ## Examples

      iex> Day1.star1
      574
  """
  def star1, do: star1(data())
  def star1(data) when is_list(data), do: Enum.reduce(data, 0, &sum/2)

  @doc ~S"""
  ## Examples

      iex> Day1.star1("+1\n-2\n+3\n+1\n")
      3
      iex> Day1.star1("+1\n+1\n+1\n")
      3
      iex> Day1.star1("+1\n+1\n-2\n")
      0
      iex> Day1.star1("-1\n-2\n-3\n")
      -6
  """
  def star1(data), do: data |> parse_data |> star1

  @doc """
  For the second star of Day 1

  You notice that the device repeats the same frequency change list over and
  over. To calibrate the device, you need to find the first frequency it reaches
  twice.

  For example, using the same list of changes above, the device would loop as
  follows:

  ```
  Current frequency  0, change of +1; resulting frequency  1.
  Current frequency  1, change of -2; resulting frequency -1.
  Current frequency -1, change of +3; resulting frequency  2.
  Current frequency  2, change of +1; resulting frequency  3.
  (At this point, the device continues from the start of the list.)
  Current frequency  3, change of +1; resulting frequency  4.
  Current frequency  4, change of -2; resulting frequency  2, which has already
  been seen.
  ```

  In this example, the first frequency reached twice is 2. Note that your device
  might need to repeat its list of frequency changes many times before a
  duplicate frequency is found, and that duplicates might be found while in the
  middle of processing the list.

  Here are other examples:

  ```
  +1, -1 first reaches 0 twice.
  +3, +3, +4, -2, -4 first reaches 10 twice.
  -6, +3, +8, +5, -6 first reaches 5 twice.
  +7, +7, -2, -7, -4 first reaches 14 twice.
  ```

  What is the first frequency your device reaches twice?
  ## Example

      iex> Day1.star2
      452
  """
  def star2, do: star2(data())
  def star2(data) when is_list(data) do
    search_for_duplicate({:not_ok, 0, %{0 => 1}}, data)
  end
  def star2(data), do: data |> parse_data |> star2

  defp sum(n, acc) do
    n + acc
  end

  defp search_for_duplicate({:ok, result, _}, _), do: result
  defp search_for_duplicate(state, data) do
    data
    |> Enum.reduce(state, &first_duplicate_sum_finder/2)
    |> search_for_duplicate(data)
  end

  defp first_duplicate_sum_finder(_, {:ok, a, b}), do: {:ok, a, b}
  defp first_duplicate_sum_finder(n, {:not_ok, sum, previous_sums}) do
    new_sum = n + sum

    case previous_sums |> Map.get(new_sum) do
      1 -> {:ok, new_sum, nil}
      _ -> {:not_ok, new_sum, Map.merge(previous_sums, %{new_sum => 1})}
    end
  end

  defp data do
    1
    |> AdventOfCode2018.read_file()
    |> parse_data
  end

  defp parse_data(data) do
    data
    |> String.replace(~r/\n$/, "")
    |> String.replace("+", "")
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end
end
