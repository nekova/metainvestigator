defmodule MetaInvestigator do
  alias MetaInvestigator.Meta

  @moduledoc """
  This is a simple library for web scraping.

  You can get its title, images, charset, description, keywords, meta tags...etc

  ## Example
  You can get a struct that included all elements
    * MetaInvestigator.fetch(html) : returns a struct

  You can access the following elements directly
    * MetaInvestigator.title(html) : returns a title
    * MetaInvestigator.images(html) : returns all images
    * MetaInvestigator.best_title(html) : returns a best title of the html
    * MetaInvestigator.best_image(html) : returns a best image of the html
  """

  @type t :: %__MODULE__{
              title: String.t,
              images: list,
              best_title: String.t,
              best_image: String.t,
              meta: MetaInvestigator.Meta.t
            }
  defstruct title: nil,
            images: [],      # All images of the website.
            best_title: nil, # The best title of the website, usually <title> or <og:title>.
            best_image: nil, # The best image of the website, usually <img> or <og:image>.
            meta: %{}        # A map containing key value pairs of metatags

  @type html :: String.t

  @doc """
  Fetch elements inside a HTML
  """
  def fetch(html) when is_binary(html) do
    unless String.valid?(html), do: html = to_utf8(html)
    %{title: title(html), images: images(html), best_title: best_title(html),
      best_image: best_image(html), meta: Meta.meta(html) }
  end

  @spec title(html) :: String.t
  def title(html) do
    html |> Floki.find("head title") |> Floki.text
  end

  @spec images(html) :: list
  def images(html) do
    html |> Floki.find("img") |> Floki.attribute("src") |> Enum.uniq
  end

  @spec best_title(html) :: String.t
  def best_title(html) do
    compare(Meta.og_title(html), title(html))
  end

  @spec best_image(html) :: String.t
  def best_image(html) do
    [Meta.og_image(html)] ++ images(html) |> List.first
  end

  def to_utf8(string, encoding \\ :shift_jis) do
    Mbcs.start
    string |> :erlang.binary_to_list |> decode(encoding) |> to_string
  end

  def decode(string, :shift_jis), do: Mbcs.decode!(string, :cp932, return: :list)

  defp compare(nil, nil), do: nil
  defp compare(one, nil), do: one
  defp compare(nil, two), do: two
  defp compare(one, two) do
    case String.length(one) >= String.length(two) do
      true -> one
      false -> two
    end
  end
end
