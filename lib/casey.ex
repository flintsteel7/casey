defmodule Casey do
  @moduledoc """
  Documentation for Casey.

  In this documentation, I will be using the word *character* to mean [*grapheme*](https://hexdocs.pm/elixir/String.html#t:grapheme/0) as defined in Elixir's [String](https://hexdocs.pm/elixir/String.html) module
  """

  @defaults Casey.MixProject.defaults()

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
  `cap_words` will attempt to capitalize every character directly following whitespace
  Only characters that can be capitalized by Elixir's String.upcase() function in its default configuration will end up being capitalized

  By default, whitespace is defined as RegEx `\s` and applied to Unicode includes:
  - space ` `
  - non-breaking space `\u00a0`
  - narrow non-breaking space `\u202f`
  - en space `\u2002`
  - em space `\u2003`
  - three-per-em space `\u2004`
  - four-per-em space `\u2005`
  - six-per-em space `\u2006`
  - figure space `\u2007`
  - punctuation space `\u2008`
  - thin space `\u2009`
  - hair space `\u200a`
  - medium mathematical space `\u205f`
  - carriage return `\r`
  - line feed `\n`
  - carriage return line feed `\r\n`
  - form feed `\f`
  - character tab `\t`
  - line tab `\v`

  Optionally, a list of characters to consider whitespace may be passed in, overriding the defaults

  For example, if you wish to only capitalize characters following a regular space and ignore all others, pass in `[" "]` as `whitespace`

  Theoretically, this function could be used to capitalize every character following an arbitrary character or set of characters, not just following whitespace.

  If you wanted to capitalize every character following a "p", "f", or "z" for instance, you could pass in `["p", "f", "z"]` as `whitespace`
  """

  def cap_words(input, opts \\ []) do
    aft = Keyword.get(opts, :whitespace, @defaults.whitespace)
    cap_first = Keyword.get(opts, :cap_first, @defaults.cap_first)
    cap_after(input, after: aft, cap_first: cap_first)
  end

  @doc """
  Capitalize Sentences

  ## Behavior:
  """

  def cap_sentences(input, opts \\ []) do
    aft = Keyword.get(opts, :sentence_end, @defaults.sentence_end)
    cap_first = Keyword.get(opts, :cap_first, @defaults.cap_first)
    cap_after(input, after: aft, cap_first: cap_first)
  end

  def cap_lines(input) do
    input
  end

  def title_case(input) do
    input
  end

  defp cap_after(input, opts \\ []) do
    aft = Keyword.get(opts, :after)
    cap_first = Keyword.get(opts, :cap_first, @defaults.cap_first)

    case list_to_opposite_regexes(aft) do
      {:ok, positive_regex, negative_regex} ->
        {capitalized_list, _} =
          input
          |> maybe_cap_first_non_whitespace(cap_first)
          |> String.graphemes()
          |> Enum.map_reduce([], fn grapheme, acc ->
            previous_grapheme =
              case Enum.at(acc, -1) do
                nil -> ""
                lg -> lg
              end

            new_grapheme =
              with true <- Regex.match?(negative_regex, grapheme),
                   true <- Regex.match?(positive_regex, previous_grapheme) do
                String.upcase(grapheme)
              else
                _ ->
                  grapheme
              end

            {new_grapheme, acc ++ [new_grapheme]}
          end)

        {:ok, Enum.join(capitalized_list)}

      error ->
        error
    end
  end

  defp maybe_cap_first_non_whitespace(input, false), do: input

  defp maybe_cap_first_non_whitespace(input, true) do
    [_, head, body] = Regex.run(~r/^(\s*)(\S(?:.|\s)*)/u, input)
    cap_first = String.first(body) |> String.upcase()
    head <> cap_first <> String.slice(body, 1, String.length(body))
  end

  defp list_to_opposite_regexes(character_list) do
    with {:ok, positive_regex} <- list_to_positive_regex(character_list),
         {:ok, negative_regex} <- list_to_negative_regex(character_list) do
      {:ok, positive_regex, negative_regex}
    else
      error -> error
    end
  end

  defp list_to_positive_regex(character_list) do
    case Enum.join(character_list, "|") |> Regex.compile("u") do
      {:ok, regex} -> {:ok, regex}
      error -> error
    end
  end

  defp list_to_negative_regex(character_list) do
    case Enum.join(character_list, "") |> create_negative_regex_group() do
      {:ok, regex} -> {:ok, regex}
      error -> error
    end
  end

  defp create_negative_regex_group(character_string) do
    case ("[^" <> character_string <> "]") |> Regex.compile("u") do
      {:ok, regex} -> {:ok, regex}
      error -> error
    end
  end
end
