// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class PBDraw;
@class PBDrawAction;
@class PBDrawAction_Builder;
@class PBDraw_Builder;
@class PBFeed;
@class PBFeed_Builder;
@class PBGameSession;
@class PBGameSession_Builder;
@class PBGameUser;
@class PBGameUser_Builder;
@class PBMessage;
@class PBMessageStat;
@class PBMessageStat_Builder;
@class PBMessage_Builder;
@class PBSNSUser;
@class PBSNSUser_Builder;

@interface GameBasicRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface PBSNSUser : PBGeneratedMessage {
@private
  BOOL hasType_:1;
  BOOL hasUserId_:1;
  BOOL hasNickName_:1;
  int32_t type;
  NSString* userId;
  NSString* nickName;
}
- (BOOL) hasType;
- (BOOL) hasUserId;
- (BOOL) hasNickName;
@property (readonly) int32_t type;
@property (readonly, retain) NSString* userId;
@property (readonly, retain) NSString* nickName;

+ (PBSNSUser*) defaultInstance;
- (PBSNSUser*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (PBSNSUser_Builder*) builder;
+ (PBSNSUser_Builder*) builder;
+ (PBSNSUser_Builder*) builderWithPrototype:(PBSNSUser*) prototype;

+ (PBSNSUser*) parseFromData:(NSData*) data;
+ (PBSNSUser*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PBSNSUser*) parseFromInputStream:(NSInputStream*) input;
+ (PBSNSUser*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PBSNSUser*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (PBSNSUser*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface PBSNSUser_Builder : PBGeneratedMessage_Builder {
@private
  PBSNSUser* result;
}

- (PBSNSUser*) defaultInstance;

- (PBSNSUser_Builder*) clear;
- (PBSNSUser_Builder*) clone;

- (PBSNSUser*) build;
- (PBSNSUser*) buildPartial;

- (PBSNSUser_Builder*) mergeFrom:(PBSNSUser*) other;
- (PBSNSUser_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (PBSNSUser_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasType;
- (int32_t) type;
- (PBSNSUser_Builder*) setType:(int32_t) value;
- (PBSNSUser_Builder*) clearType;

- (BOOL) hasUserId;
- (NSString*) userId;
- (PBSNSUser_Builder*) setUserId:(NSString*) value;
- (PBSNSUser_Builder*) clearUserId;

- (BOOL) hasNickName;
- (NSString*) nickName;
- (PBSNSUser_Builder*) setNickName:(NSString*) value;
- (PBSNSUser_Builder*) clearNickName;
@end

@interface PBGameUser : PBGeneratedMessage {
@private
  BOOL hasGender_:1;
  BOOL hasUserLevel_:1;
  BOOL hasUserId_:1;
  BOOL hasNickName_:1;
  BOOL hasAvatar_:1;
  BOOL hasLocation_:1;
  BOOL gender_:1;
  int32_t userLevel;
  NSString* userId;
  NSString* nickName;
  NSString* avatar;
  NSString* location;
  NSMutableArray* mutableSnsUsersList;
}
- (BOOL) hasUserId;
- (BOOL) hasNickName;
- (BOOL) hasAvatar;
- (BOOL) hasGender;
- (BOOL) hasLocation;
- (BOOL) hasUserLevel;
@property (readonly, retain) NSString* userId;
@property (readonly, retain) NSString* nickName;
@property (readonly, retain) NSString* avatar;
- (BOOL) gender;
@property (readonly, retain) NSString* location;
@property (readonly) int32_t userLevel;
- (NSArray*) snsUsersList;
- (PBSNSUser*) snsUsersAtIndex:(int32_t) index;

+ (PBGameUser*) defaultInstance;
- (PBGameUser*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (PBGameUser_Builder*) builder;
+ (PBGameUser_Builder*) builder;
+ (PBGameUser_Builder*) builderWithPrototype:(PBGameUser*) prototype;

+ (PBGameUser*) parseFromData:(NSData*) data;
+ (PBGameUser*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PBGameUser*) parseFromInputStream:(NSInputStream*) input;
+ (PBGameUser*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PBGameUser*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (PBGameUser*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface PBGameUser_Builder : PBGeneratedMessage_Builder {
@private
  PBGameUser* result;
}

- (PBGameUser*) defaultInstance;

- (PBGameUser_Builder*) clear;
- (PBGameUser_Builder*) clone;

- (PBGameUser*) build;
- (PBGameUser*) buildPartial;

- (PBGameUser_Builder*) mergeFrom:(PBGameUser*) other;
- (PBGameUser_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (PBGameUser_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasUserId;
- (NSString*) userId;
- (PBGameUser_Builder*) setUserId:(NSString*) value;
- (PBGameUser_Builder*) clearUserId;

- (BOOL) hasNickName;
- (NSString*) nickName;
- (PBGameUser_Builder*) setNickName:(NSString*) value;
- (PBGameUser_Builder*) clearNickName;

- (BOOL) hasAvatar;
- (NSString*) avatar;
- (PBGameUser_Builder*) setAvatar:(NSString*) value;
- (PBGameUser_Builder*) clearAvatar;

- (BOOL) hasGender;
- (BOOL) gender;
- (PBGameUser_Builder*) setGender:(BOOL) value;
- (PBGameUser_Builder*) clearGender;

- (NSArray*) snsUsersList;
- (PBSNSUser*) snsUsersAtIndex:(int32_t) index;
- (PBGameUser_Builder*) replaceSnsUsersAtIndex:(int32_t) index with:(PBSNSUser*) value;
- (PBGameUser_Builder*) addSnsUsers:(PBSNSUser*) value;
- (PBGameUser_Builder*) addAllSnsUsers:(NSArray*) values;
- (PBGameUser_Builder*) clearSnsUsersList;

- (BOOL) hasLocation;
- (NSString*) location;
- (PBGameUser_Builder*) setLocation:(NSString*) value;
- (PBGameUser_Builder*) clearLocation;

- (BOOL) hasUserLevel;
- (int32_t) userLevel;
- (PBGameUser_Builder*) setUserLevel:(int32_t) value;
- (PBGameUser_Builder*) clearUserLevel;
@end

@interface PBGameSession : PBGeneratedMessage {
@private
  BOOL hasSessionId_:1;
  BOOL hasCreateTime_:1;
  BOOL hasStatus_:1;
  BOOL hasGameId_:1;
  BOOL hasName_:1;
  BOOL hasCreateBy_:1;
  BOOL hasHost_:1;
  BOOL hasCurrentPlayUserId_:1;
  BOOL hasNextPlayUserId_:1;
  int64_t sessionId;
  int32_t createTime;
  int32_t status;
  NSString* gameId;
  NSString* name;
  NSString* createBy;
  NSString* host;
  NSString* currentPlayUserId;
  NSString* nextPlayUserId;
  NSMutableArray* mutableUsersList;
}
- (BOOL) hasGameId;
- (BOOL) hasSessionId;
- (BOOL) hasName;
- (BOOL) hasCreateBy;
- (BOOL) hasCreateTime;
- (BOOL) hasHost;
- (BOOL) hasStatus;
- (BOOL) hasCurrentPlayUserId;
- (BOOL) hasNextPlayUserId;
@property (readonly, retain) NSString* gameId;
@property (readonly) int64_t sessionId;
@property (readonly, retain) NSString* name;
@property (readonly, retain) NSString* createBy;
@property (readonly) int32_t createTime;
@property (readonly, retain) NSString* host;
@property (readonly) int32_t status;
@property (readonly, retain) NSString* currentPlayUserId;
@property (readonly, retain) NSString* nextPlayUserId;
- (NSArray*) usersList;
- (PBGameUser*) usersAtIndex:(int32_t) index;

+ (PBGameSession*) defaultInstance;
- (PBGameSession*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (PBGameSession_Builder*) builder;
+ (PBGameSession_Builder*) builder;
+ (PBGameSession_Builder*) builderWithPrototype:(PBGameSession*) prototype;

+ (PBGameSession*) parseFromData:(NSData*) data;
+ (PBGameSession*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PBGameSession*) parseFromInputStream:(NSInputStream*) input;
+ (PBGameSession*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PBGameSession*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (PBGameSession*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface PBGameSession_Builder : PBGeneratedMessage_Builder {
@private
  PBGameSession* result;
}

- (PBGameSession*) defaultInstance;

- (PBGameSession_Builder*) clear;
- (PBGameSession_Builder*) clone;

- (PBGameSession*) build;
- (PBGameSession*) buildPartial;

- (PBGameSession_Builder*) mergeFrom:(PBGameSession*) other;
- (PBGameSession_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (PBGameSession_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasGameId;
- (NSString*) gameId;
- (PBGameSession_Builder*) setGameId:(NSString*) value;
- (PBGameSession_Builder*) clearGameId;

- (BOOL) hasSessionId;
- (int64_t) sessionId;
- (PBGameSession_Builder*) setSessionId:(int64_t) value;
- (PBGameSession_Builder*) clearSessionId;

- (BOOL) hasName;
- (NSString*) name;
- (PBGameSession_Builder*) setName:(NSString*) value;
- (PBGameSession_Builder*) clearName;

- (BOOL) hasCreateBy;
- (NSString*) createBy;
- (PBGameSession_Builder*) setCreateBy:(NSString*) value;
- (PBGameSession_Builder*) clearCreateBy;

- (BOOL) hasCreateTime;
- (int32_t) createTime;
- (PBGameSession_Builder*) setCreateTime:(int32_t) value;
- (PBGameSession_Builder*) clearCreateTime;

- (BOOL) hasHost;
- (NSString*) host;
- (PBGameSession_Builder*) setHost:(NSString*) value;
- (PBGameSession_Builder*) clearHost;

- (BOOL) hasStatus;
- (int32_t) status;
- (PBGameSession_Builder*) setStatus:(int32_t) value;
- (PBGameSession_Builder*) clearStatus;

- (BOOL) hasCurrentPlayUserId;
- (NSString*) currentPlayUserId;
- (PBGameSession_Builder*) setCurrentPlayUserId:(NSString*) value;
- (PBGameSession_Builder*) clearCurrentPlayUserId;

- (BOOL) hasNextPlayUserId;
- (NSString*) nextPlayUserId;
- (PBGameSession_Builder*) setNextPlayUserId:(NSString*) value;
- (PBGameSession_Builder*) clearNextPlayUserId;

- (NSArray*) usersList;
- (PBGameUser*) usersAtIndex:(int32_t) index;
- (PBGameSession_Builder*) replaceUsersAtIndex:(int32_t) index with:(PBGameUser*) value;
- (PBGameSession_Builder*) addUsers:(PBGameUser*) value;
- (PBGameSession_Builder*) addAllUsers:(NSArray*) values;
- (PBGameSession_Builder*) clearUsersList;
@end

@interface PBDrawAction : PBGeneratedMessage {
@private
  BOOL hasWidth_:1;
  BOOL hasType_:1;
  BOOL hasColor_:1;
  BOOL hasPenType_:1;
  Float32 width;
  int32_t type;
  int32_t color;
  int32_t penType;
  NSMutableArray* mutablePointsList;
  int32_t pointsMemoizedSerializedSize;
}
- (BOOL) hasType;
- (BOOL) hasWidth;
- (BOOL) hasColor;
- (BOOL) hasPenType;
@property (readonly) int32_t type;
@property (readonly) Float32 width;
@property (readonly) int32_t color;
@property (readonly) int32_t penType;
- (NSArray*) pointsList;
- (int32_t) pointsAtIndex:(int32_t) index;

+ (PBDrawAction*) defaultInstance;
- (PBDrawAction*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (PBDrawAction_Builder*) builder;
+ (PBDrawAction_Builder*) builder;
+ (PBDrawAction_Builder*) builderWithPrototype:(PBDrawAction*) prototype;

+ (PBDrawAction*) parseFromData:(NSData*) data;
+ (PBDrawAction*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PBDrawAction*) parseFromInputStream:(NSInputStream*) input;
+ (PBDrawAction*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PBDrawAction*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (PBDrawAction*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface PBDrawAction_Builder : PBGeneratedMessage_Builder {
@private
  PBDrawAction* result;
}

- (PBDrawAction*) defaultInstance;

- (PBDrawAction_Builder*) clear;
- (PBDrawAction_Builder*) clone;

- (PBDrawAction*) build;
- (PBDrawAction*) buildPartial;

- (PBDrawAction_Builder*) mergeFrom:(PBDrawAction*) other;
- (PBDrawAction_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (PBDrawAction_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasType;
- (int32_t) type;
- (PBDrawAction_Builder*) setType:(int32_t) value;
- (PBDrawAction_Builder*) clearType;

- (NSArray*) pointsList;
- (int32_t) pointsAtIndex:(int32_t) index;
- (PBDrawAction_Builder*) replacePointsAtIndex:(int32_t) index with:(int32_t) value;
- (PBDrawAction_Builder*) addPoints:(int32_t) value;
- (PBDrawAction_Builder*) addAllPoints:(NSArray*) values;
- (PBDrawAction_Builder*) clearPointsList;

- (BOOL) hasWidth;
- (Float32) width;
- (PBDrawAction_Builder*) setWidth:(Float32) value;
- (PBDrawAction_Builder*) clearWidth;

- (BOOL) hasColor;
- (int32_t) color;
- (PBDrawAction_Builder*) setColor:(int32_t) value;
- (PBDrawAction_Builder*) clearColor;

- (BOOL) hasPenType;
- (int32_t) penType;
- (PBDrawAction_Builder*) setPenType:(int32_t) value;
- (PBDrawAction_Builder*) clearPenType;
@end

@interface PBDraw : PBGeneratedMessage {
@private
  BOOL hasGender_:1;
  BOOL hasLevel_:1;
  BOOL hasLanguage_:1;
  BOOL hasCreateDate_:1;
  BOOL hasUserId_:1;
  BOOL hasWord_:1;
  BOOL hasNickName_:1;
  BOOL hasAvatar_:1;
  BOOL hasOpusId_:1;
  BOOL gender_:1;
  int32_t level;
  int32_t language;
  int32_t createDate;
  NSString* userId;
  NSString* word;
  NSString* nickName;
  NSString* avatar;
  NSString* opusId;
  NSMutableArray* mutableDrawDataList;
}
- (BOOL) hasUserId;
- (BOOL) hasWord;
- (BOOL) hasLevel;
- (BOOL) hasLanguage;
- (BOOL) hasCreateDate;
- (BOOL) hasNickName;
- (BOOL) hasAvatar;
- (BOOL) hasGender;
- (BOOL) hasOpusId;
@property (readonly, retain) NSString* userId;
@property (readonly, retain) NSString* word;
@property (readonly) int32_t level;
@property (readonly) int32_t language;
@property (readonly) int32_t createDate;
@property (readonly, retain) NSString* nickName;
@property (readonly, retain) NSString* avatar;
- (BOOL) gender;
@property (readonly, retain) NSString* opusId;
- (NSArray*) drawDataList;
- (PBDrawAction*) drawDataAtIndex:(int32_t) index;

+ (PBDraw*) defaultInstance;
- (PBDraw*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (PBDraw_Builder*) builder;
+ (PBDraw_Builder*) builder;
+ (PBDraw_Builder*) builderWithPrototype:(PBDraw*) prototype;

+ (PBDraw*) parseFromData:(NSData*) data;
+ (PBDraw*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PBDraw*) parseFromInputStream:(NSInputStream*) input;
+ (PBDraw*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PBDraw*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (PBDraw*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface PBDraw_Builder : PBGeneratedMessage_Builder {
@private
  PBDraw* result;
}

- (PBDraw*) defaultInstance;

- (PBDraw_Builder*) clear;
- (PBDraw_Builder*) clone;

- (PBDraw*) build;
- (PBDraw*) buildPartial;

- (PBDraw_Builder*) mergeFrom:(PBDraw*) other;
- (PBDraw_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (PBDraw_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasUserId;
- (NSString*) userId;
- (PBDraw_Builder*) setUserId:(NSString*) value;
- (PBDraw_Builder*) clearUserId;

- (BOOL) hasWord;
- (NSString*) word;
- (PBDraw_Builder*) setWord:(NSString*) value;
- (PBDraw_Builder*) clearWord;

- (BOOL) hasLevel;
- (int32_t) level;
- (PBDraw_Builder*) setLevel:(int32_t) value;
- (PBDraw_Builder*) clearLevel;

- (BOOL) hasLanguage;
- (int32_t) language;
- (PBDraw_Builder*) setLanguage:(int32_t) value;
- (PBDraw_Builder*) clearLanguage;

- (BOOL) hasCreateDate;
- (int32_t) createDate;
- (PBDraw_Builder*) setCreateDate:(int32_t) value;
- (PBDraw_Builder*) clearCreateDate;

- (BOOL) hasNickName;
- (NSString*) nickName;
- (PBDraw_Builder*) setNickName:(NSString*) value;
- (PBDraw_Builder*) clearNickName;

- (BOOL) hasAvatar;
- (NSString*) avatar;
- (PBDraw_Builder*) setAvatar:(NSString*) value;
- (PBDraw_Builder*) clearAvatar;

- (BOOL) hasGender;
- (BOOL) gender;
- (PBDraw_Builder*) setGender:(BOOL) value;
- (PBDraw_Builder*) clearGender;

- (NSArray*) drawDataList;
- (PBDrawAction*) drawDataAtIndex:(int32_t) index;
- (PBDraw_Builder*) replaceDrawDataAtIndex:(int32_t) index with:(PBDrawAction*) value;
- (PBDraw_Builder*) addDrawData:(PBDrawAction*) value;
- (PBDraw_Builder*) addAllDrawData:(NSArray*) values;
- (PBDraw_Builder*) clearDrawDataList;

- (BOOL) hasOpusId;
- (NSString*) opusId;
- (PBDraw_Builder*) setOpusId:(NSString*) value;
- (PBDraw_Builder*) clearOpusId;
@end

@interface PBMessage : PBGeneratedMessage {
@private
  BOOL hasStatus_:1;
  BOOL hasCreateDate_:1;
  BOOL hasMessageId_:1;
  BOOL hasFrom_:1;
  BOOL hasTo_:1;
  BOOL hasText_:1;
  int32_t status;
  int32_t createDate;
  NSString* messageId;
  NSString* from;
  NSString* to;
  NSString* text;
  NSMutableArray* mutableDrawDataList;
}
- (BOOL) hasMessageId;
- (BOOL) hasFrom;
- (BOOL) hasTo;
- (BOOL) hasStatus;
- (BOOL) hasText;
- (BOOL) hasCreateDate;
@property (readonly, retain) NSString* messageId;
@property (readonly, retain) NSString* from;
@property (readonly, retain) NSString* to;
@property (readonly) int32_t status;
@property (readonly, retain) NSString* text;
@property (readonly) int32_t createDate;
- (NSArray*) drawDataList;
- (PBDrawAction*) drawDataAtIndex:(int32_t) index;

+ (PBMessage*) defaultInstance;
- (PBMessage*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (PBMessage_Builder*) builder;
+ (PBMessage_Builder*) builder;
+ (PBMessage_Builder*) builderWithPrototype:(PBMessage*) prototype;

+ (PBMessage*) parseFromData:(NSData*) data;
+ (PBMessage*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PBMessage*) parseFromInputStream:(NSInputStream*) input;
+ (PBMessage*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PBMessage*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (PBMessage*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface PBMessage_Builder : PBGeneratedMessage_Builder {
@private
  PBMessage* result;
}

- (PBMessage*) defaultInstance;

- (PBMessage_Builder*) clear;
- (PBMessage_Builder*) clone;

- (PBMessage*) build;
- (PBMessage*) buildPartial;

- (PBMessage_Builder*) mergeFrom:(PBMessage*) other;
- (PBMessage_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (PBMessage_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasMessageId;
- (NSString*) messageId;
- (PBMessage_Builder*) setMessageId:(NSString*) value;
- (PBMessage_Builder*) clearMessageId;

- (BOOL) hasFrom;
- (NSString*) from;
- (PBMessage_Builder*) setFrom:(NSString*) value;
- (PBMessage_Builder*) clearFrom;

- (BOOL) hasTo;
- (NSString*) to;
- (PBMessage_Builder*) setTo:(NSString*) value;
- (PBMessage_Builder*) clearTo;

- (BOOL) hasStatus;
- (int32_t) status;
- (PBMessage_Builder*) setStatus:(int32_t) value;
- (PBMessage_Builder*) clearStatus;

- (BOOL) hasText;
- (NSString*) text;
- (PBMessage_Builder*) setText:(NSString*) value;
- (PBMessage_Builder*) clearText;

- (NSArray*) drawDataList;
- (PBDrawAction*) drawDataAtIndex:(int32_t) index;
- (PBMessage_Builder*) replaceDrawDataAtIndex:(int32_t) index with:(PBDrawAction*) value;
- (PBMessage_Builder*) addDrawData:(PBDrawAction*) value;
- (PBMessage_Builder*) addAllDrawData:(NSArray*) values;
- (PBMessage_Builder*) clearDrawDataList;

- (BOOL) hasCreateDate;
- (int32_t) createDate;
- (PBMessage_Builder*) setCreateDate:(int32_t) value;
- (PBMessage_Builder*) clearCreateDate;
@end

@interface PBMessageStat : PBGeneratedMessage {
@private
  BOOL hasFriendGender_:1;
  BOOL hasCreateDate_:1;
  BOOL hasModifiedDate_:1;
  BOOL hasTotalMessageCount_:1;
  BOOL hasNewMessageCount_:1;
  BOOL hasUserId_:1;
  BOOL hasFriendUserId_:1;
  BOOL hasFriendNickName_:1;
  BOOL hasFriendAvatar_:1;
  BOOL hasMessageId_:1;
  BOOL hasFrom_:1;
  BOOL hasTo_:1;
  BOOL hasText_:1;
  BOOL friendGender_:1;
  int32_t createDate;
  int32_t modifiedDate;
  int32_t totalMessageCount;
  int32_t newMessageCount;
  NSString* userId;
  NSString* friendUserId;
  NSString* friendNickName;
  NSString* friendAvatar;
  NSString* messageId;
  NSString* from;
  NSString* to;
  NSString* text;
  NSMutableArray* mutableDrawDataList;
}
- (BOOL) hasUserId;
- (BOOL) hasFriendUserId;
- (BOOL) hasFriendNickName;
- (BOOL) hasFriendAvatar;
- (BOOL) hasFriendGender;
- (BOOL) hasMessageId;
- (BOOL) hasFrom;
- (BOOL) hasTo;
- (BOOL) hasText;
- (BOOL) hasCreateDate;
- (BOOL) hasModifiedDate;
- (BOOL) hasTotalMessageCount;
- (BOOL) hasNewMessageCount;
@property (readonly, retain) NSString* userId;
@property (readonly, retain) NSString* friendUserId;
@property (readonly, retain) NSString* friendNickName;
@property (readonly, retain) NSString* friendAvatar;
- (BOOL) friendGender;
@property (readonly, retain) NSString* messageId;
@property (readonly, retain) NSString* from;
@property (readonly, retain) NSString* to;
@property (readonly, retain) NSString* text;
@property (readonly) int32_t createDate;
@property (readonly) int32_t modifiedDate;
@property (readonly) int32_t totalMessageCount;
@property (readonly) int32_t newMessageCount;
- (NSArray*) drawDataList;
- (PBDrawAction*) drawDataAtIndex:(int32_t) index;

+ (PBMessageStat*) defaultInstance;
- (PBMessageStat*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (PBMessageStat_Builder*) builder;
+ (PBMessageStat_Builder*) builder;
+ (PBMessageStat_Builder*) builderWithPrototype:(PBMessageStat*) prototype;

+ (PBMessageStat*) parseFromData:(NSData*) data;
+ (PBMessageStat*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PBMessageStat*) parseFromInputStream:(NSInputStream*) input;
+ (PBMessageStat*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PBMessageStat*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (PBMessageStat*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface PBMessageStat_Builder : PBGeneratedMessage_Builder {
@private
  PBMessageStat* result;
}

- (PBMessageStat*) defaultInstance;

- (PBMessageStat_Builder*) clear;
- (PBMessageStat_Builder*) clone;

- (PBMessageStat*) build;
- (PBMessageStat*) buildPartial;

- (PBMessageStat_Builder*) mergeFrom:(PBMessageStat*) other;
- (PBMessageStat_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (PBMessageStat_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasUserId;
- (NSString*) userId;
- (PBMessageStat_Builder*) setUserId:(NSString*) value;
- (PBMessageStat_Builder*) clearUserId;

- (BOOL) hasFriendUserId;
- (NSString*) friendUserId;
- (PBMessageStat_Builder*) setFriendUserId:(NSString*) value;
- (PBMessageStat_Builder*) clearFriendUserId;

- (BOOL) hasFriendNickName;
- (NSString*) friendNickName;
- (PBMessageStat_Builder*) setFriendNickName:(NSString*) value;
- (PBMessageStat_Builder*) clearFriendNickName;

- (BOOL) hasFriendAvatar;
- (NSString*) friendAvatar;
- (PBMessageStat_Builder*) setFriendAvatar:(NSString*) value;
- (PBMessageStat_Builder*) clearFriendAvatar;

- (BOOL) hasFriendGender;
- (BOOL) friendGender;
- (PBMessageStat_Builder*) setFriendGender:(BOOL) value;
- (PBMessageStat_Builder*) clearFriendGender;

- (BOOL) hasMessageId;
- (NSString*) messageId;
- (PBMessageStat_Builder*) setMessageId:(NSString*) value;
- (PBMessageStat_Builder*) clearMessageId;

- (BOOL) hasFrom;
- (NSString*) from;
- (PBMessageStat_Builder*) setFrom:(NSString*) value;
- (PBMessageStat_Builder*) clearFrom;

- (BOOL) hasTo;
- (NSString*) to;
- (PBMessageStat_Builder*) setTo:(NSString*) value;
- (PBMessageStat_Builder*) clearTo;

- (BOOL) hasText;
- (NSString*) text;
- (PBMessageStat_Builder*) setText:(NSString*) value;
- (PBMessageStat_Builder*) clearText;

- (NSArray*) drawDataList;
- (PBDrawAction*) drawDataAtIndex:(int32_t) index;
- (PBMessageStat_Builder*) replaceDrawDataAtIndex:(int32_t) index with:(PBDrawAction*) value;
- (PBMessageStat_Builder*) addDrawData:(PBDrawAction*) value;
- (PBMessageStat_Builder*) addAllDrawData:(NSArray*) values;
- (PBMessageStat_Builder*) clearDrawDataList;

- (BOOL) hasCreateDate;
- (int32_t) createDate;
- (PBMessageStat_Builder*) setCreateDate:(int32_t) value;
- (PBMessageStat_Builder*) clearCreateDate;

- (BOOL) hasModifiedDate;
- (int32_t) modifiedDate;
- (PBMessageStat_Builder*) setModifiedDate:(int32_t) value;
- (PBMessageStat_Builder*) clearModifiedDate;

- (BOOL) hasTotalMessageCount;
- (int32_t) totalMessageCount;
- (PBMessageStat_Builder*) setTotalMessageCount:(int32_t) value;
- (PBMessageStat_Builder*) clearTotalMessageCount;

- (BOOL) hasNewMessageCount;
- (int32_t) newMessageCount;
- (PBMessageStat_Builder*) setNewMessageCount:(int32_t) value;
- (PBMessageStat_Builder*) clearNewMessageCount;
@end

@interface PBFeed : PBGeneratedMessage {
@private
  BOOL hasGender_:1;
  BOOL hasIsCorrect_:1;
  BOOL hasCommentTimes_:1;
  BOOL hasGuessTimes_:1;
  BOOL hasActionType_:1;
  BOOL hasCreateDate_:1;
  BOOL hasCorrectTimes_:1;
  BOOL hasMatchTimes_:1;
  BOOL hasScore_:1;
  BOOL hasComment_:1;
  BOOL hasOpusId_:1;
  BOOL hasAvatar_:1;
  BOOL hasNickName_:1;
  BOOL hasUserId_:1;
  BOOL hasFeedId_:1;
  BOOL hasDrawData_:1;
  BOOL gender_:1;
  BOOL isCorrect_:1;
  int32_t commentTimes;
  int32_t guessTimes;
  int32_t actionType;
  int32_t createDate;
  int32_t correctTimes;
  int32_t matchTimes;
  int32_t score;
  NSString* comment;
  NSString* opusId;
  NSString* avatar;
  NSString* nickName;
  NSString* userId;
  NSString* feedId;
  PBDraw* drawData;
  NSMutableArray* mutableGuessWordsList;
}
- (BOOL) hasFeedId;
- (BOOL) hasUserId;
- (BOOL) hasActionType;
- (BOOL) hasCreateDate;
- (BOOL) hasNickName;
- (BOOL) hasAvatar;
- (BOOL) hasGender;
- (BOOL) hasDrawData;
- (BOOL) hasOpusId;
- (BOOL) hasIsCorrect;
- (BOOL) hasScore;
- (BOOL) hasComment;
- (BOOL) hasMatchTimes;
- (BOOL) hasCorrectTimes;
- (BOOL) hasGuessTimes;
- (BOOL) hasCommentTimes;
@property (readonly, retain) NSString* feedId;
@property (readonly, retain) NSString* userId;
@property (readonly) int32_t actionType;
@property (readonly) int32_t createDate;
@property (readonly, retain) NSString* nickName;
@property (readonly, retain) NSString* avatar;
- (BOOL) gender;
@property (readonly, retain) PBDraw* drawData;
@property (readonly, retain) NSString* opusId;
- (BOOL) isCorrect;
@property (readonly) int32_t score;
@property (readonly, retain) NSString* comment;
@property (readonly) int32_t matchTimes;
@property (readonly) int32_t correctTimes;
@property (readonly) int32_t guessTimes;
@property (readonly) int32_t commentTimes;
- (NSArray*) guessWordsList;
- (NSString*) guessWordsAtIndex:(int32_t) index;

+ (PBFeed*) defaultInstance;
- (PBFeed*) defaultInstance;

- (BOOL) isInitialized;
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output;
- (PBFeed_Builder*) builder;
+ (PBFeed_Builder*) builder;
+ (PBFeed_Builder*) builderWithPrototype:(PBFeed*) prototype;

+ (PBFeed*) parseFromData:(NSData*) data;
+ (PBFeed*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PBFeed*) parseFromInputStream:(NSInputStream*) input;
+ (PBFeed*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
+ (PBFeed*) parseFromCodedInputStream:(PBCodedInputStream*) input;
+ (PBFeed*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;
@end

@interface PBFeed_Builder : PBGeneratedMessage_Builder {
@private
  PBFeed* result;
}

- (PBFeed*) defaultInstance;

- (PBFeed_Builder*) clear;
- (PBFeed_Builder*) clone;

- (PBFeed*) build;
- (PBFeed*) buildPartial;

- (PBFeed_Builder*) mergeFrom:(PBFeed*) other;
- (PBFeed_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input;
- (PBFeed_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry;

- (BOOL) hasFeedId;
- (NSString*) feedId;
- (PBFeed_Builder*) setFeedId:(NSString*) value;
- (PBFeed_Builder*) clearFeedId;

- (BOOL) hasUserId;
- (NSString*) userId;
- (PBFeed_Builder*) setUserId:(NSString*) value;
- (PBFeed_Builder*) clearUserId;

- (BOOL) hasActionType;
- (int32_t) actionType;
- (PBFeed_Builder*) setActionType:(int32_t) value;
- (PBFeed_Builder*) clearActionType;

- (BOOL) hasCreateDate;
- (int32_t) createDate;
- (PBFeed_Builder*) setCreateDate:(int32_t) value;
- (PBFeed_Builder*) clearCreateDate;

- (BOOL) hasNickName;
- (NSString*) nickName;
- (PBFeed_Builder*) setNickName:(NSString*) value;
- (PBFeed_Builder*) clearNickName;

- (BOOL) hasAvatar;
- (NSString*) avatar;
- (PBFeed_Builder*) setAvatar:(NSString*) value;
- (PBFeed_Builder*) clearAvatar;

- (BOOL) hasGender;
- (BOOL) gender;
- (PBFeed_Builder*) setGender:(BOOL) value;
- (PBFeed_Builder*) clearGender;

- (BOOL) hasDrawData;
- (PBDraw*) drawData;
- (PBFeed_Builder*) setDrawData:(PBDraw*) value;
- (PBFeed_Builder*) setDrawDataBuilder:(PBDraw_Builder*) builderForValue;
- (PBFeed_Builder*) mergeDrawData:(PBDraw*) value;
- (PBFeed_Builder*) clearDrawData;

- (BOOL) hasOpusId;
- (NSString*) opusId;
- (PBFeed_Builder*) setOpusId:(NSString*) value;
- (PBFeed_Builder*) clearOpusId;

- (BOOL) hasIsCorrect;
- (BOOL) isCorrect;
- (PBFeed_Builder*) setIsCorrect:(BOOL) value;
- (PBFeed_Builder*) clearIsCorrect;

- (BOOL) hasScore;
- (int32_t) score;
- (PBFeed_Builder*) setScore:(int32_t) value;
- (PBFeed_Builder*) clearScore;

- (NSArray*) guessWordsList;
- (NSString*) guessWordsAtIndex:(int32_t) index;
- (PBFeed_Builder*) replaceGuessWordsAtIndex:(int32_t) index with:(NSString*) value;
- (PBFeed_Builder*) addGuessWords:(NSString*) value;
- (PBFeed_Builder*) addAllGuessWords:(NSArray*) values;
- (PBFeed_Builder*) clearGuessWordsList;

- (BOOL) hasComment;
- (NSString*) comment;
- (PBFeed_Builder*) setComment:(NSString*) value;
- (PBFeed_Builder*) clearComment;

- (BOOL) hasMatchTimes;
- (int32_t) matchTimes;
- (PBFeed_Builder*) setMatchTimes:(int32_t) value;
- (PBFeed_Builder*) clearMatchTimes;

- (BOOL) hasCorrectTimes;
- (int32_t) correctTimes;
- (PBFeed_Builder*) setCorrectTimes:(int32_t) value;
- (PBFeed_Builder*) clearCorrectTimes;

- (BOOL) hasGuessTimes;
- (int32_t) guessTimes;
- (PBFeed_Builder*) setGuessTimes:(int32_t) value;
- (PBFeed_Builder*) clearGuessTimes;

- (BOOL) hasCommentTimes;
- (int32_t) commentTimes;
- (PBFeed_Builder*) setCommentTimes:(int32_t) value;
- (PBFeed_Builder*) clearCommentTimes;
@end

