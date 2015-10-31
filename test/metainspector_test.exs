defmodule MetaInspectorTest do
  use ExUnit.Case

  @html File.read! "test/html/utf8.html"

  @shift_jis File.read! "test/html/shift_jis.html"

  test "title" do
    assert "MetaInspector" == MetaInspector.title(@html)
  end

  test "og_title" do
    assert ["MetaInspector in Test"] == MetaInspector.og_title(@html)
  end

  test "og_image" do
    assert ["http://img.example.com"] == MetaInspector.og_image(@html)
  end

  test "og_type" do
    assert ["article"] == MetaInspector.og_type(@html)
  end

  test "og_url" do
    assert ["http://example.com"] == MetaInspector.og_url(@html)
  end

  test "best_title" do
    assert "MetaInspector in Test" == MetaInspector.best_title(@html)
  end

  test "to_utf8 with utf8" do
    assert @html == MetaInspector.to_utf8(@html)
  end

  test "to_utf8 with shift-jis" do
    assert_raise UnicodeConversionError, fn ->
       String.to_char_list(@shift_jis)
    end
  end
end
