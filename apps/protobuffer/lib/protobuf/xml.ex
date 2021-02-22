defmodule Xml do
  require Record

  Record.defrecord(:xmlel, Record.extract(:xmlel, from_lib: "fast_xml/include/fxml.hrl"))
end
