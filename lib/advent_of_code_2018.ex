defmodule AdventOfCode2018 do
  @moduledoc """
  Documentation for AdventOfCode2018.
  """

  def read_file(n) do
    case File.read "inputs/day#{n}.txt" do
      {:ok, result} -> result
      _ -> ""
    end
  end
end
