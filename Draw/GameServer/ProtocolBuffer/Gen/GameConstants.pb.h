// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

typedef enum {
  GameCommandTypeJoinGameRequest = 1,
  GameCommandTypeJoinGameResponse = 2,
  GameCommandTypeStartGameRequest = 3,
  GameCommandTypeStartGameResponse = 4,
  GameCommandTypeQuitGameRequest = 5,
  GameCommandTypeQuitGameResponse = 6,
  GameCommandTypeSendDrawDataRequest = 11,
  GameCommandTypeSendDrawDataResponse = 12,
  GameCommandTypeCleanDrawRequest = 13,
  GameCommandTypeCleanDrawResponse = 14,
  GameCommandTypeChatRequest = 15,
  GameCommandTypeChatResponse = 16,
  GameCommandTypeCompleteGameRequest = 17,
  GameCommandTypeCompleteGameResponse = 18,
  GameCommandTypeForceUserQuitRequest = 19,
  GameCommandTypeForceUserQuitResponse = 20,
  GameCommandTypeFacetimeChatRequest = 81,
  GameCommandTypeFacetimeChatResponse = 82,
  GameCommandTypeFacetimeChatStart = 83,
  GameCommandTypeKeepAliveRequest = 91,
  GameCommandTypeKeepAliveResponse = 92,
  GameCommandTypeGetRoomsRequest = 601,
  GameCommandTypeGetRoomsResponse = 602,
  GameCommandTypeCreateRoomRequest = 603,
  GameCommandTypeCreateRoomResponse = 604,
  GameCommandTypeEnterRoomRequest = 605,
  GameCommandTypeEnterRoomResponse = 606,
  GameCommandTypeRegisterRoomsNotificationRequest = 607,
  GameCommandTypeRegisterRoomsNotificationResponse = 608,
  GameCommandTypeUnregisterRoomsNotificationRequest = 609,
  GameCommandTypeUnregisterRoomsNotificationResponse = 610,
  GameCommandTypeCallDiceRequest = 621,
  GameCommandTypeCallDiceResponse = 622,
  GameCommandTypeOpenDiceRequest = 623,
  GameCommandTypeOpenDiceResponse = 624,
  GameCommandTypeUseItemRequest = 631,
  GameCommandTypeUseItemResponse = 632,
  GameCommandTypeUserJoinNotificationRequest = 51,
  GameCommandTypeUserJoinNotificationResponse = 52,
  GameCommandTypeUserQuitNotificationRequest = 53,
  GameCommandTypeUserQuitNotificationResponse = 54,
  GameCommandTypeGameStartNotificationRequest = 55,
  GameCommandTypeGameStartNotificationResponse = 56,
  GameCommandTypeHostChangeNotificationRequest = 61,
  GameCommandTypeHostChangeNotificationResponse = 62,
  GameCommandTypeNewDrawDataNotificationRequest = 71,
  GameCommandTypeNewDrawDataNotificationResponse = 72,
  GameCommandTypeCleanDrawNotificationRequest = 73,
  GameCommandTypeCleanDrawNotificationResponse = 74,
  GameCommandTypeChatNotificationRequest = 75,
  GameCommandTypeChatNotificationResponse = 76,
  GameCommandTypeGameTurnCompleteNotificationRequest = 77,
  GameCommandTypeGameTurnCompleteNotificationResponse = 78,
  GameCommandTypeLocalChannelDisconnect = 201,
  GameCommandTypeLocalFinishGame = 203,
  GameCommandTypeLocalJoinGame = 204,
  GameCommandTypeLocalGameTurnComplete = 205,
  GameCommandTypeLocalUserTimeOut = 206,
  GameCommandTypeLocalNewUserJoin = 301,
  GameCommandTypeLocalUserQuit = 302,
  GameCommandTypeLocalDrawUserQuit = 303,
  GameCommandTypeLocalAllOtherUserQuit = 304,
  GameCommandTypeLocalOtherUserQuit = 305,
  GameCommandTypeLocalTimeOut = 306,
  GameCommandTypeLocalStartGame = 307,
  GameCommandTypeLocalWordPicked = 308,
  GameCommandTypeLocalAllUserGuess = 309,
  GameCommandTypeLocalDrawUserChat = 310,
  GameCommandTypeLocalPlayUserQuit = 311,
  GameCommandTypeLocalCallDice = 312,
  GameCommandTypeLocalOpenDice = 313,
  GameCommandTypeRoomNotificationRequest = 701,
  GameCommandTypeRoomNotificationResponse = 702,
  GameCommandTypeRollDiceBeginNotificationRequest = 711,
  GameCommandTypeRollDiceBeginNotificationResponse = 712,
  GameCommandTypeRollDiceEndNotificationRequest = 713,
  GameCommandTypeRollDiceEndNotificationResponse = 714,
  GameCommandTypeNextPlayerStartNotificationRequest = 715,
  GameCommandTypeNextPlayerStartNotificationResponse = 716,
  GameCommandTypeGameOverNotificationRequest = 731,
  GameCommandTypeGameOverNotificationResponse = 732,
} GameCommandType;

BOOL GameCommandTypeIsValidValue(GameCommandType value);

typedef enum {
  GameResultCodeSuccess = 0,
  GameResultCodeErrorJoinGame = 1,
  GameResultCodeErrorUseridNull = 100,
  GameResultCodeErrorUserCannotStartGame = 101,
  GameResultCodeErrorUserNotInSession = 102,
  GameResultCodeErrorUserNotCurrentPlayUser = 103,
  GameResultCodeErrorNoSessionId = 200,
  GameResultCodeErrorNextStateNotFound = 201,
  GameResultCodeErrorSessionidNull = 202,
  GameResultCodeErrorSessionAlreadyStart = 203,
  GameResultCodeErrorSessionNotStart = 204,
  GameResultCodeErrorNoSessionAvailable = 205,
  GameResultCodeErrorSessionidFull = 206,
  GameResultCodeErrorNoDrawData = 301,
  GameResultCodeErrorDiceAlreadyOpen = 401,
  GameResultCodeErrorSystemHandlerNotFound = 910,
  GameResultCodeErrorSystemException = 911,
} GameResultCode;

BOOL GameResultCodeIsValidValue(GameResultCode value);

typedef enum {
  GameCompleteReasonReasonNotComplete = 0,
  GameCompleteReasonReasonAllUserGuess = 1,
  GameCompleteReasonReasonAllUserQuit = 11,
  GameCompleteReasonReasonDrawUserQuit = 12,
  GameCompleteReasonReasonOnlyOneUser = 13,
  GameCompleteReasonReasonExpired = 21,
} GameCompleteReason;

BOOL GameCompleteReasonIsValidValue(GameCompleteReason value);

typedef enum {
  GameChatTypeChatGroup = 0,
  GameChatTypeChatPrivate = 1,
} GameChatType;

BOOL GameChatTypeIsValidValue(GameChatType value);


@interface GameConstantsRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

