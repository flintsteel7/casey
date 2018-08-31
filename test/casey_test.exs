defmodule CaseyTest do
  use ExUnit.Case
  doctest Casey

  test "greets the world" do
    assert Casey.hello() == :world
  end

  test "capitalizes every letter" do
    assert Casey.all_caps("Upper case all the things!") == "UPPER CASE ALL THE THINGS!"
  end

  test "capitalizes Greek final sigma correctly" do
    assert Casey.all_caps("σς and σς") == "ΣΣ AND ΣΣ"
  end

  test "lower-cases every letter" do
    assert Casey.all_lower("Bring it all Down, Boys!") == "bring it all down, boys!"
  end

  test "lower-cases Greek final sigma correctly" do
    assert Casey.all_lower("ΣΣ And ΣΣ") == "σς and σς"
  end

  test "capitalize every word" do
    assert Casey.cap_words("I'd like all these words to be capitalized, please.") == "I'd Like All These Words To Be Capitalized, Please."
  end

  test "capitalize every word, preserving leading and trailing whitespace" do
    assert Casey.cap_words(" I'd like all these words to be capitalized, please.\\n") == " I'd Like All These Words To Be Capitalized, Please.\\n"
  end

  test "capitalize every word across new lines" do
    assert Casey.cap_words(" I'd like all these words\\nto be capitalized, please. ") == " I'd Like All These Words\\nTo Be Capitalized, Please. "
  end

  test "capitalize each sentence" do
    assert Casey.cap_sentences("here is Red. Red is a dog. see Red run. go Red, go!") == "Here is Red. Red is a dog. See Red run. Go Red, go!"
  end

  test "capitalize each line" do
    assert Casey.cap_lines("""
let each of these lines
come back capitalized
or something isn't working
correctly
""") == """
Let each of these lines
Come back capitalized
Or something isn't working
Correctly
"""
  end

  test "properly capitalize title" do
    assert Casey.title_case("the hound of the Baskervilles") === "The Hound of the Baskervilles"
  end
end
