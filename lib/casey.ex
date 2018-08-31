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
    input
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
