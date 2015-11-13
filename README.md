MetaInvestigator
=============

MetaInvestigator is a library for web scraping, inspired by [MetaInspector](https://github.com/jaimeiniesta/metainspector).

You can get its title, images, charset, description, keywords, meta tags...etc

## Usage
You can use your favorite HTTP Client. HTTPoison, HTTPotion, tesla...etc

```elixir
html = HTTPClient.get!("https://github.com/nekova").body
page = MetaInvestigator.fetch(html)
# => %{best_image: "https://avatars1.githubusercontent.com/u/3464295?v=3&s=400",
#  best_title: "nekova (ಠ_ಠ) · GitHub",
#  images: ["https://avatars3.githubusercontent.com/u/3464295?v=3&s=460",
#   "https://assets-cdn.github.com/images/spinners/octocat-spinner-128.gif"],
#  meta: %MetaInvestigator.Meta{charset: "utf-8", keywords: nil,
#   og_image: "https://avatars1.githubusercontent.com/u/3464295?v=3&s=400",
#   og_title: "nekova (ಠ_ಠ)", og_type: "profile",
#   og_url: "https://github.com/nekova"}, title: "nekova (ಠ_ಠ) · GitHub"}
page.og_image
#=> "https://avatars3.githubusercontent.com/u/3464295?v=3&s=460"
page.best_title
#=> "nekova (ಠ_ಠ) · GitHub"
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
