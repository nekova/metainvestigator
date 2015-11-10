defmodule MetaInspector.Meta do
  defstruct og_title: [], og_type: [], og_url: [], og_image: []
  @type t :: %__MODULE__{og_title: list, og_type: list, og_url: list, og_image: list}
end
