defmodule Day201525 do
  def start_number, do: 20151125

  @moduledoc """
  ## Examples

      iex> Day201525.star1
      2650453
  """
  def star1, do: data() |> star1
  @doc ~S"""
  ## Example

      iex> Day201525.star1(%{x: 4, y: 2})
      7726640
  """
  def star1(data) do
    position = data |> position()
    2..position
    |> Enum.reduce(start_number(), fn(_, current_number) ->
      current_number * 252533
      |> Integer.mod(33554393)
    end)
  end

  @doc ~S"""
  ## Example

      iex> Day201525.position(%{x: 4, y: 2})
      14
  """
  def position(%{x: x, y: y}) do
    (x + y - 1)
    |> first_number_of_row({1, 1})
    |> Kernel.+(x - 1)
  end

  defp first_number_of_row(n, {row, number}) do
    case row == n do
      true -> number
      false -> first_number_of_row(n, {row + 1, number + row})
    end
  end

  defp data do
    %{x: 3083, y: 2978}
  end
end
