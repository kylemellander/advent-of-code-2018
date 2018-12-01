defmodule AdventOfCode2018 do
  @moduledoc """
  "We've detected some temporal anomalies," one of Santa's Elves at the Temporal
  Anomaly Research and Detection Instrument Station tells you. She sounded pretty
  worried when she called you down here. "At 500-year intervals into the past,
  someone has been changing Santa's history!"

  "The good news is that the changes won't propagate to our time stream for
  another 25 days, and we have a device" - she attaches something to your
  wrist - "that will let you fix the changes with no such propagation delay.
  It's configured to send you 500 years further into the past every few days;
  that was the best we could do on such short notice."

  "The bad news is that we are detecting roughly fifty anomalies throughout
  time; the device will indicate fixed anomalies with stars. The other bad news
  is that we only have one device and you're the best person for the job! Good
  lu--" She taps a button on the device and you suddenly feel like you're
  falling. To save Christmas, you need to get all fifty stars by December 25th.

  Collect stars by solving puzzles. Two puzzles will be made available on each
  day in the advent calendar; the second puzzle is unlocked when you complete
  the first. Each puzzle grants one star. Good luck!
  """

  def read_file(n) do
    case File.read "inputs/day#{n}.txt" do
      {:ok, result} -> result
      _ -> ""
    end
  end
end
