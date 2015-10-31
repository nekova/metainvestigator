defmodule MetaInspectorTest do
  use ExUnit.Case

  @html """
  <html>
  <head>
  <title>MetaInspector</title>
  <meta content="MetaInspector in Test" property="og:title">
  </head>
  <body></body>
  </html>
  """

  test "title" do
    assert "MetaInspector" == MetaInspector.title(@html)
  end

  test "og_title" do
    assert ["MetaInspector in Test"] == MetaInspector.og_title(@html)
  end

  test "best_title" do
    assert "MetaInspector in Test" == MetaInspector.best_title(@html)
  end

  test "to_utf8 with utf8" do
    assert @html == MetaInspector.to_utf8(@html)
  end

  test "to_utf8 with shift-jis" do
    {:ok, html} = File.read "test/html/shift_jis.html"
    assert_raise UnicodeConversionError, fn ->
       String.to_char_list(html)
    end
  end
end
