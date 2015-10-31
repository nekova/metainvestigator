defmodule MetaInspector.Meta do
  defstruct og_title: nil, og_type: nil, og_url: nil, og_image: nil
  @type t :: %__MODULE__{og_title: char_list, og_type: char_list, og_url: char_list, og_image: char_list}
end

defmodule MetaInspector do
  defstruct status: nil, title: nil, best_title: nil, best_image: nil, meta: nil
  @type t :: %__MODULE__{status: integer, title: String.t, best_title: String.t, best_image: String.t, meta: MetaInspector.Meta.t}

  def new(url) do
    document = HTTPoison.get!(url)
    body = document.body |> to_utf8
    %MetaInspector{status: status(document), title: title(body), best_title: best_title(body), best_image: best_image(body), meta: meta(body)}
  end

  def status(document) do
    document.status_code
  end

  @spec title(String.t) :: String.t
  def title(body) do
    body
    |> Floki.find("head title")
    |> Floki.text
  end

  @spec best_title(String.t) :: String.t
  def best_title(body) do
    og_title = og_title(body) |> to_string
    title    = title(body)
    case og_title >= title do
      true  -> og_title
      false -> title
    end
  end

  @spec best_image(String.t) :: String.t
  def best_image(body) do
    og_image(body)
    |> List.first
  end

  metadata = [{:og_title, "title"}, {:og_type, "type"}, {:og_image, "image"}, {:og_url, "url"}]
  for {func, meta} <- metadata do
    def unquote(func)(body), do: meta_tag_by(body, unquote(meta))
  end

  @spec meta_tag_by(String.t, String.t) :: [String.t]
  defp meta_tag_by(body, attribute) when attribute in ["title", "image", "type", "url"] do
    Floki.find(body, "[property=\"og:#{attribute}\"]")
    |> Floki.attribute("content")
  end

  def to_utf8(body) do
    try do
      String.to_char_list(body)
      body
    rescue
      UnicodeConversionError -> decode_to_utf8(body)
    end
  end

  def decode_to_utf8(body) do
    Mbcs.start
    str = :erlang.binary_to_list(body)
    "#{Mbcs.decode!(str, :cp932, return: :list)}"
  end

  defp meta(body) do
    %MetaInspector.Meta{og_title: og_title(body), og_type: og_type(body), og_url: og_url(body), og_image: og_image(body)}
  end
end
