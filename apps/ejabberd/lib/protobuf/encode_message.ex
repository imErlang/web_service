defmodule MessageProtobuf.Encode.Message do
  import Xml
  require Logger

    def set_client_type(type) when type == "ClientTypeMac" or type == "1" do
      :ClientTypeMac
    end
    def set_client_type(type) when type == "ClientTypeiOS" or T == "2" do
      :ClientTypeiOS
    end
    def set_client_type(type) when type == "ClientTypePC" or T == "3" do
      :ClientTypePC
    end
    def set_client_type(type) when type == "ClientTypeAndroid" or T == "4" do
      :ClientTypeAndroid
    end
    def set_client_type(type) when type== "ClientTypeLinux" or T == "5" do
      :ClientTypeLinux
    end
    def set_client_type(type) when type == "ClientTypeWeb" or T == "6" do
      :ClientTypeWeb
    end
    def set_client_type(_type) do
      :ClientTypePC
    end

    def encode_pb_stringheaders(headers) do
      headers |> Enum.flat_map(fn header ->
        encode_pb_stringheader(header)
      end)
    end

      def set_header_definedkey("chatid") do  :StringHeaderTypeChatId end
      def set_header_definedkey("channelid") do  :StringHeaderTypeChannelId end
      def set_header_definedkey("extendInfo") do  :StringHeaderTypeExtendInfo end
      def set_header_definedkey("backupinfo") do  :StringHeaderTypeBackupInfo end
      def set_header_definedkey("read_type") do  :StringHeaderTypeReadType end
      def set_header_definedkey("jid") do  :StringHeaderTypeJid end
      def set_header_definedkey("real_jid") do  :StringHeaderTypeRealJid end
      def set_header_definedkey("invite_jid") do  :StringHeaderTypeInviteJid end
      def set_header_definedkey("del_jid") do  :StringHeaderTypeDeleleJid end
      def set_header_definedkey("nick") do  :StringHeaderTypeNick end
      def set_header_definedkey("title") do  :StringHeaderTypeTitle end
      def set_header_definedkey("pic") do  :StringHeaderTypePic end
      def set_header_definedkey("version") do  :StringHeaderTypeVersion end
      def set_header_definedkey("method") do  :StringHeaderTypeMethod end
         def set_header_definedkey("body") do  :StringHeaderTypeBody end
         def set_header_definedkey("affiliation") do  :StringHeaderTypeAffiliation end
         def set_header_definedkey("type") do  :StringHeaderTypeType end
         def set_header_definedkey("result") do  :StringHeaderTypeResult end
         def set_header_definedkey("reason") do  :StringHeaderTypeReason end
         def set_header_definedkey("role") do  :StringHeaderTypeRole end
         def set_header_definedkey("domain") do  :StringHeaderTypeDomain end
         def set_header_definedkey("status") do  :StringHeaderTypeStatus end
         def set_header_definedkey("code") do  :StringHeaderTypeCode end
         def set_header_definedkey("cdata") do  :StringHeaderTypeCdata end
         def set_header_definedkey("time_value") do  :StringHeaderTypeTimeValue end
         def set_header_definedkey("key_value") do  :StringHeaderTypeKeyValue end
         def set_header_definedkey("name") do  :StringHeaderTypeName end
         def set_header_definedkey("host") do  :StringHeaderTypeHost end
         def set_header_definedkey("question") do  :StringHeaderTypeQuestion end
         def set_header_definedkey("answer") do  :StringHeaderTypeAnswer end
         def set_header_definedkey("friends") do  :StringHeaderTypeFriends end
         def set_header_definedkey("value") do  :StringHeaderTypeValue end
         def set_header_definedkey("masked_user") do  :StringHeaderTypeMaskedUuser end
         def set_header_definedkey("key") do  :StringHeaderTypeKey end
         def set_header_definedkey("mode") do  :StringHeaderTypeMode end
         def set_header_definedkey("carbon_message") do  :StringHeaderTypeCarbon end
         def set_header_definedkey(_) do
          :none
        end

    def encode_pb_stringheader([]) do
        []
    end
    def encode_pb_stringheader({_,""}) do
        []
    end
    def encode_pb_stringheader({"",_}) do
        []
    end
    def encode_pb_stringheader({_,:undefined}) do
        []
    end
    def encode_pb_stringheader({k,v}) do
        case set_header_definedkey(k) do
            :none -> [ Stringheader.new(key: k, value: v)]
            dv -> [ Stringheader.new(key: dv, value: v)]
        end
      end

  def do_struct_pb_xmpp_msg("nbodyStat",pattrs,_battrs,_message,_id,time, _packet, _type) do
    client_ver = :proplists.get_value("client_ver",pattrs,"0") |> String.to_integer()
    headers = encode_pb_stringheaders([])
    msg_body = Messagebody.new(headers: headers, value: "")
    Xmppmessage.new(messagetype: 1, clienttype: :ClientTypePc, clientversion: client_ver, messageid: "", body: msg_body, receivedtime: time) |> Xmppmessage.encode()
  end

def do_struct_pb_xmpp_msg(_,pattrs,battrs,message,id,time, packet, type)  do
    qchat_id = handle_msg_id(pattrs)
    client_type = :proplists.get_value("client_type",pattrs) |> set_client_type()
    client_ver = :proplists.get_value("client_ver",pattrs,"0") |> String.to_integer()
    carbon_flag = :proplists.get_value("carbon_message",pattrs,"")
    read_type = :proplists.get_value("read_type",pattrs,"")
    auto_reply = :proplists.get_value("auto_reply",pattrs,"")

    msg_type = :proplists.get_value("msgType",battrs,"1") |> String.to_integer()
    ma_type = :proplists.get_value("maType",battrs,"3")
    channel_id = :proplists.get_value("channelid",battrs,"")
    ex_info = :proplists.get_value("extendInfo",battrs,"")
    backup_info = :proplists.get_value("backupinfo",battrs,"")
    errcode = case type == "error" do
        true ->
            case :fxml.get_subtag(packet,"error") do
                false -> "0"
                error ->
                case :proplists.get_value("code", xmlel(error, :attrs)) do
                    :undefined -> "0"
                    code -> code
                end
            end
        false -> "0"
    end
    headers = encode_pb_stringheaders([{"qchatid ",qchat_id},
    { "channelid",channel_id},
    { "extendInfo ",ex_info},
    { "backupinfo ",backup_info},
    { "read_type ",read_type},
{ "auto_reply ",auto_reply},
{ "errcode ",errcode},
    { "carbon_message ",carbon}])

    msg_body = Messagebody.new(headers: headers, value: message)
    Xmppmessage.new(messagetype: msg_type, clienttype: client_type, clientversion: client_ver, messageid: id, body: msg_body, receivedtime: time) |> Xmppmessage.encode()
  end

  def encode_pb_protomessage(from,to,type,opts,msg, realfrom \\ "", realto \\ "", originfrom \\ "", originto \\ "", origintype \\ "", sendjid \\ "") do
    Protomessage.new(options: opts, signaltype: type, from: from, to: from, message: msg, realfrom: realfrom,realto: realto, originfrom: originfrom, originto: originto, sendjid: sendjid, origintype: origintype) |> Protomessage.encode()
  end

  def set_type("chat"), do: :SignalTypeChat
  def set_type("groupchat"), do: :SignalTypeGroupChat
  def set_type("note"), do: :SignalTypeNote
  def set_type("readmark"), do: :SignalTypeReadmark
  def set_type("mstat"), do: :SignalTypeMState
  def set_type("carbon"), do: :SignalTypeCarbon
  def set_type("subscription"), do: :SignalTypeSubscription
  def set_type("headline"), do: :SignalTypeHeadline
  def set_type("revoke"), do: :SignalTypeRevoke
  def set_type("webrtc"), do: :SignalTypeWebRtc
  def set_type("consult"), do: :SignalTypeConsult
  def set_type("typing"), do: :SignalTypeTyping
  def set_type("encrypt"), do: :SignalTypeEncryption
  def set_type("error"), do: :SignalTypeError
  def set_type("collection"), do: :SignalTypeCollection
  def set_type(_), do: :SignalTypeChat

  def struct_pb_xmpp_msg(bodyflag,from,to,type,pattrs,battrs,message,id,time, packet) do
    msg = do_struct_pb_xmpp_msg(bodyflag,pattrs,battrs,message,id,time, packet, type)
    realfrom = :proplists.get_value("realfrom",pattrs :undefined)
    realto = :proplists.get_value("realto",pattrs :undefined)
    originfrom = :proplists.get_value("originfrom",pattrs :undefined)
    originto = :proplists.get_value("originto",pattrs :undefined)
    origintype = :proplists.get_value("origintype",pattrs :undefined)
    sendjid = :proplists.get_value("sendjid",pattrs :undefined)
    msg_type = set_type(type)
    pb_msg = encode_pb_protomessage(from,to,realfrom,realto,originfrom, originto, origintype, msg_type,0,msg, sendjid)
    opt = MessageProtobuf.Encode.get_proto_header_opt(pb_msg)
    MessageProtobuf.Encode.ncode_pb_protoheader(opt,pb_msg)
  end

  def xml2pb_msg(from,to,packet) do
    case :fxml.get_attr("type",xmlel(packet, :attrs)) do
    false ->
        "";
    {_value, type} ->
      time = :qtalk_public.get_exact_timestamp()
        case :fxml.get_subtag(packet,"body") do
        false ->

            case type do
            "stat" ->
                struct_pb_xmpp_msg("nbodyStat",from,to,"stat",xmlel(packet, :attrs),[],"","",time, packet)
            "typing" ->
                struct_pb_xmpp_msg("typing",from,to,"typing",xmlel(packet, :attrs),[],"","",time, packet)
            _ ->
                ""
            end
        body ->
            id = case :proplists.get_value("id",xmlel(body, :attrs), :undefined) do
              :undefined ->
                "http_#{:random.uniform(65536)}#{:qtalk_public.get_exact_timestamp()}"
              i ->
                i
              end
            message = :fxml.get_subtag_cdata(packet,"body")
            attrs = xmlel(packet, :attrs)
            time = get_packet_time(attrs)
            struct_pb_xmpp_msg(type,from,to,type,attrs,xmlel(body, :attrs),message,id,time, packet)
        end
    end
  end

    def get_packet_time(pattrs) do
      case :proplists.get_value("msec_times",pattrs, :undefined) do
          :undefined -> :qtalk_public.get_exact_timestamp()
          t -> String.to_integer(t)
      end
    end


end
