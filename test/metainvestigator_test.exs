defmodule MetaInvestigatorTest do
  use ExUnit.Case
  import MetaInvestigator

  @html File.read! "test/html/utf8.html"

  @shift_jis File.read! "test/html/shift_jis.html"

  test "title" do
    assert title(@html) == "MetaInvestigator"
  end

  test "images" do
    assert length(images(@html)) == 2
  end

  test "charset" do
    assert charset(@html) == "utf-8"
  end

  test "keywords" do
    assert keywords(@html) == "This is keywords"
  end

  test "og_title" do
    assert og_title(@html) == ["MetaInvestigator in Test"]
  end

  test "og_image" do
    assert og_image(@html) == ["http://img.example.gif"]
  end

  test "og_type" do
    assert og_type(@html) == ["article"]
  end

  test "og_url" do
    assert og_url(@html) == ["http://example.com"]
  end

  test "best_title" do
    assert best_title(@html) == "MetaInvestigator in Test"
  end

  test "best_image" do
    assert best_image(@html) == "http://img.example.gif"
  end

  test "to_utf8 with utf8" do
    assert to_utf8(@html) == @html
  end

  test "@html is utf8" do
    assert String.valid?(@html)
  end

  test "@shift_jis is not utf8" do
    refute String.valid?(@shift_jis)
  end

  test "@shift_jis decode to utf8" do
    refute to_utf8(@shift_jis) == @shift_jis
  end
end
