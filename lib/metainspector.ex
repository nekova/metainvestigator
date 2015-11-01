defmodule MetaInspector.Meta do
  defstruct og_title: [], og_type: [], og_url: [], og_image: []
  @type t :: %__MODULE__{og_title: list, og_type: list, og_url: list, og_image: list}
end

defmodule MetaInspector do
  defstruct status: nil, title: nil, best_title: nil, best_image: nil, meta: %{}
  @type t :: %__MODULE__{status: integer, title: String.t, best_title: String.t, best_image: String.t, meta: MetaInspector.Meta.t}

  @spec new(String.t) :: __MODULE__.t
  def new(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        fetch(body)
      {:ok, %HTTPoison.Response{status_code: status}} ->
        %__MODULE__{status: status}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  def fetch(body) do
    body = body |> to_utf8
    %__MODULE__{status: 200, title: title(body), best_title: best_title(body), best_image: best_image(body), meta: meta(body)}
  end

  def status(response) do
    response.status_code
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

  metadata = ["title", "type", "image", "url"]
  for meta <- metadata do
    def unquote(:"og_#{meta}")(body), do: meta_tag_by(body, unquote(meta))
  end

  @spec meta_tag_by(String.t, String.t) :: [String.t]
  defp meta_tag_by(body, attribute) when attribute in ["title", "image", "type", "url"] do
    Floki.find(body, "[property=\"og:#{attribute}\"]")
    |> Floki.attribute("content")
  end

  defp meta(body) do
    %__MODULE__.Meta{og_title: og_title(body), og_type: og_type(body), og_url: og_url(body), og_image: og_image(body)}
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
