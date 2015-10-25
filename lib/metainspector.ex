defmodule MetaInspector do
  defstruct status: nil, title: nil
  @type t :: %__MODULE__{status: integer, title: String.t}

  def new(url) do
    document = HTTPoison.get!(url)
    body = document.body
    %MetaInspector{status: status(document), title: title(body)}
  end

  def status(document) do
    document.status_code
  end

  def title(body) do
    Floki.find(body, "head title")
    |> Floki.text
  end
end
