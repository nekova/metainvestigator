defmodule MetaInvestigator do
  alias MetaInvestigator.Meta

  defstruct title: nil, images: [], best_title: nil, best_image: nil, meta: %{}
  @type t :: %__MODULE__{ title: String.t, images: list, best_title: String.t,
                          best_image: String.t, meta: MetaInvestigator.Meta.t }

  @type html :: String.t

  @doc """
  Fetch elements inside a HTML
  """
  def fetch(html) do
    html = html |> to_utf8
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

  def to_utf8(string) do
    case String.valid?(string) do
      true ->
        string
      false ->
        Mbcs.start
        string |> :erlang.binary_to_list |> Mbcs.decode!(:cp932, return: :list) |> to_string
    end
  end

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
