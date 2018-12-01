defmodule Day1Test do
  use ExUnit.Case
  doctest Day1

  test "star1/0 finds the sum for test cases when input is raw" do
    assert Day1.star1("+1\n-2\n+3\n+1\n") == 3
    assert Day1.star1("+1\n+1\n+1\n") == 3
    assert Day1.star1("+1\n+1\n-2\n") == 0
    assert Day1.star1("-1\n-2\n-3\n") == -6
  end

  test "star1/0 find the sum for test cases when input is parsed" do
    assert Day1.star1([1, 1, 1]) == 3
    assert Day1.star1([1, 1, -2]) == 0
    assert Day1.star1([-1, -2, -3]) == -6
  end

  test "star2/0 finds the first duplicate for test cases" do
    assert Day1.star2("+1\n-1\n") == 0
    assert Day1.star2("+3\n+3\n+4\n-2\n-4\n") == 10
    assert Day1.star2("-6\n+3\n+8\n+5\n-6\n") == 5
    assert Day1.star2("+7\n+7\n-2\n-7\n-4\n") == 14
  end
end
