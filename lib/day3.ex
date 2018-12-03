defmodule Day3 do
  @moduledoc """
  --- Day 3: No Matter How You Slice It ---

  The Elves managed to locate the chimney-squeeze prototype fabric for Santa's
  suit (thanks to someone who helpfully wrote its box IDs on the wall of the
  warehouse in the middle of the night). Unfortunately, anomalies are still
  affecting them - nobody can even agree on how to cut the fabric.

  The whole piece of fabric they're working on is a very large square - at least
  1000 inches on each side.
  """

  @doc """
  Each Elf has made a claim about which area of fabric would be ideal for
  Santa's suit. All claims have an ID and consist of a single rectangle with
  edges parallel to the edges of the fabric. Each claim's rectangle is defined
  as follows:

  - The number of inches between the left edge of the fabric and the left edge of the rectangle.
  - The number of inches between the top edge of the fabric and the top edge of the rectangle.
  - The width of the rectangle in inches.
  - The height of the rectangle in inches.

  A claim like #123 @ 3,2: 5x4 means that claim ID 123 specifies a rectangle 3
  inches from the left edge, 2 inches from the top edge, 5 inches wide, and 4
  inches tall. Visually, it claims the square inches of fabric represented by #
  (and ignores the square inches of fabric represented by .) in the diagram
  below:

  ```
  ...........
  ...........
  ...#####...
  ...#####...
  ...#####...
  ...#####...
  ...........
  ...........
  ...........
  ```

  The problem is that many of the claims overlap, causing two or more claims to
  cover part of the same areas. For example, consider the following claims:

  ```
  #1 @ 1,3: 4x4
  #2 @ 3,1: 4x4
  #3 @ 5,5: 2x2
  ```

  Visually, these claim the following areas:

  ```
  ........
  ...2222.
  ...2222.
  .11XX22.
  .11XX22.
  .111133.
  .111133.
  ........
  ```

  The four square inches marked with X are claimed by both 1 and 2. (Claim 3,
  while adjacent to the others, does not overlap either of them.)

  If the Elves all proceed with their own plans, none of them will have enough
  fabric. How many square inches of fabric are within two or more claims?

  ## Examples

      iex> Day3.star1
      111485
  """
  def star1, do: data() |> star1

  def star1(data) when is_list(data) do
    data
    |> calculate_point_counts()
    |> Enum.reduce(0, fn {_, value}, acc ->
      case value > 1 do
        true -> acc + 1
        false -> acc
      end
    end)
  end

  @doc ~S"""
  ## Example

      iex> Day3.star1("#1 @ 1,3: 4x4\n#2 @ 3,1: 4x4\n#3 @ 5,5: 2x2")
      4
  """
  def star1(data), do: data |> parse_data() |> star1()

  defp calculate_point_counts(data) do
    data
    |> Enum.reduce(%{}, fn line, acc ->
      line
      |> generate_rect_coordinates()
      |> Enum.reduce(acc, fn {key, value}, inner_acc ->
        Map.merge(inner_acc, %{key => (Map.get(inner_acc, key) || 0) + value})
      end)
    end)
  end

  defp generate_rect_coordinates(%{x: x, y: y, height: height, width: width}) do
    x..(x + width - 1)
    |> Enum.reduce(%{}, fn x, acc ->
      y..(y + height - 1)
      |> Enum.reduce(acc, fn y, inner_acc ->
        Map.merge(inner_acc, %{"#{x},#{y}": 1})
      end)
    end)
  end

  @doc """
  --- Part Two ---
  Amidst the chaos, you notice that exactly one claim doesn't overlap by even a
  single square inch of fabric with any other claim. If you can somehow draw
  attention to it, maybe the Elves will be able to make Santa's suit after all!

  For example, in the claims above, only claim 3 is intact after all claims are
  made.

  What is the ID of the only claim that doesn't overlap?

  ## Examples

      iex> Day3.star2
      113
  """
  def star2, do: data() |> star2()

  @doc ~S"""
  ## Examples

      iex> Day3.star2("#1 @ 1,3: 4x4\n#2 @ 3,1: 4x4\n#3 @ 5,5: 2x2")
      3
  """
  def star2(data) when is_list(data) do
    data
    |> calculate_point_counts()
    |> find_non_intersecting_rect(data)
    |> Map.get(:id)
  end

  def star2(data), do: data |> parse_data |> star2

  defp find_non_intersecting_rect(counts, data) do
    data
    |> Enum.find(fn %{x: x, y: y, height: height, width: width} ->
      x..(x + width - 1)
      |> Enum.reduce(true, fn x, acc ->
        y..(y + height - 1)
        |> Enum.reduce(acc, fn y, inner_acc ->
          inner_acc && Map.get(counts, String.to_atom("#{x},#{y}")) == 1
        end)
      end)
    end)
  end

  defp data do
    3
    |> AdventOfCode2018.read_file()
    |> parse_data
  end

  defp parse_data(data) do
    data
    |> String.trim()
    |> String.replace(
      ~r/#\d*\s@\s(\d*),(\d*):\s(\d*)x(\d*)/,
      "\\g{1},\\g{2},\\g{3},\\g{4}"
    )
    |> String.split("\n")
    |> Enum.with_index()
    |> Enum.map(fn {line, i} ->
      elements = String.split(line, ",")

      %{
        x: Enum.at(elements, 0) |> String.to_integer() |> Kernel.+(1),
        y: Enum.at(elements, 1) |> String.to_integer() |> Kernel.+(1),
        width: Enum.at(elements, 2) |> String.to_integer(),
        height: Enum.at(elements, 3) |> String.to_integer(),
        id: i + 1
      }
    end)
  end
end
