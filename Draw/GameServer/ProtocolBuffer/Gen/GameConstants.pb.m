// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "GameConstants.pb.h"

@implementation GameConstantsRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [GameConstantsRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    extensionRegistry = [registry retain];
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

BOOL GameCommandTypeIsValidValue(GameCommandType value) {
  switch (value) {
    case GameCommandTypeJoinGameRequest:
    case GameCommandTypeJoinGameResponse:
    case GameCommandTypeStartGameRequest:
    case GameCommandTypeStartGameResponse:
    case GameCommandTypeQuitGameRequest:
    case GameCommandTypeQuitGameResponse:
    case GameCommandTypeSendDrawDataRequest:
    case GameCommandTypeSendDrawDataResponse:
    case GameCommandTypeCleanDrawRequest:
    case GameCommandTypeCleanDrawResponse:
    case GameCommandTypeChatRequest:
    case GameCommandTypeChatResponse:
    case GameCommandTypeCompleteGameRequest:
    case GameCommandTypeCompleteGameResponse:
    case GameCommandTypeForceUserQuitRequest:
    case GameCommandTypeForceUserQuitResponse:
    case GameCommandTypeFacetimeChatRequest:
    case GameCommandTypeFacetimeChatResponse:
    case GameCommandTypeFacetimeChatStart:
    case GameCommandTypeKeepAliveRequest:
    case GameCommandTypeKeepAliveResponse:
    case GameCommandTypeGetRoomsRequest:
    case GameCommandTypeGetRoomsResponse:
    case GameCommandTypeCreateRoomRequest:
    case GameCommandTypeCreateRoomResponse:
    case GameCommandTypeEnterRoomRequest:
    case GameCommandTypeEnterRoomResponse:
    case GameCommandTypeRegisterRoomsNotificationRequest:
    case GameCommandTypeRegisterRoomsNotificationResponse:
    case GameCommandTypeUnregisterRoomsNotificationRequest:
    case GameCommandTypeUnregisterRoomsNotificationResponse:
    case GameCommandTypeCallDiceRequest:
    case GameCommandTypeCallDiceResponse:
    case GameCommandTypeOpenDiceRequest:
    case GameCommandTypeOpenDiceResponse:
    case GameCommandTypeUseItemRequest:
    case GameCommandTypeUseItemResponse:
    case GameCommandTypeUserJoinNotificationRequest:
    case GameCommandTypeUserJoinNotificationResponse:
    case GameCommandTypeUserQuitNotificationRequest:
    case GameCommandTypeUserQuitNotificationResponse:
    case GameCommandTypeGameStartNotificationRequest:
    case GameCommandTypeGameStartNotificationResponse:
    case GameCommandTypeHostChangeNotificationRequest:
    case GameCommandTypeHostChangeNotificationResponse:
    case GameCommandTypeNewDrawDataNotificationRequest:
    case GameCommandTypeNewDrawDataNotificationResponse:
    case GameCommandTypeCleanDrawNotificationRequest:
    case GameCommandTypeCleanDrawNotificationResponse:
    case GameCommandTypeChatNotificationRequest:
    case GameCommandTypeChatNotificationResponse:
    case GameCommandTypeGameTurnCompleteNotificationRequest:
    case GameCommandTypeGameTurnCompleteNotificationResponse:
    case GameCommandTypeLocalChannelDisconnect:
    case GameCommandTypeLocalFinishGame:
    case GameCommandTypeLocalJoinGame:
    case GameCommandTypeLocalGameTurnComplete:
    case GameCommandTypeLocalUserTimeOut:
    case GameCommandTypeLocalNewUserJoin:
    case GameCommandTypeLocalUserQuit:
    case GameCommandTypeLocalDrawUserQuit:
    case GameCommandTypeLocalAllOtherUserQuit:
    case GameCommandTypeLocalOtherUserQuit:
    case GameCommandTypeLocalTimeOut:
    case GameCommandTypeLocalStartGame:
    case GameCommandTypeLocalWordPicked:
    case GameCommandTypeLocalAllUserGuess:
    case GameCommandTypeLocalDrawUserChat:
    case GameCommandTypeRoomNotificationRequest:
    case GameCommandTypeRoomNotificationResponse:
    case GameCommandTypeRollDiceBeginNotificationRequest:
    case GameCommandTypeRollDiceBeginNotificationResponse:
    case GameCommandTypeRollDiceEndNotificationRequest:
    case GameCommandTypeRollDiceEndNotificationResponse:
    case GameCommandTypeNextPlayerStartNotificationRequest:
    case GameCommandTypeNextPlayerStartNotificationResponse:
    case GameCommandTypeGameOverNotificationRequest:
    case GameCommandTypeGameOverNotificationResponse:
      return YES;
    default:
      return NO;
  }
}
BOOL GameResultCodeIsValidValue(GameResultCode value) {
  switch (value) {
    case GameResultCodeSuccess:
    case GameResultCodeErrorJoinGame:
    case GameResultCodeErrorUseridNull:
    case GameResultCodeErrorUserCannotStartGame:
    case GameResultCodeErrorUserNotInSession:
    case GameResultCodeErrorNoSessionId:
    case GameResultCodeErrorNextStateNotFound:
    case GameResultCodeErrorSessionidNull:
    case GameResultCodeErrorSessionAlreadyStart:
    case GameResultCodeErrorSessionNotStart:
    case GameResultCodeErrorNoSessionAvailable:
    case GameResultCodeErrorSessionidFull:
    case GameResultCodeErrorNoDrawData:
    case GameResultCodeErrorSystemHandlerNotFound:
    case GameResultCodeErrorSystemException:
      return YES;
    default:
      return NO;
  }
}
BOOL GameCompleteReasonIsValidValue(GameCompleteReason value) {
  switch (value) {
    case GameCompleteReasonReasonNotComplete:
    case GameCompleteReasonReasonAllUserGuess:
    case GameCompleteReasonReasonAllUserQuit:
    case GameCompleteReasonReasonDrawUserQuit:
    case GameCompleteReasonReasonOnlyOneUser:
    case GameCompleteReasonReasonExpired:
      return YES;
    default:
      return NO;
  }
}
BOOL GameChatTypeIsValidValue(GameChatType value) {
  switch (value) {
    case GameChatTypeChatGroup:
    case GameChatTypeChatPrivate:
      return YES;
    default:
      return NO;
  }
}
