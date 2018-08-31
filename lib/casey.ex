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

  def all_caps(input) do
    String.upcase(input, :greek)
  end

  def all_lower(input) do
    String.downcase(input, :greek)
  end

  @doc """
  Capitalize Words

  ## Behavior:
  `cap_words` will attempt to capitalize every character directly following whitespace (whitespace is defined by regex `\s`)
  """

  def cap_words(input) do
    {capitalized_list, _} =
      input
      |> cap_first_non_whitespace()
      |> String.graphemes()
      |> Enum.map_reduce([], fn grapheme, acc ->
        last_grapheme =
          case Enum.at(acc, -1) do
            nil -> ""
            lg -> lg
          end

        new_grapheme =
          with true <- Regex.match?(~r/\S/u, grapheme),
               true <- Regex.match?(~r/\s/u, last_grapheme) do
            String.upcase(grapheme)
          else
            _ ->
              grapheme
          end

        {new_grapheme, acc ++ [new_grapheme]}
      end)

    Enum.join(capitalized_list)
  end

  @doc """
  Capitalize Sentences

  ## Behavior:
  `cap_sentences` will attempt to capitalize every character directly following whitespace (whitespace is defined by regex `\s`)
  """

  def cap_sentences(input) do
  end

  def cap_lines(input) do
    input
  end

  def title_case(input) do
    input
  end

  defp cap_first_non_whitespace(input) do
    [_, head, body] = Regex.run(~r/^(\s*)(\S(?:.|\s)*)/u, input)
    cap_first = String.first(body) |> String.upcase()
    head <> cap_first <> String.slice(body, 1, String.length(body))
  end
end
