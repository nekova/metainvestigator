MetaInvestigator
=============

MetaInvestigator is a library for web scraping, inspired by [MetaInspector](https://github.com/jaimeiniesta/metainspector).

You can get its title, images, charset, description, keywords, meta tags...etc

## Usage
You can use your favorite HTTP Client. HTTPoison, HTTPotion, tesla...etc

```elixir
iex(1)> html = HTTPClient.get!("https://github.com/nekova").body
iex(2)> page = MetaInvestigator.fetch(html)
#%{best_image: "https://avatars1.githubusercontent.com/u/3464295?v=3&s=400",
#  best_title: "nekova (ಠ_ಠ) · GitHub",
#  images: ["https://avatars3.githubusercontent.com/u/3464295?v=3&s=460",
#   "https://assets-cdn.github.com/images/spinners/octocat-spinner-128.gif"],
#  meta: %MetaInvestigator.Meta{charset: "utf-8", keywords: nil,
#   og_image: "https://avatars1.githubusercontent.com/u/3464295?v=3&s=400",
#   og_title: "nekova (ಠ_ಠ)", og_type: "profile",
#   og_url: "https://github.com/nekova"}, title: "nekova (ಠ_ಠ) · GitHub"}
iex(3)> page.og_image
"https://avatars3.githubusercontent.com/u/3464295?v=3&s=460"
iex(4)> page.best_title
"nekova (ಠ_ಠ) · GitHub"
```

You can access each element directly.

```elixir
iex(2)> page = MetaInvestigator.title(html)
"nekova (ಠ_ಠ) · GitHub"
iex(3)> page = MetaInvestigator.best_image(html)
"https://avatars3.githubusercontent.com/u/3464295?v=3&s=460"
```

## Installation
First, add MetaInvestigator to your mix.exs dependencies:

```elixir
def dpes do
  [{:metainvestigator, "~> 0.0.2"}]
end
```

and run ```$ mix deps.get```.

```elixir
def application do
  [applications: [:metainvestigator]]
end
```

## How to confirm the operation with iex
```elixir
$> cd metainvestigator
$> iex -S mix
iex(1)> HTTPoison.start
{:ok, [:idna, :hackney, :httpoison]}
iex(2)> html = HTTPoison.get!("URL").body
iex(3)> page = MetaInvestigator.fetch(html)
```

## LICENSE
```
Copyright © 2015 nekova <nekova07@gmail.com>

This work is free. You can redistribute it and/or modify it under the
terms of the MIT License. See the LICENSE file for more details.
```
