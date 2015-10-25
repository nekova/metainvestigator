defmodule MetaInspector do
  defstruct status: nil
  @type t :: %__MODULE__{status: String.t}

  def new(url) do
    document = HTTPoison.get!(url)
    %MetaInspector{status: status(document)}
  end

  def status(document) do
    document.status_code
  end
end
