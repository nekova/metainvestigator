defmodule MetaInvestigator.Mixfile do
  use Mix.Project

  def project do
    [app: :metainvestigator,
     version: "0.0.2",
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
      {:elixir_mbcs, git: "https://github.com/woxtu/elixir-mbcs.git"},
      {:floki, "~> 0.6"},
      {:httpoison, "~> 0.7.2", only: :dev}
    ]
  end

  defp description do
    """
    A library for web scraping, inspired by MetaInspector
    """
  end

  defp package do
    [maintainers: ["nekova"],
     licenses: ["MIT"],
     links: %{github: "https://github.com/nekova/metainvestigator"}
    ]
  end
end
