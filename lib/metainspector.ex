defmodule MetaInspector do
  defstruct status: nil, title: nil, best_title: nil
  @type t :: %__MODULE__{status: integer, title: String.t, best_title: String.t}

  def new(url) do
    document = HTTPoison.get!(url)
    body = document.body
    %MetaInspector{status: status(document), title: title(body), best_title: best_title(body)}
  end

  def status(document) do
    document.status_code
  end

  def title(body) do
    body
    |> Floki.find("head title")
    |> Floki.text
  end

  def og_title(body) do
    meta_tag_by(body, "title")
  end

  def best_title(body) do
    og_title = og_title(body)
    title    = title(body)
    case og_title > title do
      true  -> og_title
      false -> title
    end
  end

  # attribute = "title", "description", "image", "url", "type"
  @spec meta_tag_by(String.t, String.t) :: [String.t]
  defp meta_tag_by(body, attribute) do
    Floki.find(body, "[property=\"og:#{attribute}\"]")
    |> Floki.attribute("content")
  end

  defmacro exist?(attribute) do
    quote do: unquote(String.length(attribute)) > 0
  end
end
