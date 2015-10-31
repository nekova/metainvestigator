defmodule MetaInspector do
  defstruct status: nil, title: nil, best_title: nil
  @type t :: %__MODULE__{status: integer, title: String.t, best_title: String.t}

  def new(url) do
    document = HTTPoison.get!(url)
    body = document.body |> to_utf8
    %MetaInspector{status: status(document), title: title(body), best_title: best_title(body)}
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

  def og_title(body) do
    meta_tag_by(body, "title")
  end

  # attribute = "title", "description", "image", "url", "type"
  @spec meta_tag_by(String.t, String.t) :: [String.t]
  defp meta_tag_by(body, attribute) when attribute in ["title"] do
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
end
