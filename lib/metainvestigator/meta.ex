defmodule MetaInvestigator.Meta do
  @type t :: %__MODULE__{
              charset: String.t,
              keywords: String.t,
              og_title: String.t,
              og_type: String.t,
              og_url: String.t,
              og_image: String.t
            }
  defstruct charset: nil,  # The encoding of the website.
            keywords: nil,
            og_title: nil,
            og_type: nil,  # The type of the website, usually "article" or "website".
            og_url: nil,
            og_image: nil


  @metadata ["title", "type", "image", "url"]

  @spec charset(String.t) :: String.t
  def charset(html) do
    html |> Floki.find("meta") |> Floki.attribute("charset") |> List.first
  end

  @spec keywords(String.t) :: String.t
  def keywords(html) do
    html |> Floki.find("[name=\"keywords\"]") |> Floki.attribute("content") |> List.first
  end

  for meta <- @metadata do
    def unquote(:"og_#{meta}")(html), do: meta_tag_by(html, unquote(meta))
  end

  @spec meta_tag_by(String.t, String.t) :: String.t
  defp meta_tag_by(html, attribute) when attribute in @metadata do
    Floki.find(html, "[property=\"og:#{attribute}\"]")
    |> Floki.attribute("content") |> List.first
  end

  def meta(html) do
    %__MODULE__{
      charset: charset(html),
      keywords: keywords(html),
      og_title: og_title(html),
      og_type: og_type(html),
      og_url: og_url(html),
      og_image: og_image(html)
    }
  end
end
