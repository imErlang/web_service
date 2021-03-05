defmodule Xml do
  require Record

  Record.defrecord(:xmlel, Record.extract(:xmlel, from_lib: "fast_xml/include/fxml.hrl"))
end

defmodule Jid do
  require Record

  Record.defrecord(:jid, Record.extract(:jid, from_lib: "xmpp/include/jid.hrl"))
end
