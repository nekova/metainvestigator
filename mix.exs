defmodule MetaInvestigator.Mixfile do
  use Mix.Project

  def project do
    [app: :metainvestigator,
     version: "0.0.1",
     elixir: "~> 1.0",
     description: description,
     package: package,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :elixir_mbcs]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:elixir_mbcs, "~> 0.1.1", path: "~/contributes/elixir-mbcs"},
      {:floki, "~> 0.6"}
    ]
  end

  defp description do
    """
    A library for web scraping, inspired by MetaInspector
    """
  end

  defp package do
    [contributors: ["nekova"],
     licenses: ["MIT"],
     links: %{github: "https://github.com/nekova/metainvestigator"}
    ]
  end
end
