// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "ProtocolBuffers.h"

@class PBDraw;
@class PBDrawAction;
@class PBDrawAction_Builder;
@class PBDraw_Builder;
@class PBGameSession;
@class PBGameSession_Builder;
@class PBGameUser;
@class PBGameUser_Builder;

@interface GameBasicRoot : NSObject {
}
+ (PBExtensionRegistry*) extensionRegistry;
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry;
@end

@interface PBGameUser : PBGeneratedMessage {
@private
  BOOL hasGender_:1;
  BOOL hasUserId_:1;
  BOOL hasNickName_:1;
  BOOL hasAvatar_:1;
  BOOL gender_:1;
  NSString* userId;
  NSString* nickName;
  NSString* avatar;
}
- (BOOL) hasUserId;
- (BOOL) hasNickName;
- (BOOL) hasAvatar;
- (BOOL) hasGender;
@property (readonly, retain) NSString* userId;
@property (readonly, retain) NSString* nickName;
@property (readonly, retain) NSString* avatar;
- (BOOL) gender;

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
  Float32 width;
  int32_t type;
  int32_t color;
  NSMutableArray* mutablePointsList;
  int32_t pointsMemoizedSerializedSize;
}
- (BOOL) hasType;
- (BOOL) hasWidth;
- (BOOL) hasColor;
@property (readonly) int32_t type;
@property (readonly) Float32 width;
@property (readonly) int32_t color;
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
@end

@interface PBDraw : PBGeneratedMessage {
@private
  BOOL hasLevel_:1;
  BOOL hasLanguage_:1;
  BOOL hasCreateDate_:1;
  BOOL hasUserId_:1;
  BOOL hasWord_:1;
  BOOL hasNickName_:1;
  int32_t level;
  int32_t language;
  int32_t createDate;
  NSString* userId;
  NSString* word;
  NSString* nickName;
  NSMutableArray* mutableDrawDataList;
}
- (BOOL) hasUserId;
- (BOOL) hasWord;
- (BOOL) hasLevel;
- (BOOL) hasLanguage;
- (BOOL) hasCreateDate;
- (BOOL) hasNickName;
@property (readonly, retain) NSString* userId;
@property (readonly, retain) NSString* word;
@property (readonly) int32_t level;
@property (readonly) int32_t language;
@property (readonly) int32_t createDate;
@property (readonly, retain) NSString* nickName;
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

- (NSArray*) drawDataList;
- (PBDrawAction*) drawDataAtIndex:(int32_t) index;
- (PBDraw_Builder*) replaceDrawDataAtIndex:(int32_t) index with:(PBDrawAction*) value;
- (PBDraw_Builder*) addDrawData:(PBDrawAction*) value;
- (PBDraw_Builder*) addAllDrawData:(NSArray*) values;
- (PBDraw_Builder*) clearDrawDataList;
@end

