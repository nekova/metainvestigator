MetaInspector
=============

MetaInspector is a library for web scraping.

You can get its title, links, images, charset, description, keywords, meta tags...etc

## Usage

```elixir
page = MetaInspector.new("https://essay.nekova.net")
{:ok, %MetaInspector{status: 200}}
```
## Installation
First, add MetaInspector to your mix.exs dependencies:

```elixir
def dpes do
  [{:metainspector, "~> 0.0.1"}]
end
```

and run ```$ mix deps.get```.

```elixir
def application do
  [applications: [:metainspector]]
end
```
