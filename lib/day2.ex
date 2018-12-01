defmodule Day2 do
  @moduledoc """
  """

  @doc ~S"""
  For the first star of Day 2

  ## Examples

      iex> Day2.star1
      :ok
  """
  def star1, do: :ok

  @doc """
  For the second star of Day 2

  ## Examples

      iex> Day2.star2
      :ok
  """
  def star2, do: :ok

  defp data do
    2
    |> AdventOfCode2018.read_file()
    |> parse_data
  end

  defp parse_data(data) do
    data
  end
end
