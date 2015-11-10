defmodule MetaInspector do
  defstruct title: nil, best_title: nil, best_image: nil, meta: %{}
  @type t :: %__MODULE__{title: String.t, best_title: String.t, best_image: String.t, meta: MetaInspector.Meta.t}

  @metadata ["title", "type", "image", "url"]

  def fetch(html) do
    html = html |> to_utf8
    %{title: title(html), best_title: best_title(html), best_image: best_image(html), meta: meta(html)}
  end

  @spec title(String.t) :: String.t
  def title(html) do
    html
    |> Floki.find("head title")
    |> Floki.text
  end

  @spec best_title(String.t) :: String.t
  def best_title(html) do
    og_title = og_title(html) |> to_string
    title    = title(html)
    case og_title >= title do
      true  -> og_title
      false -> title
    end
  end

  @spec best_image(String.t) :: String.t
  def best_image(html) do
    og_image(html)
    |> List.first
  end

  for meta <- @metadata do
    def unquote(:"og_#{meta}")(html), do: meta_tag_by(html, unquote(meta))
  end

  @spec meta_tag_by(String.t, String.t) :: [String.t]
  defp meta_tag_by(html, attribute) when attribute in @metadata do
    Floki.find(html, "[property=\"og:#{attribute}\"]")
    |> Floki.attribute("content")
  end

  defp meta(html) do
    %__MODULE__.Meta{og_title: og_title(html), og_type: og_type(html), og_url: og_url(html), og_image: og_image(html)}
  end

  def to_utf8(string) do
    case String.valid?(string) do
      true -> string
      false ->
        Mbcs.start
        str = :erlang.binary_to_list(string)
        "#{Mbcs.decode!(str, :cp932, return: :list)}"
    end
  end
end
