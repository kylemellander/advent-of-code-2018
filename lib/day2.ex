defmodule Day2 do
  @moduledoc """
  --- Day 2: Inventory Management System ---

  You stop falling through time, catch your breath, and check the screen on the
  device. "Destination reached. Current Year: 1518. Current Location: North Pole
  Utility Closet 83N10." You made it! Now, to find those anomalies.

  Outside the utility closet, you hear footsteps and a voice. "...I'm not sure
  either. But now that so many people have chimneys, maybe he could sneak in
  that way?" Another voice responds, "Actually, we've been working on a new kind
  of suit that would let him fit through tight spaces like that. But, I heard
  that a few days ago, they lost the prototype fabric, the design plans,
  everything! Nobody on the team can even seem to remember important details of
  the project!"

  "Wouldn't they have had enough fabric to fill several boxes in the warehouse?
  They'd be stored together, so the box IDs should be similar. Too bad it would
  take forever to search the warehouse for two similar box IDs..." They walk too
  far away to hear any more.

  Late at night, you sneak to the warehouse - who knows what kinds of paradoxes
  you could cause if you were discovered - and use your fancy wrist device to
  quickly scan every box and produce a list of the likely candidates (your
  puzzle input).
  """

  @doc ~S"""
  To make sure you didn't miss any, you scan the likely candidate boxes again,
  counting the number that have an ID containing exactly two of any letter and
  then separately counting those with exactly three of any letter. You can
  multiply those two counts together to get a rudimentary checksum and compare
  it to what your device predicts.

  For example, if you see the following box IDs:

  ```
  abcdef contains no letters that appear exactly two or three times.
  bababc contains two a and three b, so it counts for both.
  abbcde contains two b, but no letter appears exactly three times.
  abcccd contains three c, but no letter appears exactly two times.
  aabcdd contains two a and two d, but it only counts once.
  abcdee contains two e.
  ababab contains three a and three b, but it only counts once.
  ```

  Of these box IDs, four of them contain a letter which appears exactly twice,
  and three of them contain a letter which appears exactly three times.
  Multiplying these together produces a checksum of 4 * 3 = 12.

  What is the checksum for your list of box IDs?

  ## Examples

      iex> Day2.star1
      7192
  """
  def star1, do: data() |> star1

  @doc ~S"""
  ## Example

      iex> Day2.star1(["abcdef", "bababc", "abbcde", "abcccd", "aabcdd", "abcdee", "ababab"])
      12
  """
  def star1(data) do
    %{"2": twos, "3": threes} = data |> find_boxes
    Enum.count(twos) * Enum.count(threes)
  end

  defp find_boxes(data) do
    data
    |> Enum.reduce(%{"2": [], "3": []}, &find_counts/2)
  end

  defp find_counts(line, %{"2": twos, "3": threes}) do
    new_twos = if repeats?(line, 2), do: [line | twos], else: twos
    new_threes = if repeats?(line, 3), do: [line | threes], else: threes
    %{"2": new_twos, "3": new_threes}
  end

  defp repeats?(line, count) do
    line
    |> String.graphemes()
    |> Enum.any?(fn char ->
      Regex.scan(~r/#{char}/, line)
      |> Enum.count()
      |> Kernel.==(count)
    end)
  end

  @doc """
  --- Part Two ---
  Confident that your list of box IDs is complete, you're ready to find the
  boxes full of prototype fabric.

  The boxes will have IDs which differ by exactly one character at the same
  position in both strings. For example, given the following box IDs:

  ```
  abcde
  fghij
  klmno
  pqrst
  fguij
  axcye
  wvxyz
  ```

  The IDs abcde and axcye are close, but they differ by two characters (the
  second and fourth). However, the IDs fghij and fguij differ by exactly one
  character, the third (h and u). Those must be the correct boxes.

  What letters are common between the two correct box IDs? (In the example
  above, this is found by removing the differing character from either ID,
  producing fgij.)

  ## Examples

      iex> Day2.star2
      "mbruvapghxlzycbhmfqjonsie"
  """
  def star2, do: data() |> star2()

  @doc """
  ## Examples

      iex> Day2.star2(["abcde", "fghij", "klmno", "pqrst", "fguij", "axcye", "wvxyz"])
      "fgij"
  """
  def star2(data), do: Enum.reduce_while(data, data, &find_similar/2)

  defp find_similar(line, [_ | rest]) do
    case line_has_similar(line, rest) do
      nil -> {:cont, rest}
      matcher -> {:halt, remove_diff(line, matcher)}
    end
  end

  defp line_has_similar(line, list) do
    list
    |> Enum.find(fn list_line ->
      0..(String.length(list_line) - 1)
      |> Enum.count(fn i -> !compare_strings_at?(line, list_line, i) end)
      |> Kernel.==(1)
    end)
  end

  defp remove_diff(a, b) do
    0..(String.length(a) - 1)
    |> Enum.reduce("", fn i, result ->
      if compare_strings_at?(a, b, i) do
        "#{result}#{String.at(a, i)}"
      else
        result
      end
    end)
  end

  defp compare_strings_at?(a, b, i) do
    String.at(a, i) == String.at(b, i)
  end

  defp data do
    2
    |> AdventOfCode2018.read_file()
    |> parse_data
  end

  defp parse_data(data) do
    data
    |> String.split("\n")
  end
end
