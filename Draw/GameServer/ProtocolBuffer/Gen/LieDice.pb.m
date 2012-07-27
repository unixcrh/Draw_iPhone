// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "LieDice.pb.h"

@implementation LieDiceRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [LieDiceRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    [GameBasicRoot registerAllExtensions:registry];
    extensionRegistry = [registry retain];
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface Dice ()
@property int32_t diceId;
@property int32_t dice;
@end

@implementation Dice

- (BOOL) hasDiceId {
  return !!hasDiceId_;
}
- (void) setHasDiceId:(BOOL) value {
  hasDiceId_ = !!value;
}
@synthesize diceId;
- (BOOL) hasDice {
  return !!hasDice_;
}
- (void) setHasDice:(BOOL) value {
  hasDice_ = !!value;
}
@synthesize dice;
- (void) dealloc {
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.diceId = 0;
    self.dice = 0;
  }
  return self;
}
static Dice* defaultDiceInstance = nil;
+ (void) initialize {
  if (self == [Dice class]) {
    defaultDiceInstance = [[Dice alloc] init];
  }
}
+ (Dice*) defaultInstance {
  return defaultDiceInstance;
}
- (Dice*) defaultInstance {
  return defaultDiceInstance;
}
- (BOOL) isInitialized {
  if (!self.hasDice) {
    return NO;
  }
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasDiceId) {
    [output writeInt32:1 value:self.diceId];
  }
  if (self.hasDice) {
    [output writeInt32:2 value:self.dice];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (int32_t) serializedSize {
  int32_t size = memoizedSerializedSize;
  if (size != -1) {
    return size;
  }

  size = 0;
  if (self.hasDiceId) {
    size += computeInt32Size(1, self.diceId);
  }
  if (self.hasDice) {
    size += computeInt32Size(2, self.dice);
  }
  size += self.unknownFields.serializedSize;
  memoizedSerializedSize = size;
  return size;
}
+ (Dice*) parseFromData:(NSData*) data {
  return (Dice*)[[[Dice builder] mergeFromData:data] build];
}
+ (Dice*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (Dice*)[[[Dice builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (Dice*) parseFromInputStream:(NSInputStream*) input {
  return (Dice*)[[[Dice builder] mergeFromInputStream:input] build];
}
+ (Dice*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (Dice*)[[[Dice builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (Dice*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (Dice*)[[[Dice builder] mergeFromCodedInputStream:input] build];
}
+ (Dice*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (Dice*)[[[Dice builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (Dice_Builder*) builder {
  return [[[Dice_Builder alloc] init] autorelease];
}
+ (Dice_Builder*) builderWithPrototype:(Dice*) prototype {
  return [[Dice builder] mergeFrom:prototype];
}
- (Dice_Builder*) builder {
  return [Dice builder];
}
@end

@interface Dice_Builder()
@property (retain) Dice* result;
@end

@implementation Dice_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[Dice alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (Dice_Builder*) clear {
  self.result = [[[Dice alloc] init] autorelease];
  return self;
}
- (Dice_Builder*) clone {
  return [Dice builderWithPrototype:result];
}
- (Dice*) defaultInstance {
  return [Dice defaultInstance];
}
- (Dice*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (Dice*) buildPartial {
  Dice* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (Dice_Builder*) mergeFrom:(Dice*) other {
  if (other == [Dice defaultInstance]) {
    return self;
  }
  if (other.hasDiceId) {
    [self setDiceId:other.diceId];
  }
  if (other.hasDice) {
    [self setDice:other.dice];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (Dice_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (Dice_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  PBUnknownFieldSet_Builder* unknownFields = [PBUnknownFieldSet builderWithUnknownFields:self.unknownFields];
  while (YES) {
    int32_t tag = [input readTag];
    switch (tag) {
      case 0:
        [self setUnknownFields:[unknownFields build]];
        return self;
      default: {
        if (![self parseUnknownField:input unknownFields:unknownFields extensionRegistry:extensionRegistry tag:tag]) {
          [self setUnknownFields:[unknownFields build]];
          return self;
        }
        break;
      }
      case 8: {
        [self setDiceId:[input readInt32]];
        break;
      }
      case 16: {
        [self setDice:[input readInt32]];
        break;
      }
    }
  }
}
- (BOOL) hasDiceId {
  return result.hasDiceId;
}
- (int32_t) diceId {
  return result.diceId;
}
- (Dice_Builder*) setDiceId:(int32_t) value {
  result.hasDiceId = YES;
  result.diceId = value;
  return self;
}
- (Dice_Builder*) clearDiceId {
  result.hasDiceId = NO;
  result.diceId = 0;
  return self;
}
- (BOOL) hasDice {
  return result.hasDice;
}
- (int32_t) dice {
  return result.dice;
}
- (Dice_Builder*) setDice:(int32_t) value {
  result.hasDice = YES;
  result.dice = value;
  return self;
}
- (Dice_Builder*) clearDice {
  result.hasDice = NO;
  result.dice = 0;
  return self;
}
@end

@interface UserDice ()
@property int32_t userId;
@property (retain) NSMutableArray* mutableDicesList;
@end

@implementation UserDice

- (BOOL) hasUserId {
  return !!hasUserId_;
}
- (void) setHasUserId:(BOOL) value {
  hasUserId_ = !!value;
}
@synthesize userId;
@synthesize mutableDicesList;
- (void) dealloc {
  self.mutableDicesList = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.userId = 0;
  }
  return self;
}
static UserDice* defaultUserDiceInstance = nil;
+ (void) initialize {
  if (self == [UserDice class]) {
    defaultUserDiceInstance = [[UserDice alloc] init];
  }
}
+ (UserDice*) defaultInstance {
  return defaultUserDiceInstance;
}
- (UserDice*) defaultInstance {
  return defaultUserDiceInstance;
}
- (NSArray*) dicesList {
  return mutableDicesList;
}
- (Dice*) dicesAtIndex:(int32_t) index {
  id value = [mutableDicesList objectAtIndex:index];
  return value;
}
- (BOOL) isInitialized {
  if (!self.hasUserId) {
    return NO;
  }
  for (Dice* element in self.dicesList) {
    if (!element.isInitialized) {
      return NO;
    }
  }
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasUserId) {
    [output writeInt32:1 value:self.userId];
  }
  for (Dice* element in self.dicesList) {
    [output writeMessage:2 value:element];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (int32_t) serializedSize {
  int32_t size = memoizedSerializedSize;
  if (size != -1) {
    return size;
  }

  size = 0;
  if (self.hasUserId) {
    size += computeInt32Size(1, self.userId);
  }
  for (Dice* element in self.dicesList) {
    size += computeMessageSize(2, element);
  }
  size += self.unknownFields.serializedSize;
  memoizedSerializedSize = size;
  return size;
}
+ (UserDice*) parseFromData:(NSData*) data {
  return (UserDice*)[[[UserDice builder] mergeFromData:data] build];
}
+ (UserDice*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (UserDice*)[[[UserDice builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (UserDice*) parseFromInputStream:(NSInputStream*) input {
  return (UserDice*)[[[UserDice builder] mergeFromInputStream:input] build];
}
+ (UserDice*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (UserDice*)[[[UserDice builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (UserDice*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (UserDice*)[[[UserDice builder] mergeFromCodedInputStream:input] build];
}
+ (UserDice*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (UserDice*)[[[UserDice builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (UserDice_Builder*) builder {
  return [[[UserDice_Builder alloc] init] autorelease];
}
+ (UserDice_Builder*) builderWithPrototype:(UserDice*) prototype {
  return [[UserDice builder] mergeFrom:prototype];
}
- (UserDice_Builder*) builder {
  return [UserDice builder];
}
@end

@interface UserDice_Builder()
@property (retain) UserDice* result;
@end

@implementation UserDice_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[UserDice alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (UserDice_Builder*) clear {
  self.result = [[[UserDice alloc] init] autorelease];
  return self;
}
- (UserDice_Builder*) clone {
  return [UserDice builderWithPrototype:result];
}
- (UserDice*) defaultInstance {
  return [UserDice defaultInstance];
}
- (UserDice*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (UserDice*) buildPartial {
  UserDice* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (UserDice_Builder*) mergeFrom:(UserDice*) other {
  if (other == [UserDice defaultInstance]) {
    return self;
  }
  if (other.hasUserId) {
    [self setUserId:other.userId];
  }
  if (other.mutableDicesList.count > 0) {
    if (result.mutableDicesList == nil) {
      result.mutableDicesList = [NSMutableArray array];
    }
    [result.mutableDicesList addObjectsFromArray:other.mutableDicesList];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (UserDice_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (UserDice_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  PBUnknownFieldSet_Builder* unknownFields = [PBUnknownFieldSet builderWithUnknownFields:self.unknownFields];
  while (YES) {
    int32_t tag = [input readTag];
    switch (tag) {
      case 0:
        [self setUnknownFields:[unknownFields build]];
        return self;
      default: {
        if (![self parseUnknownField:input unknownFields:unknownFields extensionRegistry:extensionRegistry tag:tag]) {
          [self setUnknownFields:[unknownFields build]];
          return self;
        }
        break;
      }
      case 8: {
        [self setUserId:[input readInt32]];
        break;
      }
      case 18: {
        Dice_Builder* subBuilder = [Dice builder];
        [input readMessage:subBuilder extensionRegistry:extensionRegistry];
        [self addDices:[subBuilder buildPartial]];
        break;
      }
    }
  }
}
- (BOOL) hasUserId {
  return result.hasUserId;
}
- (int32_t) userId {
  return result.userId;
}
- (UserDice_Builder*) setUserId:(int32_t) value {
  result.hasUserId = YES;
  result.userId = value;
  return self;
}
- (UserDice_Builder*) clearUserId {
  result.hasUserId = NO;
  result.userId = 0;
  return self;
}
- (NSArray*) dicesList {
  if (result.mutableDicesList == nil) { return [NSArray array]; }
  return result.mutableDicesList;
}
- (Dice*) dicesAtIndex:(int32_t) index {
  return [result dicesAtIndex:index];
}
- (UserDice_Builder*) replaceDicesAtIndex:(int32_t) index with:(Dice*) value {
  [result.mutableDicesList replaceObjectAtIndex:index withObject:value];
  return self;
}
- (UserDice_Builder*) addAllDices:(NSArray*) values {
  if (result.mutableDicesList == nil) {
    result.mutableDicesList = [NSMutableArray array];
  }
  [result.mutableDicesList addObjectsFromArray:values];
  return self;
}
- (UserDice_Builder*) clearDicesList {
  result.mutableDicesList = nil;
  return self;
}
- (UserDice_Builder*) addDices:(Dice*) value {
  if (result.mutableDicesList == nil) {
    result.mutableDicesList = [NSMutableArray array];
  }
  [result.mutableDicesList addObject:value];
  return self;
}
@end

@interface UserResult ()
@property (retain) NSString* userId;
@property BOOL win;
@property int32_t gainCoins;
@end

@implementation UserResult

- (BOOL) hasUserId {
  return !!hasUserId_;
}
- (void) setHasUserId:(BOOL) value {
  hasUserId_ = !!value;
}
@synthesize userId;
- (BOOL) hasWin {
  return !!hasWin_;
}
- (void) setHasWin:(BOOL) value {
  hasWin_ = !!value;
}
- (BOOL) win {
  return !!win_;
}
- (void) setWin:(BOOL) value {
  win_ = !!value;
}
- (BOOL) hasGainCoins {
  return !!hasGainCoins_;
}
- (void) setHasGainCoins:(BOOL) value {
  hasGainCoins_ = !!value;
}
@synthesize gainCoins;
- (void) dealloc {
  self.userId = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.userId = @"";
    self.win = NO;
    self.gainCoins = 0;
  }
  return self;
}
static UserResult* defaultUserResultInstance = nil;
+ (void) initialize {
  if (self == [UserResult class]) {
    defaultUserResultInstance = [[UserResult alloc] init];
  }
}
+ (UserResult*) defaultInstance {
  return defaultUserResultInstance;
}
- (UserResult*) defaultInstance {
  return defaultUserResultInstance;
}
- (BOOL) isInitialized {
  if (!self.hasUserId) {
    return NO;
  }
  if (!self.hasWin) {
    return NO;
  }
  if (!self.hasGainCoins) {
    return NO;
  }
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasUserId) {
    [output writeString:1 value:self.userId];
  }
  if (self.hasWin) {
    [output writeBool:2 value:self.win];
  }
  if (self.hasGainCoins) {
    [output writeInt32:5 value:self.gainCoins];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (int32_t) serializedSize {
  int32_t size = memoizedSerializedSize;
  if (size != -1) {
    return size;
  }

  size = 0;
  if (self.hasUserId) {
    size += computeStringSize(1, self.userId);
  }
  if (self.hasWin) {
    size += computeBoolSize(2, self.win);
  }
  if (self.hasGainCoins) {
    size += computeInt32Size(5, self.gainCoins);
  }
  size += self.unknownFields.serializedSize;
  memoizedSerializedSize = size;
  return size;
}
+ (UserResult*) parseFromData:(NSData*) data {
  return (UserResult*)[[[UserResult builder] mergeFromData:data] build];
}
+ (UserResult*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (UserResult*)[[[UserResult builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (UserResult*) parseFromInputStream:(NSInputStream*) input {
  return (UserResult*)[[[UserResult builder] mergeFromInputStream:input] build];
}
+ (UserResult*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (UserResult*)[[[UserResult builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (UserResult*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (UserResult*)[[[UserResult builder] mergeFromCodedInputStream:input] build];
}
+ (UserResult*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (UserResult*)[[[UserResult builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (UserResult_Builder*) builder {
  return [[[UserResult_Builder alloc] init] autorelease];
}
+ (UserResult_Builder*) builderWithPrototype:(UserResult*) prototype {
  return [[UserResult builder] mergeFrom:prototype];
}
- (UserResult_Builder*) builder {
  return [UserResult builder];
}
@end

@interface UserResult_Builder()
@property (retain) UserResult* result;
@end

@implementation UserResult_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[UserResult alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (UserResult_Builder*) clear {
  self.result = [[[UserResult alloc] init] autorelease];
  return self;
}
- (UserResult_Builder*) clone {
  return [UserResult builderWithPrototype:result];
}
- (UserResult*) defaultInstance {
  return [UserResult defaultInstance];
}
- (UserResult*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (UserResult*) buildPartial {
  UserResult* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (UserResult_Builder*) mergeFrom:(UserResult*) other {
  if (other == [UserResult defaultInstance]) {
    return self;
  }
  if (other.hasUserId) {
    [self setUserId:other.userId];
  }
  if (other.hasWin) {
    [self setWin:other.win];
  }
  if (other.hasGainCoins) {
    [self setGainCoins:other.gainCoins];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (UserResult_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (UserResult_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  PBUnknownFieldSet_Builder* unknownFields = [PBUnknownFieldSet builderWithUnknownFields:self.unknownFields];
  while (YES) {
    int32_t tag = [input readTag];
    switch (tag) {
      case 0:
        [self setUnknownFields:[unknownFields build]];
        return self;
      default: {
        if (![self parseUnknownField:input unknownFields:unknownFields extensionRegistry:extensionRegistry tag:tag]) {
          [self setUnknownFields:[unknownFields build]];
          return self;
        }
        break;
      }
      case 10: {
        [self setUserId:[input readString]];
        break;
      }
      case 16: {
        [self setWin:[input readBool]];
        break;
      }
      case 40: {
        [self setGainCoins:[input readInt32]];
        break;
      }
    }
  }
}
- (BOOL) hasUserId {
  return result.hasUserId;
}
- (NSString*) userId {
  return result.userId;
}
- (UserResult_Builder*) setUserId:(NSString*) value {
  result.hasUserId = YES;
  result.userId = value;
  return self;
}
- (UserResult_Builder*) clearUserId {
  result.hasUserId = NO;
  result.userId = @"";
  return self;
}
- (BOOL) hasWin {
  return result.hasWin;
}
- (BOOL) win {
  return result.win;
}
- (UserResult_Builder*) setWin:(BOOL) value {
  result.hasWin = YES;
  result.win = value;
  return self;
}
- (UserResult_Builder*) clearWin {
  result.hasWin = NO;
  result.win = NO;
  return self;
}
- (BOOL) hasGainCoins {
  return result.hasGainCoins;
}
- (int32_t) gainCoins {
  return result.gainCoins;
}
- (UserResult_Builder*) setGainCoins:(int32_t) value {
  result.hasGainCoins = YES;
  result.gainCoins = value;
  return self;
}
- (UserResult_Builder*) clearGainCoins {
  result.hasGainCoins = NO;
  result.gainCoins = 0;
  return self;
}
@end

@interface LieDiceGameResult ()
@property (retain) UserResult* openDiceUserResult;
@property (retain) UserResult* callDiceUserResult;
@property int32_t openType;
@end

@implementation LieDiceGameResult

- (BOOL) hasOpenDiceUserResult {
  return !!hasOpenDiceUserResult_;
}
- (void) setHasOpenDiceUserResult:(BOOL) value {
  hasOpenDiceUserResult_ = !!value;
}
@synthesize openDiceUserResult;
- (BOOL) hasCallDiceUserResult {
  return !!hasCallDiceUserResult_;
}
- (void) setHasCallDiceUserResult:(BOOL) value {
  hasCallDiceUserResult_ = !!value;
}
@synthesize callDiceUserResult;
- (BOOL) hasOpenType {
  return !!hasOpenType_;
}
- (void) setHasOpenType:(BOOL) value {
  hasOpenType_ = !!value;
}
@synthesize openType;
- (void) dealloc {
  self.openDiceUserResult = nil;
  self.callDiceUserResult = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.openDiceUserResult = [UserResult defaultInstance];
    self.callDiceUserResult = [UserResult defaultInstance];
    self.openType = 0;
  }
  return self;
}
static LieDiceGameResult* defaultLieDiceGameResultInstance = nil;
+ (void) initialize {
  if (self == [LieDiceGameResult class]) {
    defaultLieDiceGameResultInstance = [[LieDiceGameResult alloc] init];
  }
}
+ (LieDiceGameResult*) defaultInstance {
  return defaultLieDiceGameResultInstance;
}
- (LieDiceGameResult*) defaultInstance {
  return defaultLieDiceGameResultInstance;
}
- (BOOL) isInitialized {
  if (!self.hasOpenDiceUserResult) {
    return NO;
  }
  if (!self.hasCallDiceUserResult) {
    return NO;
  }
  if (!self.openDiceUserResult.isInitialized) {
    return NO;
  }
  if (!self.callDiceUserResult.isInitialized) {
    return NO;
  }
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasOpenDiceUserResult) {
    [output writeMessage:1 value:self.openDiceUserResult];
  }
  if (self.hasCallDiceUserResult) {
    [output writeMessage:2 value:self.callDiceUserResult];
  }
  if (self.hasOpenType) {
    [output writeInt32:5 value:self.openType];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (int32_t) serializedSize {
  int32_t size = memoizedSerializedSize;
  if (size != -1) {
    return size;
  }

  size = 0;
  if (self.hasOpenDiceUserResult) {
    size += computeMessageSize(1, self.openDiceUserResult);
  }
  if (self.hasCallDiceUserResult) {
    size += computeMessageSize(2, self.callDiceUserResult);
  }
  if (self.hasOpenType) {
    size += computeInt32Size(5, self.openType);
  }
  size += self.unknownFields.serializedSize;
  memoizedSerializedSize = size;
  return size;
}
+ (LieDiceGameResult*) parseFromData:(NSData*) data {
  return (LieDiceGameResult*)[[[LieDiceGameResult builder] mergeFromData:data] build];
}
+ (LieDiceGameResult*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (LieDiceGameResult*)[[[LieDiceGameResult builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (LieDiceGameResult*) parseFromInputStream:(NSInputStream*) input {
  return (LieDiceGameResult*)[[[LieDiceGameResult builder] mergeFromInputStream:input] build];
}
+ (LieDiceGameResult*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (LieDiceGameResult*)[[[LieDiceGameResult builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (LieDiceGameResult*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (LieDiceGameResult*)[[[LieDiceGameResult builder] mergeFromCodedInputStream:input] build];
}
+ (LieDiceGameResult*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (LieDiceGameResult*)[[[LieDiceGameResult builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (LieDiceGameResult_Builder*) builder {
  return [[[LieDiceGameResult_Builder alloc] init] autorelease];
}
+ (LieDiceGameResult_Builder*) builderWithPrototype:(LieDiceGameResult*) prototype {
  return [[LieDiceGameResult builder] mergeFrom:prototype];
}
- (LieDiceGameResult_Builder*) builder {
  return [LieDiceGameResult builder];
}
@end

@interface LieDiceGameResult_Builder()
@property (retain) LieDiceGameResult* result;
@end

@implementation LieDiceGameResult_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[LieDiceGameResult alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (LieDiceGameResult_Builder*) clear {
  self.result = [[[LieDiceGameResult alloc] init] autorelease];
  return self;
}
- (LieDiceGameResult_Builder*) clone {
  return [LieDiceGameResult builderWithPrototype:result];
}
- (LieDiceGameResult*) defaultInstance {
  return [LieDiceGameResult defaultInstance];
}
- (LieDiceGameResult*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (LieDiceGameResult*) buildPartial {
  LieDiceGameResult* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (LieDiceGameResult_Builder*) mergeFrom:(LieDiceGameResult*) other {
  if (other == [LieDiceGameResult defaultInstance]) {
    return self;
  }
  if (other.hasOpenDiceUserResult) {
    [self mergeOpenDiceUserResult:other.openDiceUserResult];
  }
  if (other.hasCallDiceUserResult) {
    [self mergeCallDiceUserResult:other.callDiceUserResult];
  }
  if (other.hasOpenType) {
    [self setOpenType:other.openType];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (LieDiceGameResult_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (LieDiceGameResult_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  PBUnknownFieldSet_Builder* unknownFields = [PBUnknownFieldSet builderWithUnknownFields:self.unknownFields];
  while (YES) {
    int32_t tag = [input readTag];
    switch (tag) {
      case 0:
        [self setUnknownFields:[unknownFields build]];
        return self;
      default: {
        if (![self parseUnknownField:input unknownFields:unknownFields extensionRegistry:extensionRegistry tag:tag]) {
          [self setUnknownFields:[unknownFields build]];
          return self;
        }
        break;
      }
      case 10: {
        UserResult_Builder* subBuilder = [UserResult builder];
        if (self.hasOpenDiceUserResult) {
          [subBuilder mergeFrom:self.openDiceUserResult];
        }
        [input readMessage:subBuilder extensionRegistry:extensionRegistry];
        [self setOpenDiceUserResult:[subBuilder buildPartial]];
        break;
      }
      case 18: {
        UserResult_Builder* subBuilder = [UserResult builder];
        if (self.hasCallDiceUserResult) {
          [subBuilder mergeFrom:self.callDiceUserResult];
        }
        [input readMessage:subBuilder extensionRegistry:extensionRegistry];
        [self setCallDiceUserResult:[subBuilder buildPartial]];
        break;
      }
      case 40: {
        [self setOpenType:[input readInt32]];
        break;
      }
    }
  }
}
- (BOOL) hasOpenDiceUserResult {
  return result.hasOpenDiceUserResult;
}
- (UserResult*) openDiceUserResult {
  return result.openDiceUserResult;
}
- (LieDiceGameResult_Builder*) setOpenDiceUserResult:(UserResult*) value {
  result.hasOpenDiceUserResult = YES;
  result.openDiceUserResult = value;
  return self;
}
- (LieDiceGameResult_Builder*) setOpenDiceUserResultBuilder:(UserResult_Builder*) builderForValue {
  return [self setOpenDiceUserResult:[builderForValue build]];
}
- (LieDiceGameResult_Builder*) mergeOpenDiceUserResult:(UserResult*) value {
  if (result.hasOpenDiceUserResult &&
      result.openDiceUserResult != [UserResult defaultInstance]) {
    result.openDiceUserResult =
      [[[UserResult builderWithPrototype:result.openDiceUserResult] mergeFrom:value] buildPartial];
  } else {
    result.openDiceUserResult = value;
  }
  result.hasOpenDiceUserResult = YES;
  return self;
}
- (LieDiceGameResult_Builder*) clearOpenDiceUserResult {
  result.hasOpenDiceUserResult = NO;
  result.openDiceUserResult = [UserResult defaultInstance];
  return self;
}
- (BOOL) hasCallDiceUserResult {
  return result.hasCallDiceUserResult;
}
- (UserResult*) callDiceUserResult {
  return result.callDiceUserResult;
}
- (LieDiceGameResult_Builder*) setCallDiceUserResult:(UserResult*) value {
  result.hasCallDiceUserResult = YES;
  result.callDiceUserResult = value;
  return self;
}
- (LieDiceGameResult_Builder*) setCallDiceUserResultBuilder:(UserResult_Builder*) builderForValue {
  return [self setCallDiceUserResult:[builderForValue build]];
}
- (LieDiceGameResult_Builder*) mergeCallDiceUserResult:(UserResult*) value {
  if (result.hasCallDiceUserResult &&
      result.callDiceUserResult != [UserResult defaultInstance]) {
    result.callDiceUserResult =
      [[[UserResult builderWithPrototype:result.callDiceUserResult] mergeFrom:value] buildPartial];
  } else {
    result.callDiceUserResult = value;
  }
  result.hasCallDiceUserResult = YES;
  return self;
}
- (LieDiceGameResult_Builder*) clearCallDiceUserResult {
  result.hasCallDiceUserResult = NO;
  result.callDiceUserResult = [UserResult defaultInstance];
  return self;
}
- (BOOL) hasOpenType {
  return result.hasOpenType;
}
- (int32_t) openType {
  return result.openType;
}
- (LieDiceGameResult_Builder*) setOpenType:(int32_t) value {
  result.hasOpenType = YES;
  result.openType = value;
  return self;
}
- (LieDiceGameResult_Builder*) clearOpenType {
  result.hasOpenType = NO;
  result.openType = 0;
  return self;
}
@end

