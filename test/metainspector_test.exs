defmodule MetaInspectorTest do
  use ExUnit.Case

  @html File.read! "test/html/utf8.html"

  @shift_jis File.read! "test/html/shift_jis.html"

  test "title" do
    assert MetaInspector.title(@html) == "MetaInspector"
  end

  test "og_title" do
    assert MetaInspector.og_title(@html) == ["MetaInspector in Test"]
  end

  test "og_image" do
    assert MetaInspector.og_image(@html) == ["http://img.example.com"]
  end

  test "og_type" do
    assert MetaInspector.og_type(@html) == ["article"]
  end

  test "og_url" do
    assert MetaInspector.og_url(@html) == ["http://example.com"]
  end

  test "best_title" do
    assert MetaInspector.best_title(@html) == "MetaInspector in Test"
  end

  test "to_utf8 with utf8" do
    assert MetaInspector.to_utf8(@html) == @html 
  end

  test "to_utf8 with shift-jis" do
    assert_raise UnicodeConversionError, fn ->
       String.to_char_list(@shift_jis)
    end
  end
end
