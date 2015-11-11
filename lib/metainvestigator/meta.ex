defmodule MetaInvestigator.Meta do
  defstruct charset: nil, keywords: nil, og_title: [], og_type: [], og_url: [], og_image: []
  @type t :: %__MODULE__{charset: String.t, keywords: String.t, og_title: list, og_type: list, og_url: list, og_image: list}
end
