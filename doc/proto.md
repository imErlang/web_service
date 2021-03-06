## Protobuf 文档详解

```protobuf
syntax = "proto2";

enum presencekeytype {
  PresenceKeyDefault = 0;
  PresenceKeyPriority = 1;
  PresenceKeyVerifyFriend = 2;
  PresenceKeyManualAuthenticationConfirm = 3;
  PresenceKeyResult = 6;
  PresenceKeyNotify = 7;
  PresenceKeyError = 8;
}

enum categorytype {
  CategoryDefault = 0;
  CategoryOrganizational = 1;
  CategorySessionList = 2;
  CategoryNavigation = 3;
  CategoryOPSNotification = 4;
  CategoryAskLog = 10;
  CategoryGlobalNotification = 98;
  CategorySpecifyNotification = 99;
  CategoryTickUser = 100;
}

enum iqmessagekeytype {
  IQKeyDefault = 0;
  IQKeyBind = 1;
  IQKeyMucCreate = 2;
  IQKeyMucCreateV2 = 3;
  IQKeyMucInviteV2 = 4;
  IQKeyGetMucUser = 5;
  IQKeySetMucUser = 6;
  IQKeyDelMucUser = 7;
  IQKeyAddUserSubscribe = 8;
  IQKeyDelUserSubscribe = 9;
  IQKeyGetUserSubScribe = 10;
  IQKeyGetVerifyFriendOpt = 11;
  IQKeySetVerifyFriendOpt = 12;
  IQKeySetUserSubScribeV2 = 13;
  IQKeyGetUserSubScribeV2 = 14;
  IQKeyGetUserFriend = 16;
  IQKeyDelUserFriend = 18;
  IQKeyGetUserKey = 20;
  IQKeyGetUserMask = 22;
  IQKeySetUserMask = 24;
  IQKeyCancelUSerMask = 26;
  IQKeySetAdmin = 28;
  IQKeySetMember = 30;
  IQKeyCancelMember = 32;
  IQKeyGetUserMucs = 36;
  IQKeyDestroyMuc = 40;
  IQKeyPing = 50;
  IQKeyAddPush = 52;
  IQKeyCancelPush = 60;
  IQKeyResult = 80;
  IQKeyError = 90;
  IQKeyGetVUser = 92;
  IQKeyGetVUserRole = 94;
  IQKeyStartSession = 96;
  IQKeyEndSession = 98;
  IQKeySessionEvent = 99;
}
enum stringheadertype {
  StringHeaderTypeDefault = 0;
  StringHeaderTypeChatId = 1;
  StringHeaderTypeChannelId = 2;
  StringHeaderTypeExtendInfo = 3;
  StringHeaderTypeBackupInfo = 4;
  StringHeaderTypeReadType = 5;
  StringHeaderTypeJid = 7;
  StringHeaderTypeRealJid = 8;
  StringHeaderTypeInviteJid = 9;
  StringHeaderTypeDeleleJid = 10;
  StringHeaderTypeNick = 12;
  StringHeaderTypeTitle = 16;
  StringHeaderTypePic = 18;
  StringHeaderTypeVersion = 20;
  StringHeaderTypeMethod = 22;
  StringHeaderTypeBody = 24;
  StringHeaderTypeAffiliation = 28;
  StringHeaderTypeType = 30;
  StringHeaderTypeResult = 32;
  StringHeaderTypeReason = 34;
  StringHeaderTypeRole = 36;
  StringHeaderTypeDomain = 38;
  StringHeaderTypeStatus = 40;
  StringHeaderTypeCode = 42;
  StringHeaderTypeCdata = 50;
  StringHeaderTypeTimeValue = 52;
  StringHeaderTypeKeyValue = 54;
  StringHeaderTypeName = 56;
  StringHeaderTypeHost = 58;
  StringHeaderTypeQuestion = 60;
  StringHeaderTypeAnswer = 62;
  StringHeaderTypeFriends = 64;
  StringHeaderTypeValue = 66;
  StringHeaderTypeMaskedUuser = 68;
  StringHeaderTypeKey = 70;
  StringHeaderTypeCarbon = 72;
  StringHeaderTypeMode = 76;
}

enum messagetype {
  MessageTypeDefault = 0;
  MessageTypePNote = -11;
  MessageTypeRevoke = -1;
  MessageTypeText = 1;
  MessageTypeVoice = 2;
  MessageTypePhoto = 3;
  MessageTypeSogouIcon = 4;
  MessageTypeFile = 5;
  MessageTypeTopic = 6;
  MessageTypeRichText = 7;
  MessageTypeActionRichText = 8;
  MessageTypeReply = 9;
  MessageTypeShock = 10;
  MessageTypeNote = 11;
  MessageTypeGroupAt = 12;
  MessageTypeMarkdown = 13;
  MessageTypeGroupNotify = 15;
  MessageTypeLocalShare = 16;
  MessageTypeWebRTCAudio = 20;
  MessageTypeWebRTCVidio = 21;
  MessageTypeImageNew = 30;
  MessageTypeSmallVideo = 32;
  MessageTypeSourceCode = 64;
  MessageTypeTime = 101;
  MessageTypeBurnAfterRead = 128;
  MessageTypeCardShare = 256;
  MessageTypeMeetingRemind = 257;
  MessageTypeEncrypt = 404;
  MessageTypeActivity = 511;
  MessageTypeRedPack = 512;
  MessageTypeAA = 513;
  MessageTypeCommonTrdInfo = 666;
  MessageTypeCommonProductInfo = 888;
  MessageTypeTransChatToCustomer = 1001;
  MessageTypeTransChatToCustomerService = 1002;
  MessageTypeTransChatToCustomer_Feedback = 1003;
  MessageTypeTransChatToCustomerService_Feedback = 1004;
  MessageTypeRedPackInfo = 1024;
  MessageTypeAAInfo = 1025;
  MessageTypeConsult = 2001;
  MessageTypeConsultResult = 2002;
  MessageTypeGrabMenuVcard = 2003;
  MessageTypeGrabMenuResult = 2004;
  MessageTypeQCZhongbao = 2005;
  MessageTypeMicroTourGuide = 3001;
  MessageTypeProduct = 4096;
  WebRTC_MsgType_VideoMeeting = 5001;
  MessageTypeShareLocation = 8192;
  WebRTC_MsgType_Live = 65501;
  WebRTC_MsgType_Video = 65535;
  MessageTypeRobotQuestionList = 65536;
  MessageTypeRobotTurnToUser = 65537;
  WebRTC_MsgType_Audio = 131072;
  MessageTypeNotice = 134217728;
  MessageTypeSystem = 268435456;
  MediaTypeSystemLY = 268435457;
}

enum clienttype {
  ClientTypeDefault = 0;
  ClientTypeMac = 1;
  ClientTypeiOS = 2;
  ClientTypePC = 3;
  ClientTypeAndroid = 4;
  ClientTypeLinux = 5;
  ClientTypeWeb = 6;
}
enum signaltype {
  SignalTypeDefault = 0;
  SignalTypePresence = 1;
  SignalTypeIQ = 2;
  SignalTypeIQResponse = 3;
  SignalTypeSucceededResponse = 4;
  SignalTypeFailureResponse = 5;
  SignalTypeChat = 6;
  SignalTypeGroupChat = 7;
  SignalTypeNormal = 8;
  SignalTypeError = 9;
  SignalTypeTyping = 10;
  SignalTypeNote = 11;
  SignalTypeTransfor = 12;
  SignalTypeReadmark = 13;
  SignalTypeRevoke = 14;
  SignalTypeSubscription = 15;
  SignalTypeMState = 16;
  SignalTypeHeadline = 17;
  SignalTypeShareLocation = 20;
  SignalTypeHeartBeat = 30;
  SignalTypeAuth = 45;
  SignalTypeStreamBegin = 50;
  SignalTypeStreamEnd = 51;
  SignalTypeWelcome = 100;
  SignalTypeUserConnect = 101;
  SignalTypeChallenge = 102;
  SignalStartTLS = 106;
  SignalProceedTLS = 108;
  SignalTypeWebRtc = 110;
  SignalTypeCarbon = 128;
  SignalTypeConsult = 132;
  SignalTypeEncryption = 136;
  SignalTypeCollection = 140;
}

message messagekeyvalue {
  optional string key = 1;
  optional string value = 2;
}

message stringheader {
  repeated messagekeyvalue params = 1;
  optional string key = 2;
  optional string value = 3;
  optional stringheadertype definedkey = 4;
}

message packagelength { optional int32 length = 1; }

message protoheader {
  optional int32 version = 1;
  optional int32 options = 2;
  repeated int32 optionlist = 3 [packed=true];
  optional int32 length = 4;
  optional string content = 5;
  optional bytes message = 6;
}

message messagebody {
  repeated stringheader headers = 1;
  optional string value = 2;
  repeated messagebody bodys = 3;
}

message authmessage {
  optional string mechanism = 1;
  optional string method = 2;
  optional string msgid = 3;
  optional string authkey = 4;
  optional messagebody otherbody = 5;
}

message welcomemessage {
  optional string domain = 1;
  optional string version = 2;
  optional string user = 3;
  optional string sockmod = 4;
}

message streambegin {
  optional string domain = 1;
  optional string version = 2;
  repeated messagebody bodys = 3;
}

message starttls {}

message proceedtls {}

message streamend {
  optional string reason = 1;
  optional int32 code = 2;
}

message userconnect {
  optional string domain = 1;
  optional string version = 2;
}

message capability {
  optional string version = 1;
  optional messagebody bodys = 2;
}

message responsesucceeded {
  optional int32 code = 1;
  optional string msgid = 2;
  optional string info = 3;
  optional messagebody body = 4;
}

message responsefailure {
  optional int32 code = 1;
  optional string msgid = 2;
  optional string error = 3;
  optional messagebody body = 4;
}

message protomessage {
  optional int32 options = 1;
  required signaltype signaltype = 2;
  optional string from = 3;
  optional string to = 4;
  optional bytes message = 5;
  optional string realfrom = 6;
  optional string realto = 7;
  optional string originfrom = 8;
  optional string originto = 9;
  optional string origintype = 10;
  optional string sendjid = 11;
}

message iqmessage {
  optional string namespace = 1;
  optional string key = 2;
  optional string value = 3;
  optional string messageid = 4;
  optional stringheader header = 5;
  optional messagebody body = 6;
  optional int64 receivedtime = 7;
  optional int64 transfertime = 8;
  repeated stringheader headers = 9;
  repeated messagebody bodys = 10;
  optional iqmessagekeytype definedkey = 11;
}

message presencemessage {
  optional string namespace = 1;
  optional string key = 2;
  optional string value = 3;
  optional string messageid = 4;
  optional string header = 5;
  optional messagebody body = 6;
  optional int64 receivedtime = 7;
  optional int64 transfertime = 8;
  repeated stringheader headers = 9;
  repeated messagebody bodys = 10;
  optional presencekeytype definedkey = 11;
  optional categorytype categorytype = 12;
}

message xmppmessage {
  required messagetype messagetype = 1;
  required clienttype clienttype = 2;
  required int64 clientversion = 3;
  optional string namespace = 4;
  optional string key = 5;
  optional string value = 6;
  optional string messageid = 7;
  optional stringheader header = 8;
  optional messagebody body = 9;
  optional int64 receivedtime = 10;
  optional int64 transfertime = 11;
  repeated stringheader headers = 12;
  repeated messagebody bodys = 13;
}
```