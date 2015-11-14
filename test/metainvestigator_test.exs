defmodule MetaInvestigatorTest do
  use ExUnit.Case
  import MetaInvestigator

  @html File.read! "test/html/utf8.html"

  @shift_jis File.read! "test/html/shift_jis.html"

  @valid_response %{
    best_image: "http://img.example.gif", best_title: "MetaInvestigator in Test",
    images: ["http://i.example.jpg", "http://duplicate.example.png"],
    meta: %MetaInvestigator.Meta{charset: "utf-8", keywords: "This is keywords",
    og_image: "http://img.example.gif", og_title: "MetaInvestigator in Test",
    og_type: "article", og_url: "http://example.com"}, title: "MetaInvestigator"
  }

  test "fetch" do
    assert fetch(@html) == @valid_response
  end

  test "title" do
    assert title(@html) == "MetaInvestigator"
  end

  test "images" do
    assert length(images(@html)) == 2
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
