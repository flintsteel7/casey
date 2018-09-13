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
    assert Casey.cap_words("i'd like all these words to be capitalized, please.") ==
             {:ok, "I'd Like All These Words To Be Capitalized, Please."}
  end

  test "capitalize every word, preserving leading and trailing whitespace" do
    assert Casey.cap_words(" i'd like all these words to be capitalized, please.\n") ==
             {:ok, " I'd Like All These Words To Be Capitalized, Please.\n"}
  end

  test "capitalize every word across new lines" do
    assert Casey.cap_words("\n i'd like all these words\nto be capitalized, please. ") ==
             {:ok, "\n I'd Like All These Words\nTo Be Capitalized, Please. "}
  end

  test "capitalize every word, what is whitespace?" do
    assert Casey.cap_words("""
           \bbackspace
           \u200bzero-width space
            space
           \u00a0non-breaking space
           \u202fnarrow non-breaking space
           \u2002en space
           \u2003em space
           \u2004three-per-em space
           \u2005four-per-em space
           \u2006six-per-em space
           \u2007figure space
           \u2008punctuation space
           \u2009thin space
           \u200ahair space
           \u205fmedium mathematical space
           \rcarriage return
           \nline feed
           \r\ncrlf
           \tcharacter tab
           \vline tab
           \fform feed
           """) ==
             {:ok,
              """
              \bbackspace
              \u200bzero-width Space
               Space
              \u00a0Non-breaking Space
              \u202fNarrow Non-breaking Space
              \u2002En Space
              \u2003Em Space
              \u2004Three-per-em Space
              \u2005Four-per-em Space
              \u2006Six-per-em Space
              \u2007Figure Space
              \u2008Punctuation Space
              \u2009Thin Space
              \u200aHair Space
              \u205fMedium Mathematical Space
              \rCarriage Return
              \nLine Feed
              \r\nCrlf
              \tCharacter Tab
              \vLine Tab
              \fForm Feed
              """}
  end

  test "capitalize every word, only following spaces" do
    assert Casey.cap_words("i'd like\u00a0all these words\u00a0to be\tcapitalized, please.",
             whitespace: [" "]
           ) == {:ok, "I'd Like\u00a0all These Words\u00a0to Be\tcapitalized, Please."}
  end

  test "capitalize each sentence" do
    assert Casey.cap_sentences("\nhere is Red. red is a dog.\n  see Red run? go Red, go!\n   and don't come back!") ==
             {:ok, "\nHere is Red. Red is a dog.\n  See Red run? Go Red, go!\n   And don't come back!"}
  end

  test "capitalize each line" do
    assert Casey.cap_lines("""
            let each of these lines
           come back capitalized
            or something isn't working
           correctly
           """) ==
             {:ok,
              """
               Let each of these lines
              Come back capitalized
               Or something isn't working
              Correctly
              """}
  end

  test "properly capitalize title" do
    assert Casey.title_case("the hound of the Baskervilles") === "The Hound of the Baskervilles"
  end
end
