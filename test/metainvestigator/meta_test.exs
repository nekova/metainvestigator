defmodule MetaInvestigator.MetaTest do
  use ExUnit.Case
  import MetaInvestigator.Meta

  @html File.read! "test/html/utf8.html"

  @shift_jis File.read! "test/html/shift_jis.html"

  test "charset" do
    assert charset(@html) == "utf-8"
  end

  test "keywords" do
    assert keywords(@html) == "This is keywords"
  end

  test "og_title" do
    assert og_title(@html) == "MetaInvestigator in Test"
  end

  test "og_image" do
    assert og_image(@html) == "http://img.example.gif"
  end

  test "og_type" do
    assert og_type(@html) == "article"
  end

  test "og_url" do
    assert og_url(@html) == "http://example.com"
  end
end
