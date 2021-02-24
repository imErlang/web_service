defmodule Util do
  require Record
  import Xml

  def get_timestamp() do
    DateTime.utc_now() |> DateTime.to_unix(:second)
  end

  def get_exact_timestamp() do
    DateTime.utc_now() |> DateTime.to_unix(:millisecond)
  end

  def get_default_domain() do
    :ejabberd_config.get_option(:default_domain, "conference.localhost")
  end

  def get_sub_xmlns_name(xml) do
    xmlel(xml, :children) |> get_sub_xmlns_name1
  end

  def get_sub_xmlns_name1([]) do
    false
  end

  def get_sub_xmlns_name1([el | els]) do
    case Record.is_record(el, Xml) do
      true ->
        case :fxml.get_attr("xmlns", xmlel(el, :attrs)) do
          {:value, xmlns} ->
            {xmlel(el, :name), xmlns}

          false ->
            get_sub_xmlns_name1(els)
        end

      false ->
        get_sub_xmlns_name1(els)
    end
  end

  def get_xml_attrs_id(packet) do
    case :fxml.get_attr("id", xmlel(packet, :attrs)) do
      false ->
        Integer.to_string(get_timestamp())

      {_value, i} ->
        i
    end
  end

  def tokens_jid(jid) do
    case :str.tokens jid, "@" do
      [jid] ->
        jid

      [] ->
        jid

      l when is_list(l) ->
        :lists.nth(1, l)

      _ ->
        jid
    end
  end
end
