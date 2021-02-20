defmodule Presencekeytype do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto2

  @type t ::
          integer
          | :PresenceKeyDefault
          | :PresenceKeyPriority
          | :PresenceKeyVerifyFriend
          | :PresenceKeyManualAuthenticationConfirm
          | :PresenceKeyResult
          | :PresenceKeyNotify
          | :PresenceKeyError

  field :PresenceKeyDefault, 0

  field :PresenceKeyPriority, 1

  field :PresenceKeyVerifyFriend, 2

  field :PresenceKeyManualAuthenticationConfirm, 3

  field :PresenceKeyResult, 6

  field :PresenceKeyNotify, 7

  field :PresenceKeyError, 8
end

defmodule Categorytype do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto2

  @type t ::
          integer
          | :CategoryDefault
          | :CategoryOrganizational
          | :CategorySessionList
          | :CategoryNavigation
          | :CategoryOPSNotification
          | :CategoryAskLog
          | :CategoryGlobalNotification
          | :CategorySpecifyNotification
          | :CategoryTickUser

  field :CategoryDefault, 0

  field :CategoryOrganizational, 1

  field :CategorySessionList, 2

  field :CategoryNavigation, 3

  field :CategoryOPSNotification, 4

  field :CategoryAskLog, 10

  field :CategoryGlobalNotification, 98

  field :CategorySpecifyNotification, 99

  field :CategoryTickUser, 100
end

defmodule Iqmessagekeytype do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto2

  @type t ::
          integer
          | :IQKeyDefault
          | :IQKeyBind
          | :IQKeyMucCreate
          | :IQKeyMucCreateV2
          | :IQKeyMucInviteV2
          | :IQKeyGetMucUser
          | :IQKeySetMucUser
          | :IQKeyDelMucUser
          | :IQKeyAddUserSubscribe
          | :IQKeyDelUserSubscribe
          | :IQKeyGetUserSubScribe
          | :IQKeyGetVerifyFriendOpt
          | :IQKeySetVerifyFriendOpt
          | :IQKeySetUserSubScribeV2
          | :IQKeyGetUserSubScribeV2
          | :IQKeyGetUserFriend
          | :IQKeyDelUserFriend
          | :IQKeyGetUserKey
          | :IQKeyGetUserMask
          | :IQKeySetUserMask
          | :IQKeyCancelUSerMask
          | :IQKeySetAdmin
          | :IQKeySetMember
          | :IQKeyCancelMember
          | :IQKeyGetUserMucs
          | :IQKeyDestroyMuc
          | :IQKeyPing
          | :IQKeyAddPush
          | :IQKeyCancelPush
          | :IQKeyResult
          | :IQKeyError
          | :IQKeyGetVUser
          | :IQKeyGetVUserRole
          | :IQKeyStartSession
          | :IQKeyEndSession
          | :IQKeySessionEvent

  field :IQKeyDefault, 0

  field :IQKeyBind, 1

  field :IQKeyMucCreate, 2

  field :IQKeyMucCreateV2, 3

  field :IQKeyMucInviteV2, 4

  field :IQKeyGetMucUser, 5

  field :IQKeySetMucUser, 6

  field :IQKeyDelMucUser, 7

  field :IQKeyAddUserSubscribe, 8

  field :IQKeyDelUserSubscribe, 9

  field :IQKeyGetUserSubScribe, 10

  field :IQKeyGetVerifyFriendOpt, 11

  field :IQKeySetVerifyFriendOpt, 12

  field :IQKeySetUserSubScribeV2, 13

  field :IQKeyGetUserSubScribeV2, 14

  field :IQKeyGetUserFriend, 16

  field :IQKeyDelUserFriend, 18

  field :IQKeyGetUserKey, 20

  field :IQKeyGetUserMask, 22

  field :IQKeySetUserMask, 24

  field :IQKeyCancelUSerMask, 26

  field :IQKeySetAdmin, 28

  field :IQKeySetMember, 30

  field :IQKeyCancelMember, 32

  field :IQKeyGetUserMucs, 36

  field :IQKeyDestroyMuc, 40

  field :IQKeyPing, 50

  field :IQKeyAddPush, 52

  field :IQKeyCancelPush, 60

  field :IQKeyResult, 80

  field :IQKeyError, 90

  field :IQKeyGetVUser, 92

  field :IQKeyGetVUserRole, 94

  field :IQKeyStartSession, 96

  field :IQKeyEndSession, 98

  field :IQKeySessionEvent, 99
end

defmodule Stringheadertype do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto2

  @type t ::
          integer
          | :StringHeaderTypeDefault
          | :StringHeaderTypeChatId
          | :StringHeaderTypeChannelId
          | :StringHeaderTypeExtendInfo
          | :StringHeaderTypeBackupInfo
          | :StringHeaderTypeReadType
          | :StringHeaderTypeJid
          | :StringHeaderTypeRealJid
          | :StringHeaderTypeInviteJid
          | :StringHeaderTypeDeleleJid
          | :StringHeaderTypeNick
          | :StringHeaderTypeTitle
          | :StringHeaderTypePic
          | :StringHeaderTypeVersion
          | :StringHeaderTypeMethod
          | :StringHeaderTypeBody
          | :StringHeaderTypeAffiliation
          | :StringHeaderTypeType
          | :StringHeaderTypeResult
          | :StringHeaderTypeReason
          | :StringHeaderTypeRole
          | :StringHeaderTypeDomain
          | :StringHeaderTypeStatus
          | :StringHeaderTypeCode
          | :StringHeaderTypeCdata
          | :StringHeaderTypeTimeValue
          | :StringHeaderTypeKeyValue
          | :StringHeaderTypeName
          | :StringHeaderTypeHost
          | :StringHeaderTypeQuestion
          | :StringHeaderTypeAnswer
          | :StringHeaderTypeFriends
          | :StringHeaderTypeValue
          | :StringHeaderTypeMaskedUuser
          | :StringHeaderTypeKey
          | :StringHeaderTypeCarbon
          | :StringHeaderTypeMode

  field :StringHeaderTypeDefault, 0

  field :StringHeaderTypeChatId, 1

  field :StringHeaderTypeChannelId, 2

  field :StringHeaderTypeExtendInfo, 3

  field :StringHeaderTypeBackupInfo, 4

  field :StringHeaderTypeReadType, 5

  field :StringHeaderTypeJid, 7

  field :StringHeaderTypeRealJid, 8

  field :StringHeaderTypeInviteJid, 9

  field :StringHeaderTypeDeleleJid, 10

  field :StringHeaderTypeNick, 12

  field :StringHeaderTypeTitle, 16

  field :StringHeaderTypePic, 18

  field :StringHeaderTypeVersion, 20

  field :StringHeaderTypeMethod, 22

  field :StringHeaderTypeBody, 24

  field :StringHeaderTypeAffiliation, 28

  field :StringHeaderTypeType, 30

  field :StringHeaderTypeResult, 32

  field :StringHeaderTypeReason, 34

  field :StringHeaderTypeRole, 36

  field :StringHeaderTypeDomain, 38

  field :StringHeaderTypeStatus, 40

  field :StringHeaderTypeCode, 42

  field :StringHeaderTypeCdata, 50

  field :StringHeaderTypeTimeValue, 52

  field :StringHeaderTypeKeyValue, 54

  field :StringHeaderTypeName, 56

  field :StringHeaderTypeHost, 58

  field :StringHeaderTypeQuestion, 60

  field :StringHeaderTypeAnswer, 62

  field :StringHeaderTypeFriends, 64

  field :StringHeaderTypeValue, 66

  field :StringHeaderTypeMaskedUuser, 68

  field :StringHeaderTypeKey, 70

  field :StringHeaderTypeCarbon, 72

  field :StringHeaderTypeMode, 76
end

defmodule Messagetype do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto2

  @type t ::
          integer
          | :MessageTypeDefault
          | :MessageTypePNote
          | :MessageTypeRevoke
          | :MessageTypeText
          | :MessageTypeVoice
          | :MessageTypePhoto
          | :MessageTypeSogouIcon
          | :MessageTypeFile
          | :MessageTypeTopic
          | :MessageTypeRichText
          | :MessageTypeActionRichText
          | :MessageTypeReply
          | :MessageTypeShock
          | :MessageTypeNote
          | :MessageTypeGroupAt
          | :MessageTypeMarkdown
          | :MessageTypeGroupNotify
          | :MessageTypeLocalShare
          | :MessageTypeWebRTCAudio
          | :MessageTypeWebRTCVidio
          | :MessageTypeImageNew
          | :MessageTypeSmallVideo
          | :MessageTypeSourceCode
          | :MessageTypeTime
          | :MessageTypeBurnAfterRead
          | :MessageTypeCardShare
          | :MessageTypeMeetingRemind
          | :MessageTypeEncrypt
          | :MessageTypeActivity
          | :MessageTypeRedPack
          | :MessageTypeAA
          | :MessageTypeCommonTrdInfo
          | :MessageTypeCommonProductInfo
          | :MessageTypeTransChatToCustomer
          | :MessageTypeTransChatToCustomerService
          | :MessageTypeTransChatToCustomer_Feedback
          | :MessageTypeTransChatToCustomerService_Feedback
          | :MessageTypeRedPackInfo
          | :MessageTypeAAInfo
          | :MessageTypeConsult
          | :MessageTypeConsultResult
          | :MessageTypeGrabMenuVcard
          | :MessageTypeGrabMenuResult
          | :MessageTypeQCZhongbao
          | :MessageTypeMicroTourGuide
          | :MessageTypeProduct
          | :WebRTC_MsgType_VideoMeeting
          | :MessageTypeShareLocation
          | :WebRTC_MsgType_Live
          | :WebRTC_MsgType_Video
          | :MessageTypeRobotQuestionList
          | :MessageTypeRobotTurnToUser
          | :WebRTC_MsgType_Audio
          | :MessageTypeNotice
          | :MessageTypeSystem
          | :MediaTypeSystemLY

  field :MessageTypeDefault, 0

  field :MessageTypePNote, -11

  field :MessageTypeRevoke, -1

  field :MessageTypeText, 1

  field :MessageTypeVoice, 2

  field :MessageTypePhoto, 3

  field :MessageTypeSogouIcon, 4

  field :MessageTypeFile, 5

  field :MessageTypeTopic, 6

  field :MessageTypeRichText, 7

  field :MessageTypeActionRichText, 8

  field :MessageTypeReply, 9

  field :MessageTypeShock, 10

  field :MessageTypeNote, 11

  field :MessageTypeGroupAt, 12

  field :MessageTypeMarkdown, 13

  field :MessageTypeGroupNotify, 15

  field :MessageTypeLocalShare, 16

  field :MessageTypeWebRTCAudio, 20

  field :MessageTypeWebRTCVidio, 21

  field :MessageTypeImageNew, 30

  field :MessageTypeSmallVideo, 32

  field :MessageTypeSourceCode, 64

  field :MessageTypeTime, 101

  field :MessageTypeBurnAfterRead, 128

  field :MessageTypeCardShare, 256

  field :MessageTypeMeetingRemind, 257

  field :MessageTypeEncrypt, 404

  field :MessageTypeActivity, 511

  field :MessageTypeRedPack, 512

  field :MessageTypeAA, 513

  field :MessageTypeCommonTrdInfo, 666

  field :MessageTypeCommonProductInfo, 888

  field :MessageTypeTransChatToCustomer, 1001

  field :MessageTypeTransChatToCustomerService, 1002

  field :MessageTypeTransChatToCustomer_Feedback, 1003

  field :MessageTypeTransChatToCustomerService_Feedback, 1004

  field :MessageTypeRedPackInfo, 1024

  field :MessageTypeAAInfo, 1025

  field :MessageTypeConsult, 2001

  field :MessageTypeConsultResult, 2002

  field :MessageTypeGrabMenuVcard, 2003

  field :MessageTypeGrabMenuResult, 2004

  field :MessageTypeQCZhongbao, 2005

  field :MessageTypeMicroTourGuide, 3001

  field :MessageTypeProduct, 4096

  field :WebRTC_MsgType_VideoMeeting, 5001

  field :MessageTypeShareLocation, 8192

  field :WebRTC_MsgType_Live, 65501

  field :WebRTC_MsgType_Video, 65535

  field :MessageTypeRobotQuestionList, 65536

  field :MessageTypeRobotTurnToUser, 65537

  field :WebRTC_MsgType_Audio, 131_072

  field :MessageTypeNotice, 134_217_728

  field :MessageTypeSystem, 268_435_456

  field :MediaTypeSystemLY, 268_435_457
end

defmodule Clienttype do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto2

  @type t ::
          integer
          | :ClientTypeDefault
          | :ClientTypeMac
          | :ClientTypeiOS
          | :ClientTypePC
          | :ClientTypeAndroid
          | :ClientTypeLinux
          | :ClientTypeWeb

  field :ClientTypeDefault, 0

  field :ClientTypeMac, 1

  field :ClientTypeiOS, 2

  field :ClientTypePC, 3

  field :ClientTypeAndroid, 4

  field :ClientTypeLinux, 5

  field :ClientTypeWeb, 6
end

defmodule Signaltype do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto2

  @type t ::
          integer
          | :SignalTypeDefault
          | :SignalTypePresence
          | :SignalTypeIQ
          | :SignalTypeIQResponse
          | :SignalTypeSucceededResponse
          | :SignalTypeFailureResponse
          | :SignalTypeChat
          | :SignalTypeGroupChat
          | :SignalTypeNormal
          | :SignalTypeError
          | :SignalTypeTyping
          | :SignalTypeNote
          | :SignalTypeTransfor
          | :SignalTypeReadmark
          | :SignalTypeRevoke
          | :SignalTypeSubscription
          | :SignalTypeMState
          | :SignalTypeHeadline
          | :SignalTypeShareLocation
          | :SignalTypeHeartBeat
          | :SignalTypeAuth
          | :SignalTypeStreamBegin
          | :SignalTypeStreamEnd
          | :SignalTypeWelcome
          | :SignalTypeUserConnect
          | :SignalTypeChallenge
          | :SignalStartTLS
          | :SignalProceedTLS
          | :SignalTypeWebRtc
          | :SignalTypeCarbon
          | :SignalTypeConsult
          | :SignalTypeEncryption
          | :SignalTypeCollection

  field :SignalTypeDefault, 0

  field :SignalTypePresence, 1

  field :SignalTypeIQ, 2

  field :SignalTypeIQResponse, 3

  field :SignalTypeSucceededResponse, 4

  field :SignalTypeFailureResponse, 5

  field :SignalTypeChat, 6

  field :SignalTypeGroupChat, 7

  field :SignalTypeNormal, 8

  field :SignalTypeError, 9

  field :SignalTypeTyping, 10

  field :SignalTypeNote, 11

  field :SignalTypeTransfor, 12

  field :SignalTypeReadmark, 13

  field :SignalTypeRevoke, 14

  field :SignalTypeSubscription, 15

  field :SignalTypeMState, 16

  field :SignalTypeHeadline, 17

  field :SignalTypeShareLocation, 20

  field :SignalTypeHeartBeat, 30

  field :SignalTypeAuth, 45

  field :SignalTypeStreamBegin, 50

  field :SignalTypeStreamEnd, 51

  field :SignalTypeWelcome, 100

  field :SignalTypeUserConnect, 101

  field :SignalTypeChallenge, 102

  field :SignalStartTLS, 106

  field :SignalProceedTLS, 108

  field :SignalTypeWebRtc, 110

  field :SignalTypeCarbon, 128

  field :SignalTypeConsult, 132

  field :SignalTypeEncryption, 136

  field :SignalTypeCollection, 140
end

defmodule Messagekeyvalue do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          key: String.t(),
          value: String.t()
        }

  defstruct [:key, :value]

  field :key, 1, optional: true, type: :string
  field :value, 2, optional: true, type: :string
end

defmodule Stringheader do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          params: [Messagekeyvalue.t()],
          key: String.t(),
          value: String.t(),
          definedkey: Stringheadertype.t()
        }

  defstruct [:params, :key, :value, :definedkey]

  field :params, 1, repeated: true, type: Messagekeyvalue
  field :key, 2, optional: true, type: :string
  field :value, 3, optional: true, type: :string
  field :definedkey, 4, optional: true, type: Stringheadertype, enum: true
end

defmodule Packagelength do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          length: integer
        }

  defstruct [:length]

  field :length, 1, optional: true, type: :int32
end

defmodule Protoheader do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          version: integer,
          options: integer,
          optionlist: [integer],
          length: integer,
          content: String.t(),
          message: binary
        }

  defstruct [:version, :options, :optionlist, :length, :content, :message]

  field :version, 1, optional: true, type: :int32
  field :options, 2, optional: true, type: :int32
  field :optionlist, 3, repeated: true, type: :int32, packed: true
  field :length, 4, optional: true, type: :int32
  field :content, 5, optional: true, type: :string
  field :message, 6, optional: true, type: :bytes
end

defmodule Messagebody do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          headers: [Stringheader.t()],
          value: String.t(),
          bodys: [Messagebody.t()]
        }

  defstruct [:headers, :value, :bodys]

  field :headers, 1, repeated: true, type: Stringheader
  field :value, 2, optional: true, type: :string
  field :bodys, 3, repeated: true, type: Messagebody
end

defmodule Authmessage do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          mechanism: String.t(),
          method: String.t(),
          msgid: String.t(),
          authkey: String.t(),
          otherbody: Messagebody.t() | nil
        }

  defstruct [:mechanism, :method, :msgid, :authkey, :otherbody]

  field :mechanism, 1, optional: true, type: :string
  field :method, 2, optional: true, type: :string
  field :msgid, 3, optional: true, type: :string
  field :authkey, 4, optional: true, type: :string
  field :otherbody, 5, optional: true, type: Messagebody
end

defmodule Welcomemessage do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          domain: String.t(),
          version: String.t(),
          user: String.t(),
          sockmod: String.t()
        }

  defstruct [:domain, :version, :user, :sockmod]

  field :domain, 1, optional: true, type: :string
  field :version, 2, optional: true, type: :string
  field :user, 3, optional: true, type: :string
  field :sockmod, 4, optional: true, type: :string
end

defmodule Streambegin do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          domain: String.t(),
          version: String.t(),
          bodys: [Messagebody.t()]
        }

  defstruct [:domain, :version, :bodys]

  field :domain, 1, optional: true, type: :string
  field :version, 2, optional: true, type: :string
  field :bodys, 3, repeated: true, type: Messagebody
end

defmodule Starttls do
  @moduledoc false
  use Protobuf, syntax: :proto2
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Proceedtls do
  @moduledoc false
  use Protobuf, syntax: :proto2
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Streamend do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          reason: String.t(),
          code: integer
        }

  defstruct [:reason, :code]

  field :reason, 1, optional: true, type: :string
  field :code, 2, optional: true, type: :int32
end

defmodule Userconnect do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          domain: String.t(),
          version: String.t()
        }

  defstruct [:domain, :version]

  field :domain, 1, optional: true, type: :string
  field :version, 2, optional: true, type: :string
end

defmodule Capability do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          version: String.t(),
          bodys: Messagebody.t() | nil
        }

  defstruct [:version, :bodys]

  field :version, 1, optional: true, type: :string
  field :bodys, 2, optional: true, type: Messagebody
end

defmodule Responsesucceeded do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          code: integer,
          msgid: String.t(),
          info: String.t(),
          body: Messagebody.t() | nil
        }

  defstruct [:code, :msgid, :info, :body]

  field :code, 1, optional: true, type: :int32
  field :msgid, 2, optional: true, type: :string
  field :info, 3, optional: true, type: :string
  field :body, 4, optional: true, type: Messagebody
end

defmodule Responsefailure do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          code: integer,
          msgid: String.t(),
          error: String.t(),
          body: Messagebody.t() | nil
        }

  defstruct [:code, :msgid, :error, :body]

  field :code, 1, optional: true, type: :int32
  field :msgid, 2, optional: true, type: :string
  field :error, 3, optional: true, type: :string
  field :body, 4, optional: true, type: Messagebody
end

defmodule Protomessage do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          options: integer,
          signaltype: Signaltype.t(),
          from: String.t(),
          to: String.t(),
          message: binary,
          realfrom: String.t(),
          realto: String.t(),
          originfrom: String.t(),
          originto: String.t(),
          origintype: String.t(),
          sendjid: String.t()
        }

  defstruct [
    :options,
    :signaltype,
    :from,
    :to,
    :message,
    :realfrom,
    :realto,
    :originfrom,
    :originto,
    :origintype,
    :sendjid
  ]

  field :options, 1, optional: true, type: :int32
  field :signaltype, 2, required: true, type: Signaltype, enum: true
  field :from, 3, optional: true, type: :string
  field :to, 4, optional: true, type: :string
  field :message, 5, optional: true, type: :bytes
  field :realfrom, 6, optional: true, type: :string
  field :realto, 7, optional: true, type: :string
  field :originfrom, 8, optional: true, type: :string
  field :originto, 9, optional: true, type: :string
  field :origintype, 10, optional: true, type: :string
  field :sendjid, 11, optional: true, type: :string
end

defmodule Iqmessage do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          namespace: String.t(),
          key: String.t(),
          value: String.t(),
          messageid: String.t(),
          header: Stringheader.t() | nil,
          body: Messagebody.t() | nil,
          receivedtime: integer,
          transfertime: integer,
          headers: [Stringheader.t()],
          bodys: [Messagebody.t()],
          definedkey: Iqmessagekeytype.t()
        }

  defstruct [
    :namespace,
    :key,
    :value,
    :messageid,
    :header,
    :body,
    :receivedtime,
    :transfertime,
    :headers,
    :bodys,
    :definedkey
  ]

  field :namespace, 1, optional: true, type: :string
  field :key, 2, optional: true, type: :string
  field :value, 3, optional: true, type: :string
  field :messageid, 4, optional: true, type: :string
  field :header, 5, optional: true, type: Stringheader
  field :body, 6, optional: true, type: Messagebody
  field :receivedtime, 7, optional: true, type: :int64
  field :transfertime, 8, optional: true, type: :int64
  field :headers, 9, repeated: true, type: Stringheader
  field :bodys, 10, repeated: true, type: Messagebody
  field :definedkey, 11, optional: true, type: Iqmessagekeytype, enum: true
end

defmodule Presencemessage do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          namespace: String.t(),
          key: String.t(),
          value: String.t(),
          messageid: String.t(),
          header: String.t(),
          body: Messagebody.t() | nil,
          receivedtime: integer,
          transfertime: integer,
          headers: [Stringheader.t()],
          bodys: [Messagebody.t()],
          definedkey: Presencekeytype.t(),
          categorytype: Categorytype.t()
        }

  defstruct [
    :namespace,
    :key,
    :value,
    :messageid,
    :header,
    :body,
    :receivedtime,
    :transfertime,
    :headers,
    :bodys,
    :definedkey,
    :categorytype
  ]

  field :namespace, 1, optional: true, type: :string
  field :key, 2, optional: true, type: :string
  field :value, 3, optional: true, type: :string
  field :messageid, 4, optional: true, type: :string
  field :header, 5, optional: true, type: :string
  field :body, 6, optional: true, type: Messagebody
  field :receivedtime, 7, optional: true, type: :int64
  field :transfertime, 8, optional: true, type: :int64
  field :headers, 9, repeated: true, type: Stringheader
  field :bodys, 10, repeated: true, type: Messagebody
  field :definedkey, 11, optional: true, type: Presencekeytype, enum: true
  field :categorytype, 12, optional: true, type: Categorytype, enum: true
end

defmodule Xmppmessage do
  @moduledoc false
  use Protobuf, syntax: :proto2

  @type t :: %__MODULE__{
          messagetype: Messagetype.t(),
          clienttype: Clienttype.t(),
          clientversion: integer,
          namespace: String.t(),
          key: String.t(),
          value: String.t(),
          messageid: String.t(),
          header: Stringheader.t() | nil,
          body: Messagebody.t() | nil,
          receivedtime: integer,
          transfertime: integer,
          headers: [Stringheader.t()],
          bodys: [Messagebody.t()]
        }

  defstruct [
    :messagetype,
    :clienttype,
    :clientversion,
    :namespace,
    :key,
    :value,
    :messageid,
    :header,
    :body,
    :receivedtime,
    :transfertime,
    :headers,
    :bodys
  ]

  field :messagetype, 1, required: true, type: Messagetype, enum: true
  field :clienttype, 2, required: true, type: Clienttype, enum: true
  field :clientversion, 3, required: true, type: :int64
  field :namespace, 4, optional: true, type: :string
  field :key, 5, optional: true, type: :string
  field :value, 6, optional: true, type: :string
  field :messageid, 7, optional: true, type: :string
  field :header, 8, optional: true, type: Stringheader
  field :body, 9, optional: true, type: Messagebody
  field :receivedtime, 10, optional: true, type: :int64
  field :transfertime, 11, optional: true, type: :int64
  field :headers, 12, repeated: true, type: Stringheader
  field :bodys, 13, repeated: true, type: Messagebody
end
