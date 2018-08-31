defmodule Casey.MixProject do
  use Mix.Project

  def project do
    [
      app: :casey,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end

  def defaults do
    %{
      lower: %{
        articles: ["a", "an", "the"],
        conjunctions: ["and", "but", "or", "yet", "for", "nor", "so"],
        prepositions: [
          "as",
          "at",
          "by",
          "in",
          "of",
          "on",
          "to",
          "up",
          "out",
          "but",
          "into",
          "onto",
          "upon",
          "with"
        ],
        ref_abbrs: ["v", "vv", "cf"]
      },
      upper: %{
        eras: ["AD", "BC", "BCE", "CE"],
        bible_translations:
          ~r/^(?:E(?:[RS]V|TH)|M(?:KJV|EV|SG|GI|IT|RD)|G(?:N[TBV]|WN?)|PNT|C(?:KJV|BP|NT|[SJ]B|E[VB])|UKJV|W(?:ebster|EB)|H(?:SE|RV|CSB)|KJ(?: II|[3AG]|21|V(?:20(?:00)?|ER|-CE)?)|L(?:ITV|X[AEX]|E[BW])|O[JE]B|A(?:KJV|V[7U]|ENT|SV)|D(?:NKJB|BY|RA)|JPS|N(?:KJV?|C(?:V|PB)|JB|E[BT]|I(?:B|rV|VI?)|A(?:[BU]|SB?)|OR|LT|RSV?)|[QB]BE|R(?:V|NT|[EW]B|SV)|T(?:MB|EV|S|L[BV]|N(?:IV|[KT]))),?$/,
        roman_numerals: ~r/^M{0,4}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3}),?$/
      }
    }
  end
end
