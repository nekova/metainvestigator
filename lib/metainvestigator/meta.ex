defmodule MetaInvestigator.Meta do
  defstruct charset: nil, keywords: nil, og_title: nil, og_type: nil, og_url: nil, og_image: nil
  @type t :: %__MODULE__{charset: String.t, keywords: String.t, og_title: String.t, og_type: String.t, og_url: String.t, og_image: String.t}
end
