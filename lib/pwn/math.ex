defmodule Pwn.Math do
  @moduledoc """
  Misc math operations
  """

  import Bitwise, only: [<<<: 2, >>>: 2]

  @doc """
  Takes the integer square root

  Uses a recursive algorithm to determine the largest integer `r` for which

  ```
  r^2 <= n <= (r + 1)^2
  ```

  The integer square root function is quick and may be useful when an
  approximate square root is enough. The integer square root function is also
  important for arbitrary precision integers, as `:math.sqrt/1` does not
  support determining a square root for arbitrarily large integers.

  ## Examples

      iex> Pwn.Math.isqrt(10)
      3
      iex> Pwn.Math.isqrt(7)
      2
      iex> Pwn.Math.isqrt(786451287654321876453218765423187564321876543218765432187)
      28043738831588092587986363146
  """
  @spec isqrt(n :: integer()) :: integer()
  def isqrt(n)

  def isqrt(n) when is_integer(n) and n < 2, do: n

  def isqrt(n) when is_integer(n) do
    r0 = isqrt(n >>> 2) <<< 1
    r0_plus_one = r0 + 1

    if r0_plus_one * r0_plus_one > n, do: r0, else: r0_plus_one
  end

  @doc """
  Takes the modular multiplicative inverse of two numbers.

  Credit to the initial implementation:
  https://rosettacode.org/wiki/Modular_inverse#Elixir
  """
  def modular_multiplicative_inverse(e, et) do
    {g, x} = extended_gcd(e, et)

    if g != 1 do
      raise ArgumentError, "g must be 1"
    end

    rem(x + et, et)
  end

  defp extended_gcd(a, b) do
    {last_remainder, last_x} = extended_gcd(abs(a), abs(b), 1, 0, 0, 1)
    {last_remainder, last_x * if(a < 0, do: -1, else: 1)}
  end

  defp extended_gcd(last_remainder, 0, last_x, _, _, _),
    do: {last_remainder, last_x}

  defp extended_gcd(last_remainder, remainder, last_x, x, last_y, y) do
    quotient = div(last_remainder, remainder)
    remainder2 = rem(last_remainder, remainder)

    extended_gcd(
      remainder,
      remainder2,
      x,
      last_x - quotient * x,
      y,
      last_y - quotient * y
    )
  end
end
