MetaInvestigator
=============

MetaInvestigator is a library for web scraping, inspired by [MetaInspector](https://github.com/jaimeiniesta/metainspector).

You can get its title, links, images, charset, description, keywords, meta tags...etc

## Usage

```elixir
page = MetaInvestigator.new("https://essay.nekova.net")
{:ok, %MetaInvestigator{}}
```
## Installation
First, add MetaInvestigator to your mix.exs dependencies:

```elixir
def dpes do
  [{:metainvestigator, "~> 0.0.1"}]
end
```

and run ```$ mix deps.get```.

```elixir
def application do
  [applications: [:metainvestigator]]
end
```
