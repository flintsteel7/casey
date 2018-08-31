defmodule Casey do
  @moduledoc """
  Documentation for Casey.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Casey.hello()
      :world

  """
  def hello do
    :world
  end

  def all_caps input do
    String.upcase(input, :greek)
  end

  def all_lower input do
    String.downcase(input, :greek)
  end

  def cap_words input do
    last_grapheme = ""
    input
    |> String.graphemes()
    |> Enum.map(fn grapheme ->
      last_grapheme = grapheme
      new_grapheme = with true <- Regex.match?(~r/^\S$/, grapheme),
           true <- Regex.match?(~r/^\s$/, last_grapheme)
      do
        String.upcase(grapheme)
      else
        _ ->
          grapheme
      end
      new_grapheme
    end)
    |> Enum.join()
  end

  def cap_sentences input do
    input
  end

  def cap_lines input do
    input
  end

  def title_case input do
    input
  end
end
