defmodule MetaInvestigator do
  alias MetaInvestigator.Meta

  defstruct title: nil, images: [], best_title: nil, best_image: nil, meta: %{}
  @type t :: %__MODULE__{ title: String.t, images: list, best_title: String.t,
                          best_image: String.t, meta: MetaInvestigator.Meta.t }

  def fetch(html) do
    html = html |> to_utf8
    %{title: title(html), images: images(html), best_title: best_title(html),
      best_image: best_image(html), meta: Meta.meta(html) }
  end

  @spec title(String.t) :: String.t
  def title(html) do
    html |> Floki.find("head title") |> Floki.text
  end

  @spec images(String.t) :: [String.t]
  def images(html) do
    html |> Floki.find("img") |> Floki.attribute("src") |> Enum.uniq
  end

  @spec best_title(String.t) :: String.t
  def best_title(html) do
    og_title = Meta.og_title(html)
    title    = title(html)
    case og_title >= title do
      true  -> og_title
      false -> title
    end
  end

  @spec best_image(String.t) :: String.t
  def best_image(html) do
    [Meta.og_image(html)] ++ images(html) |> List.first
  end

  def to_utf8(string) do
    case String.valid?(string) do
      true ->
        string
      false ->
        Mbcs.start
        string |> :erlang.binary_to_list |> Mbcs.decode!(:cp932, return: :list) |> to_string
    end
  end
end
