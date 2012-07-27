// Generated by the protocol buffer compiler.  DO NOT EDIT!

#import "Draw.pb.h"

@implementation DrawRoot
static PBExtensionRegistry* extensionRegistry = nil;
+ (PBExtensionRegistry*) extensionRegistry {
  return extensionRegistry;
}

+ (void) initialize {
  if (self == [DrawRoot class]) {
    PBMutableExtensionRegistry* registry = [PBMutableExtensionRegistry registry];
    [self registerAllExtensions:registry];
    [GameBasicRoot registerAllExtensions:registry];
    extensionRegistry = [registry retain];
  }
}
+ (void) registerAllExtensions:(PBMutableExtensionRegistry*) registry {
}
@end

@interface PBDraw ()
@property (retain) NSString* userId;
@property (retain) NSString* word;
@property int32_t level;
@property int32_t language;
@property int32_t createDate;
@property (retain) NSString* nickName;
@property (retain) NSString* avatar;
@property BOOL gender;
@property (retain) NSMutableArray* mutableDrawDataList;
@property (retain) NSString* opusId;
@end

@implementation PBDraw

- (BOOL) hasUserId {
  return !!hasUserId_;
}
- (void) setHasUserId:(BOOL) value {
  hasUserId_ = !!value;
}
@synthesize userId;
- (BOOL) hasWord {
  return !!hasWord_;
}
- (void) setHasWord:(BOOL) value {
  hasWord_ = !!value;
}
@synthesize word;
- (BOOL) hasLevel {
  return !!hasLevel_;
}
- (void) setHasLevel:(BOOL) value {
  hasLevel_ = !!value;
}
@synthesize level;
- (BOOL) hasLanguage {
  return !!hasLanguage_;
}
- (void) setHasLanguage:(BOOL) value {
  hasLanguage_ = !!value;
}
@synthesize language;
- (BOOL) hasCreateDate {
  return !!hasCreateDate_;
}
- (void) setHasCreateDate:(BOOL) value {
  hasCreateDate_ = !!value;
}
@synthesize createDate;
- (BOOL) hasNickName {
  return !!hasNickName_;
}
- (void) setHasNickName:(BOOL) value {
  hasNickName_ = !!value;
}
@synthesize nickName;
- (BOOL) hasAvatar {
  return !!hasAvatar_;
}
- (void) setHasAvatar:(BOOL) value {
  hasAvatar_ = !!value;
}
@synthesize avatar;
- (BOOL) hasGender {
  return !!hasGender_;
}
- (void) setHasGender:(BOOL) value {
  hasGender_ = !!value;
}
- (BOOL) gender {
  return !!gender_;
}
- (void) setGender:(BOOL) value {
  gender_ = !!value;
}
@synthesize mutableDrawDataList;
- (BOOL) hasOpusId {
  return !!hasOpusId_;
}
- (void) setHasOpusId:(BOOL) value {
  hasOpusId_ = !!value;
}
@synthesize opusId;
- (void) dealloc {
  self.userId = nil;
  self.word = nil;
  self.nickName = nil;
  self.avatar = nil;
  self.mutableDrawDataList = nil;
  self.opusId = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.userId = @"";
    self.word = @"";
    self.level = 0;
    self.language = 0;
    self.createDate = 0;
    self.nickName = @"";
    self.avatar = @"";
    self.gender = NO;
    self.opusId = @"";
  }
  return self;
}
static PBDraw* defaultPBDrawInstance = nil;
+ (void) initialize {
  if (self == [PBDraw class]) {
    defaultPBDrawInstance = [[PBDraw alloc] init];
  }
}
+ (PBDraw*) defaultInstance {
  return defaultPBDrawInstance;
}
- (PBDraw*) defaultInstance {
  return defaultPBDrawInstance;
}
- (NSArray*) drawDataList {
  return mutableDrawDataList;
}
- (PBDrawAction*) drawDataAtIndex:(int32_t) index {
  id value = [mutableDrawDataList objectAtIndex:index];
  return value;
}
- (BOOL) isInitialized {
  if (!self.hasUserId) {
    return NO;
  }
  if (!self.hasWord) {
    return NO;
  }
  if (!self.hasLevel) {
    return NO;
  }
  if (!self.hasLanguage) {
    return NO;
  }
  for (PBDrawAction* element in self.drawDataList) {
    if (!element.isInitialized) {
      return NO;
    }
  }
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasUserId) {
    [output writeString:1 value:self.userId];
  }
  if (self.hasWord) {
    [output writeString:2 value:self.word];
  }
  if (self.hasLevel) {
    [output writeInt32:3 value:self.level];
  }
  if (self.hasLanguage) {
    [output writeInt32:4 value:self.language];
  }
  if (self.hasCreateDate) {
    [output writeInt32:5 value:self.createDate];
  }
  if (self.hasNickName) {
    [output writeString:6 value:self.nickName];
  }
  if (self.hasAvatar) {
    [output writeString:7 value:self.avatar];
  }
  if (self.hasGender) {
    [output writeBool:8 value:self.gender];
  }
  for (PBDrawAction* element in self.drawDataList) {
    [output writeMessage:10 value:element];
  }
  if (self.hasOpusId) {
    [output writeString:11 value:self.opusId];
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
  if (self.hasWord) {
    size += computeStringSize(2, self.word);
  }
  if (self.hasLevel) {
    size += computeInt32Size(3, self.level);
  }
  if (self.hasLanguage) {
    size += computeInt32Size(4, self.language);
  }
  if (self.hasCreateDate) {
    size += computeInt32Size(5, self.createDate);
  }
  if (self.hasNickName) {
    size += computeStringSize(6, self.nickName);
  }
  if (self.hasAvatar) {
    size += computeStringSize(7, self.avatar);
  }
  if (self.hasGender) {
    size += computeBoolSize(8, self.gender);
  }
  for (PBDrawAction* element in self.drawDataList) {
    size += computeMessageSize(10, element);
  }
  if (self.hasOpusId) {
    size += computeStringSize(11, self.opusId);
  }
  size += self.unknownFields.serializedSize;
  memoizedSerializedSize = size;
  return size;
}
+ (PBDraw*) parseFromData:(NSData*) data {
  return (PBDraw*)[[[PBDraw builder] mergeFromData:data] build];
}
+ (PBDraw*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (PBDraw*)[[[PBDraw builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (PBDraw*) parseFromInputStream:(NSInputStream*) input {
  return (PBDraw*)[[[PBDraw builder] mergeFromInputStream:input] build];
}
+ (PBDraw*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (PBDraw*)[[[PBDraw builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (PBDraw*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (PBDraw*)[[[PBDraw builder] mergeFromCodedInputStream:input] build];
}
+ (PBDraw*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (PBDraw*)[[[PBDraw builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (PBDraw_Builder*) builder {
  return [[[PBDraw_Builder alloc] init] autorelease];
}
+ (PBDraw_Builder*) builderWithPrototype:(PBDraw*) prototype {
  return [[PBDraw builder] mergeFrom:prototype];
}
- (PBDraw_Builder*) builder {
  return [PBDraw builder];
}
@end

@interface PBDraw_Builder()
@property (retain) PBDraw* result;
@end

@implementation PBDraw_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[PBDraw alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (PBDraw_Builder*) clear {
  self.result = [[[PBDraw alloc] init] autorelease];
  return self;
}
- (PBDraw_Builder*) clone {
  return [PBDraw builderWithPrototype:result];
}
- (PBDraw*) defaultInstance {
  return [PBDraw defaultInstance];
}
- (PBDraw*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (PBDraw*) buildPartial {
  PBDraw* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (PBDraw_Builder*) mergeFrom:(PBDraw*) other {
  if (other == [PBDraw defaultInstance]) {
    return self;
  }
  if (other.hasUserId) {
    [self setUserId:other.userId];
  }
  if (other.hasWord) {
    [self setWord:other.word];
  }
  if (other.hasLevel) {
    [self setLevel:other.level];
  }
  if (other.hasLanguage) {
    [self setLanguage:other.language];
  }
  if (other.hasCreateDate) {
    [self setCreateDate:other.createDate];
  }
  if (other.hasNickName) {
    [self setNickName:other.nickName];
  }
  if (other.hasAvatar) {
    [self setAvatar:other.avatar];
  }
  if (other.hasGender) {
    [self setGender:other.gender];
  }
  if (other.mutableDrawDataList.count > 0) {
    if (result.mutableDrawDataList == nil) {
      result.mutableDrawDataList = [NSMutableArray array];
    }
    [result.mutableDrawDataList addObjectsFromArray:other.mutableDrawDataList];
  }
  if (other.hasOpusId) {
    [self setOpusId:other.opusId];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (PBDraw_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (PBDraw_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
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
      case 18: {
        [self setWord:[input readString]];
        break;
      }
      case 24: {
        [self setLevel:[input readInt32]];
        break;
      }
      case 32: {
        [self setLanguage:[input readInt32]];
        break;
      }
      case 40: {
        [self setCreateDate:[input readInt32]];
        break;
      }
      case 50: {
        [self setNickName:[input readString]];
        break;
      }
      case 58: {
        [self setAvatar:[input readString]];
        break;
      }
      case 64: {
        [self setGender:[input readBool]];
        break;
      }
      case 82: {
        PBDrawAction_Builder* subBuilder = [PBDrawAction builder];
        [input readMessage:subBuilder extensionRegistry:extensionRegistry];
        [self addDrawData:[subBuilder buildPartial]];
        break;
      }
      case 90: {
        [self setOpusId:[input readString]];
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
- (PBDraw_Builder*) setUserId:(NSString*) value {
  result.hasUserId = YES;
  result.userId = value;
  return self;
}
- (PBDraw_Builder*) clearUserId {
  result.hasUserId = NO;
  result.userId = @"";
  return self;
}
- (BOOL) hasWord {
  return result.hasWord;
}
- (NSString*) word {
  return result.word;
}
- (PBDraw_Builder*) setWord:(NSString*) value {
  result.hasWord = YES;
  result.word = value;
  return self;
}
- (PBDraw_Builder*) clearWord {
  result.hasWord = NO;
  result.word = @"";
  return self;
}
- (BOOL) hasLevel {
  return result.hasLevel;
}
- (int32_t) level {
  return result.level;
}
- (PBDraw_Builder*) setLevel:(int32_t) value {
  result.hasLevel = YES;
  result.level = value;
  return self;
}
- (PBDraw_Builder*) clearLevel {
  result.hasLevel = NO;
  result.level = 0;
  return self;
}
- (BOOL) hasLanguage {
  return result.hasLanguage;
}
- (int32_t) language {
  return result.language;
}
- (PBDraw_Builder*) setLanguage:(int32_t) value {
  result.hasLanguage = YES;
  result.language = value;
  return self;
}
- (PBDraw_Builder*) clearLanguage {
  result.hasLanguage = NO;
  result.language = 0;
  return self;
}
- (BOOL) hasCreateDate {
  return result.hasCreateDate;
}
- (int32_t) createDate {
  return result.createDate;
}
- (PBDraw_Builder*) setCreateDate:(int32_t) value {
  result.hasCreateDate = YES;
  result.createDate = value;
  return self;
}
- (PBDraw_Builder*) clearCreateDate {
  result.hasCreateDate = NO;
  result.createDate = 0;
  return self;
}
- (BOOL) hasNickName {
  return result.hasNickName;
}
- (NSString*) nickName {
  return result.nickName;
}
- (PBDraw_Builder*) setNickName:(NSString*) value {
  result.hasNickName = YES;
  result.nickName = value;
  return self;
}
- (PBDraw_Builder*) clearNickName {
  result.hasNickName = NO;
  result.nickName = @"";
  return self;
}
- (BOOL) hasAvatar {
  return result.hasAvatar;
}
- (NSString*) avatar {
  return result.avatar;
}
- (PBDraw_Builder*) setAvatar:(NSString*) value {
  result.hasAvatar = YES;
  result.avatar = value;
  return self;
}
- (PBDraw_Builder*) clearAvatar {
  result.hasAvatar = NO;
  result.avatar = @"";
  return self;
}
- (BOOL) hasGender {
  return result.hasGender;
}
- (BOOL) gender {
  return result.gender;
}
- (PBDraw_Builder*) setGender:(BOOL) value {
  result.hasGender = YES;
  result.gender = value;
  return self;
}
- (PBDraw_Builder*) clearGender {
  result.hasGender = NO;
  result.gender = NO;
  return self;
}
- (NSArray*) drawDataList {
  if (result.mutableDrawDataList == nil) { return [NSArray array]; }
  return result.mutableDrawDataList;
}
- (PBDrawAction*) drawDataAtIndex:(int32_t) index {
  return [result drawDataAtIndex:index];
}
- (PBDraw_Builder*) replaceDrawDataAtIndex:(int32_t) index with:(PBDrawAction*) value {
  [result.mutableDrawDataList replaceObjectAtIndex:index withObject:value];
  return self;
}
- (PBDraw_Builder*) addAllDrawData:(NSArray*) values {
  if (result.mutableDrawDataList == nil) {
    result.mutableDrawDataList = [NSMutableArray array];
  }
  [result.mutableDrawDataList addObjectsFromArray:values];
  return self;
}
- (PBDraw_Builder*) clearDrawDataList {
  result.mutableDrawDataList = nil;
  return self;
}
- (PBDraw_Builder*) addDrawData:(PBDrawAction*) value {
  if (result.mutableDrawDataList == nil) {
    result.mutableDrawDataList = [NSMutableArray array];
  }
  [result.mutableDrawDataList addObject:value];
  return self;
}
- (BOOL) hasOpusId {
  return result.hasOpusId;
}
- (NSString*) opusId {
  return result.opusId;
}
- (PBDraw_Builder*) setOpusId:(NSString*) value {
  result.hasOpusId = YES;
  result.opusId = value;
  return self;
}
- (PBDraw_Builder*) clearOpusId {
  result.hasOpusId = NO;
  result.opusId = @"";
  return self;
}
@end

@interface PBFeed ()
@property (retain) NSString* feedId;
@property (retain) NSString* userId;
@property int32_t actionType;
@property int32_t createDate;
@property (retain) NSString* nickName;
@property (retain) NSString* avatar;
@property BOOL gender;
@property (retain) PBDraw* drawData;
@property (retain) NSString* targetUserId;
@property (retain) NSString* targetUserNickName;
@property (retain) NSString* opusId;
@property BOOL isCorrect;
@property int32_t score;
@property (retain) NSMutableArray* mutableGuessWordsList;
@property int32_t opusStatus;
@property (retain) NSString* comment;
@property int32_t matchTimes;
@property int32_t correctTimes;
@property int32_t guessTimes;
@property int32_t commentTimes;
@end

@implementation PBFeed

- (BOOL) hasFeedId {
  return !!hasFeedId_;
}
- (void) setHasFeedId:(BOOL) value {
  hasFeedId_ = !!value;
}
@synthesize feedId;
- (BOOL) hasUserId {
  return !!hasUserId_;
}
- (void) setHasUserId:(BOOL) value {
  hasUserId_ = !!value;
}
@synthesize userId;
- (BOOL) hasActionType {
  return !!hasActionType_;
}
- (void) setHasActionType:(BOOL) value {
  hasActionType_ = !!value;
}
@synthesize actionType;
- (BOOL) hasCreateDate {
  return !!hasCreateDate_;
}
- (void) setHasCreateDate:(BOOL) value {
  hasCreateDate_ = !!value;
}
@synthesize createDate;
- (BOOL) hasNickName {
  return !!hasNickName_;
}
- (void) setHasNickName:(BOOL) value {
  hasNickName_ = !!value;
}
@synthesize nickName;
- (BOOL) hasAvatar {
  return !!hasAvatar_;
}
- (void) setHasAvatar:(BOOL) value {
  hasAvatar_ = !!value;
}
@synthesize avatar;
- (BOOL) hasGender {
  return !!hasGender_;
}
- (void) setHasGender:(BOOL) value {
  hasGender_ = !!value;
}
- (BOOL) gender {
  return !!gender_;
}
- (void) setGender:(BOOL) value {
  gender_ = !!value;
}
- (BOOL) hasDrawData {
  return !!hasDrawData_;
}
- (void) setHasDrawData:(BOOL) value {
  hasDrawData_ = !!value;
}
@synthesize drawData;
- (BOOL) hasTargetUserId {
  return !!hasTargetUserId_;
}
- (void) setHasTargetUserId:(BOOL) value {
  hasTargetUserId_ = !!value;
}
@synthesize targetUserId;
- (BOOL) hasTargetUserNickName {
  return !!hasTargetUserNickName_;
}
- (void) setHasTargetUserNickName:(BOOL) value {
  hasTargetUserNickName_ = !!value;
}
@synthesize targetUserNickName;
- (BOOL) hasOpusId {
  return !!hasOpusId_;
}
- (void) setHasOpusId:(BOOL) value {
  hasOpusId_ = !!value;
}
@synthesize opusId;
- (BOOL) hasIsCorrect {
  return !!hasIsCorrect_;
}
- (void) setHasIsCorrect:(BOOL) value {
  hasIsCorrect_ = !!value;
}
- (BOOL) isCorrect {
  return !!isCorrect_;
}
- (void) setIsCorrect:(BOOL) value {
  isCorrect_ = !!value;
}
- (BOOL) hasScore {
  return !!hasScore_;
}
- (void) setHasScore:(BOOL) value {
  hasScore_ = !!value;
}
@synthesize score;
@synthesize mutableGuessWordsList;
- (BOOL) hasOpusStatus {
  return !!hasOpusStatus_;
}
- (void) setHasOpusStatus:(BOOL) value {
  hasOpusStatus_ = !!value;
}
@synthesize opusStatus;
- (BOOL) hasComment {
  return !!hasComment_;
}
- (void) setHasComment:(BOOL) value {
  hasComment_ = !!value;
}
@synthesize comment;
- (BOOL) hasMatchTimes {
  return !!hasMatchTimes_;
}
- (void) setHasMatchTimes:(BOOL) value {
  hasMatchTimes_ = !!value;
}
@synthesize matchTimes;
- (BOOL) hasCorrectTimes {
  return !!hasCorrectTimes_;
}
- (void) setHasCorrectTimes:(BOOL) value {
  hasCorrectTimes_ = !!value;
}
@synthesize correctTimes;
- (BOOL) hasGuessTimes {
  return !!hasGuessTimes_;
}
- (void) setHasGuessTimes:(BOOL) value {
  hasGuessTimes_ = !!value;
}
@synthesize guessTimes;
- (BOOL) hasCommentTimes {
  return !!hasCommentTimes_;
}
- (void) setHasCommentTimes:(BOOL) value {
  hasCommentTimes_ = !!value;
}
@synthesize commentTimes;
- (void) dealloc {
  self.feedId = nil;
  self.userId = nil;
  self.nickName = nil;
  self.avatar = nil;
  self.drawData = nil;
  self.targetUserId = nil;
  self.targetUserNickName = nil;
  self.opusId = nil;
  self.mutableGuessWordsList = nil;
  self.comment = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.feedId = @"";
    self.userId = @"";
    self.actionType = 0;
    self.createDate = 0;
    self.nickName = @"";
    self.avatar = @"";
    self.gender = NO;
    self.drawData = [PBDraw defaultInstance];
    self.targetUserId = @"";
    self.targetUserNickName = @"";
    self.opusId = @"";
    self.isCorrect = NO;
    self.score = 0;
    self.opusStatus = 0;
    self.comment = @"";
    self.matchTimes = 0;
    self.correctTimes = 0;
    self.guessTimes = 0;
    self.commentTimes = 0;
  }
  return self;
}
static PBFeed* defaultPBFeedInstance = nil;
+ (void) initialize {
  if (self == [PBFeed class]) {
    defaultPBFeedInstance = [[PBFeed alloc] init];
  }
}
+ (PBFeed*) defaultInstance {
  return defaultPBFeedInstance;
}
- (PBFeed*) defaultInstance {
  return defaultPBFeedInstance;
}
- (NSArray*) guessWordsList {
  return mutableGuessWordsList;
}
- (NSString*) guessWordsAtIndex:(int32_t) index {
  id value = [mutableGuessWordsList objectAtIndex:index];
  return value;
}
- (BOOL) isInitialized {
  if (!self.hasFeedId) {
    return NO;
  }
  if (!self.hasUserId) {
    return NO;
  }
  if (!self.hasActionType) {
    return NO;
  }
  if (!self.hasCreateDate) {
    return NO;
  }
  if (self.hasDrawData) {
    if (!self.drawData.isInitialized) {
      return NO;
    }
  }
  return YES;
}
- (void) writeToCodedOutputStream:(PBCodedOutputStream*) output {
  if (self.hasFeedId) {
    [output writeString:1 value:self.feedId];
  }
  if (self.hasUserId) {
    [output writeString:2 value:self.userId];
  }
  if (self.hasActionType) {
    [output writeInt32:3 value:self.actionType];
  }
  if (self.hasCreateDate) {
    [output writeInt32:4 value:self.createDate];
  }
  if (self.hasNickName) {
    [output writeString:21 value:self.nickName];
  }
  if (self.hasAvatar) {
    [output writeString:22 value:self.avatar];
  }
  if (self.hasGender) {
    [output writeBool:23 value:self.gender];
  }
  if (self.hasDrawData) {
    [output writeMessage:31 value:self.drawData];
  }
  if (self.hasTargetUserId) {
    [output writeString:32 value:self.targetUserId];
  }
  if (self.hasTargetUserNickName) {
    [output writeString:33 value:self.targetUserNickName];
  }
  if (self.hasOpusId) {
    [output writeString:41 value:self.opusId];
  }
  if (self.hasIsCorrect) {
    [output writeBool:42 value:self.isCorrect];
  }
  if (self.hasScore) {
    [output writeInt32:43 value:self.score];
  }
  for (NSString* element in self.mutableGuessWordsList) {
    [output writeString:44 value:element];
  }
  if (self.hasOpusStatus) {
    [output writeInt32:45 value:self.opusStatus];
  }
  if (self.hasComment) {
    [output writeString:51 value:self.comment];
  }
  if (self.hasMatchTimes) {
    [output writeInt32:61 value:self.matchTimes];
  }
  if (self.hasCorrectTimes) {
    [output writeInt32:62 value:self.correctTimes];
  }
  if (self.hasGuessTimes) {
    [output writeInt32:63 value:self.guessTimes];
  }
  if (self.hasCommentTimes) {
    [output writeInt32:64 value:self.commentTimes];
  }
  [self.unknownFields writeToCodedOutputStream:output];
}
- (int32_t) serializedSize {
  int32_t size = memoizedSerializedSize;
  if (size != -1) {
    return size;
  }

  size = 0;
  if (self.hasFeedId) {
    size += computeStringSize(1, self.feedId);
  }
  if (self.hasUserId) {
    size += computeStringSize(2, self.userId);
  }
  if (self.hasActionType) {
    size += computeInt32Size(3, self.actionType);
  }
  if (self.hasCreateDate) {
    size += computeInt32Size(4, self.createDate);
  }
  if (self.hasNickName) {
    size += computeStringSize(21, self.nickName);
  }
  if (self.hasAvatar) {
    size += computeStringSize(22, self.avatar);
  }
  if (self.hasGender) {
    size += computeBoolSize(23, self.gender);
  }
  if (self.hasDrawData) {
    size += computeMessageSize(31, self.drawData);
  }
  if (self.hasTargetUserId) {
    size += computeStringSize(32, self.targetUserId);
  }
  if (self.hasTargetUserNickName) {
    size += computeStringSize(33, self.targetUserNickName);
  }
  if (self.hasOpusId) {
    size += computeStringSize(41, self.opusId);
  }
  if (self.hasIsCorrect) {
    size += computeBoolSize(42, self.isCorrect);
  }
  if (self.hasScore) {
    size += computeInt32Size(43, self.score);
  }
  {
    int32_t dataSize = 0;
    for (NSString* element in self.mutableGuessWordsList) {
      dataSize += computeStringSizeNoTag(element);
    }
    size += dataSize;
    size += 2 * self.mutableGuessWordsList.count;
  }
  if (self.hasOpusStatus) {
    size += computeInt32Size(45, self.opusStatus);
  }
  if (self.hasComment) {
    size += computeStringSize(51, self.comment);
  }
  if (self.hasMatchTimes) {
    size += computeInt32Size(61, self.matchTimes);
  }
  if (self.hasCorrectTimes) {
    size += computeInt32Size(62, self.correctTimes);
  }
  if (self.hasGuessTimes) {
    size += computeInt32Size(63, self.guessTimes);
  }
  if (self.hasCommentTimes) {
    size += computeInt32Size(64, self.commentTimes);
  }
  size += self.unknownFields.serializedSize;
  memoizedSerializedSize = size;
  return size;
}
+ (PBFeed*) parseFromData:(NSData*) data {
  return (PBFeed*)[[[PBFeed builder] mergeFromData:data] build];
}
+ (PBFeed*) parseFromData:(NSData*) data extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (PBFeed*)[[[PBFeed builder] mergeFromData:data extensionRegistry:extensionRegistry] build];
}
+ (PBFeed*) parseFromInputStream:(NSInputStream*) input {
  return (PBFeed*)[[[PBFeed builder] mergeFromInputStream:input] build];
}
+ (PBFeed*) parseFromInputStream:(NSInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (PBFeed*)[[[PBFeed builder] mergeFromInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (PBFeed*) parseFromCodedInputStream:(PBCodedInputStream*) input {
  return (PBFeed*)[[[PBFeed builder] mergeFromCodedInputStream:input] build];
}
+ (PBFeed*) parseFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
  return (PBFeed*)[[[PBFeed builder] mergeFromCodedInputStream:input extensionRegistry:extensionRegistry] build];
}
+ (PBFeed_Builder*) builder {
  return [[[PBFeed_Builder alloc] init] autorelease];
}
+ (PBFeed_Builder*) builderWithPrototype:(PBFeed*) prototype {
  return [[PBFeed builder] mergeFrom:prototype];
}
- (PBFeed_Builder*) builder {
  return [PBFeed builder];
}
@end

@interface PBFeed_Builder()
@property (retain) PBFeed* result;
@end

@implementation PBFeed_Builder
@synthesize result;
- (void) dealloc {
  self.result = nil;
  [super dealloc];
}
- (id) init {
  if ((self = [super init])) {
    self.result = [[[PBFeed alloc] init] autorelease];
  }
  return self;
}
- (PBGeneratedMessage*) internalGetResult {
  return result;
}
- (PBFeed_Builder*) clear {
  self.result = [[[PBFeed alloc] init] autorelease];
  return self;
}
- (PBFeed_Builder*) clone {
  return [PBFeed builderWithPrototype:result];
}
- (PBFeed*) defaultInstance {
  return [PBFeed defaultInstance];
}
- (PBFeed*) build {
  [self checkInitialized];
  return [self buildPartial];
}
- (PBFeed*) buildPartial {
  PBFeed* returnMe = [[result retain] autorelease];
  self.result = nil;
  return returnMe;
}
- (PBFeed_Builder*) mergeFrom:(PBFeed*) other {
  if (other == [PBFeed defaultInstance]) {
    return self;
  }
  if (other.hasFeedId) {
    [self setFeedId:other.feedId];
  }
  if (other.hasUserId) {
    [self setUserId:other.userId];
  }
  if (other.hasActionType) {
    [self setActionType:other.actionType];
  }
  if (other.hasCreateDate) {
    [self setCreateDate:other.createDate];
  }
  if (other.hasNickName) {
    [self setNickName:other.nickName];
  }
  if (other.hasAvatar) {
    [self setAvatar:other.avatar];
  }
  if (other.hasGender) {
    [self setGender:other.gender];
  }
  if (other.hasDrawData) {
    [self mergeDrawData:other.drawData];
  }
  if (other.hasTargetUserId) {
    [self setTargetUserId:other.targetUserId];
  }
  if (other.hasTargetUserNickName) {
    [self setTargetUserNickName:other.targetUserNickName];
  }
  if (other.hasOpusId) {
    [self setOpusId:other.opusId];
  }
  if (other.hasIsCorrect) {
    [self setIsCorrect:other.isCorrect];
  }
  if (other.hasScore) {
    [self setScore:other.score];
  }
  if (other.mutableGuessWordsList.count > 0) {
    if (result.mutableGuessWordsList == nil) {
      result.mutableGuessWordsList = [NSMutableArray array];
    }
    [result.mutableGuessWordsList addObjectsFromArray:other.mutableGuessWordsList];
  }
  if (other.hasOpusStatus) {
    [self setOpusStatus:other.opusStatus];
  }
  if (other.hasComment) {
    [self setComment:other.comment];
  }
  if (other.hasMatchTimes) {
    [self setMatchTimes:other.matchTimes];
  }
  if (other.hasCorrectTimes) {
    [self setCorrectTimes:other.correctTimes];
  }
  if (other.hasGuessTimes) {
    [self setGuessTimes:other.guessTimes];
  }
  if (other.hasCommentTimes) {
    [self setCommentTimes:other.commentTimes];
  }
  [self mergeUnknownFields:other.unknownFields];
  return self;
}
- (PBFeed_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input {
  return [self mergeFromCodedInputStream:input extensionRegistry:[PBExtensionRegistry emptyRegistry]];
}
- (PBFeed_Builder*) mergeFromCodedInputStream:(PBCodedInputStream*) input extensionRegistry:(PBExtensionRegistry*) extensionRegistry {
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
        [self setFeedId:[input readString]];
        break;
      }
      case 18: {
        [self setUserId:[input readString]];
        break;
      }
      case 24: {
        [self setActionType:[input readInt32]];
        break;
      }
      case 32: {
        [self setCreateDate:[input readInt32]];
        break;
      }
      case 170: {
        [self setNickName:[input readString]];
        break;
      }
      case 178: {
        [self setAvatar:[input readString]];
        break;
      }
      case 184: {
        [self setGender:[input readBool]];
        break;
      }
      case 250: {
        PBDraw_Builder* subBuilder = [PBDraw builder];
        if (self.hasDrawData) {
          [subBuilder mergeFrom:self.drawData];
        }
        [input readMessage:subBuilder extensionRegistry:extensionRegistry];
        [self setDrawData:[subBuilder buildPartial]];
        break;
      }
      case 258: {
        [self setTargetUserId:[input readString]];
        break;
      }
      case 266: {
        [self setTargetUserNickName:[input readString]];
        break;
      }
      case 330: {
        [self setOpusId:[input readString]];
        break;
      }
      case 336: {
        [self setIsCorrect:[input readBool]];
        break;
      }
      case 344: {
        [self setScore:[input readInt32]];
        break;
      }
      case 354: {
        [self addGuessWords:[input readString]];
        break;
      }
      case 360: {
        [self setOpusStatus:[input readInt32]];
        break;
      }
      case 410: {
        [self setComment:[input readString]];
        break;
      }
      case 488: {
        [self setMatchTimes:[input readInt32]];
        break;
      }
      case 496: {
        [self setCorrectTimes:[input readInt32]];
        break;
      }
      case 504: {
        [self setGuessTimes:[input readInt32]];
        break;
      }
      case 512: {
        [self setCommentTimes:[input readInt32]];
        break;
      }
    }
  }
}
- (BOOL) hasFeedId {
  return result.hasFeedId;
}
- (NSString*) feedId {
  return result.feedId;
}
- (PBFeed_Builder*) setFeedId:(NSString*) value {
  result.hasFeedId = YES;
  result.feedId = value;
  return self;
}
- (PBFeed_Builder*) clearFeedId {
  result.hasFeedId = NO;
  result.feedId = @"";
  return self;
}
- (BOOL) hasUserId {
  return result.hasUserId;
}
- (NSString*) userId {
  return result.userId;
}
- (PBFeed_Builder*) setUserId:(NSString*) value {
  result.hasUserId = YES;
  result.userId = value;
  return self;
}
- (PBFeed_Builder*) clearUserId {
  result.hasUserId = NO;
  result.userId = @"";
  return self;
}
- (BOOL) hasActionType {
  return result.hasActionType;
}
- (int32_t) actionType {
  return result.actionType;
}
- (PBFeed_Builder*) setActionType:(int32_t) value {
  result.hasActionType = YES;
  result.actionType = value;
  return self;
}
- (PBFeed_Builder*) clearActionType {
  result.hasActionType = NO;
  result.actionType = 0;
  return self;
}
- (BOOL) hasCreateDate {
  return result.hasCreateDate;
}
- (int32_t) createDate {
  return result.createDate;
}
- (PBFeed_Builder*) setCreateDate:(int32_t) value {
  result.hasCreateDate = YES;
  result.createDate = value;
  return self;
}
- (PBFeed_Builder*) clearCreateDate {
  result.hasCreateDate = NO;
  result.createDate = 0;
  return self;
}
- (BOOL) hasNickName {
  return result.hasNickName;
}
- (NSString*) nickName {
  return result.nickName;
}
- (PBFeed_Builder*) setNickName:(NSString*) value {
  result.hasNickName = YES;
  result.nickName = value;
  return self;
}
- (PBFeed_Builder*) clearNickName {
  result.hasNickName = NO;
  result.nickName = @"";
  return self;
}
- (BOOL) hasAvatar {
  return result.hasAvatar;
}
- (NSString*) avatar {
  return result.avatar;
}
- (PBFeed_Builder*) setAvatar:(NSString*) value {
  result.hasAvatar = YES;
  result.avatar = value;
  return self;
}
- (PBFeed_Builder*) clearAvatar {
  result.hasAvatar = NO;
  result.avatar = @"";
  return self;
}
- (BOOL) hasGender {
  return result.hasGender;
}
- (BOOL) gender {
  return result.gender;
}
- (PBFeed_Builder*) setGender:(BOOL) value {
  result.hasGender = YES;
  result.gender = value;
  return self;
}
- (PBFeed_Builder*) clearGender {
  result.hasGender = NO;
  result.gender = NO;
  return self;
}
- (BOOL) hasDrawData {
  return result.hasDrawData;
}
- (PBDraw*) drawData {
  return result.drawData;
}
- (PBFeed_Builder*) setDrawData:(PBDraw*) value {
  result.hasDrawData = YES;
  result.drawData = value;
  return self;
}
- (PBFeed_Builder*) setDrawDataBuilder:(PBDraw_Builder*) builderForValue {
  return [self setDrawData:[builderForValue build]];
}
- (PBFeed_Builder*) mergeDrawData:(PBDraw*) value {
  if (result.hasDrawData &&
      result.drawData != [PBDraw defaultInstance]) {
    result.drawData =
      [[[PBDraw builderWithPrototype:result.drawData] mergeFrom:value] buildPartial];
  } else {
    result.drawData = value;
  }
  result.hasDrawData = YES;
  return self;
}
- (PBFeed_Builder*) clearDrawData {
  result.hasDrawData = NO;
  result.drawData = [PBDraw defaultInstance];
  return self;
}
- (BOOL) hasTargetUserId {
  return result.hasTargetUserId;
}
- (NSString*) targetUserId {
  return result.targetUserId;
}
- (PBFeed_Builder*) setTargetUserId:(NSString*) value {
  result.hasTargetUserId = YES;
  result.targetUserId = value;
  return self;
}
- (PBFeed_Builder*) clearTargetUserId {
  result.hasTargetUserId = NO;
  result.targetUserId = @"";
  return self;
}
- (BOOL) hasTargetUserNickName {
  return result.hasTargetUserNickName;
}
- (NSString*) targetUserNickName {
  return result.targetUserNickName;
}
- (PBFeed_Builder*) setTargetUserNickName:(NSString*) value {
  result.hasTargetUserNickName = YES;
  result.targetUserNickName = value;
  return self;
}
- (PBFeed_Builder*) clearTargetUserNickName {
  result.hasTargetUserNickName = NO;
  result.targetUserNickName = @"";
  return self;
}
- (BOOL) hasOpusId {
  return result.hasOpusId;
}
- (NSString*) opusId {
  return result.opusId;
}
- (PBFeed_Builder*) setOpusId:(NSString*) value {
  result.hasOpusId = YES;
  result.opusId = value;
  return self;
}
- (PBFeed_Builder*) clearOpusId {
  result.hasOpusId = NO;
  result.opusId = @"";
  return self;
}
- (BOOL) hasIsCorrect {
  return result.hasIsCorrect;
}
- (BOOL) isCorrect {
  return result.isCorrect;
}
- (PBFeed_Builder*) setIsCorrect:(BOOL) value {
  result.hasIsCorrect = YES;
  result.isCorrect = value;
  return self;
}
- (PBFeed_Builder*) clearIsCorrect {
  result.hasIsCorrect = NO;
  result.isCorrect = NO;
  return self;
}
- (BOOL) hasScore {
  return result.hasScore;
}
- (int32_t) score {
  return result.score;
}
- (PBFeed_Builder*) setScore:(int32_t) value {
  result.hasScore = YES;
  result.score = value;
  return self;
}
- (PBFeed_Builder*) clearScore {
  result.hasScore = NO;
  result.score = 0;
  return self;
}
- (NSArray*) guessWordsList {
  if (result.mutableGuessWordsList == nil) {
    return [NSArray array];
  }
  return result.mutableGuessWordsList;
}
- (NSString*) guessWordsAtIndex:(int32_t) index {
  return [result guessWordsAtIndex:index];
}
- (PBFeed_Builder*) replaceGuessWordsAtIndex:(int32_t) index with:(NSString*) value {
  [result.mutableGuessWordsList replaceObjectAtIndex:index withObject:value];
  return self;
}
- (PBFeed_Builder*) addGuessWords:(NSString*) value {
  if (result.mutableGuessWordsList == nil) {
    result.mutableGuessWordsList = [NSMutableArray array];
  }
  [result.mutableGuessWordsList addObject:value];
  return self;
}
- (PBFeed_Builder*) addAllGuessWords:(NSArray*) values {
  if (result.mutableGuessWordsList == nil) {
    result.mutableGuessWordsList = [NSMutableArray array];
  }
  [result.mutableGuessWordsList addObjectsFromArray:values];
  return self;
}
- (PBFeed_Builder*) clearGuessWordsList {
  result.mutableGuessWordsList = nil;
  return self;
}
- (BOOL) hasOpusStatus {
  return result.hasOpusStatus;
}
- (int32_t) opusStatus {
  return result.opusStatus;
}
- (PBFeed_Builder*) setOpusStatus:(int32_t) value {
  result.hasOpusStatus = YES;
  result.opusStatus = value;
  return self;
}
- (PBFeed_Builder*) clearOpusStatus {
  result.hasOpusStatus = NO;
  result.opusStatus = 0;
  return self;
}
- (BOOL) hasComment {
  return result.hasComment;
}
- (NSString*) comment {
  return result.comment;
}
- (PBFeed_Builder*) setComment:(NSString*) value {
  result.hasComment = YES;
  result.comment = value;
  return self;
}
- (PBFeed_Builder*) clearComment {
  result.hasComment = NO;
  result.comment = @"";
  return self;
}
- (BOOL) hasMatchTimes {
  return result.hasMatchTimes;
}
- (int32_t) matchTimes {
  return result.matchTimes;
}
- (PBFeed_Builder*) setMatchTimes:(int32_t) value {
  result.hasMatchTimes = YES;
  result.matchTimes = value;
  return self;
}
- (PBFeed_Builder*) clearMatchTimes {
  result.hasMatchTimes = NO;
  result.matchTimes = 0;
  return self;
}
- (BOOL) hasCorrectTimes {
  return result.hasCorrectTimes;
}
- (int32_t) correctTimes {
  return result.correctTimes;
}
- (PBFeed_Builder*) setCorrectTimes:(int32_t) value {
  result.hasCorrectTimes = YES;
  result.correctTimes = value;
  return self;
}
- (PBFeed_Builder*) clearCorrectTimes {
  result.hasCorrectTimes = NO;
  result.correctTimes = 0;
  return self;
}
- (BOOL) hasGuessTimes {
  return result.hasGuessTimes;
}
- (int32_t) guessTimes {
  return result.guessTimes;
}
- (PBFeed_Builder*) setGuessTimes:(int32_t) value {
  result.hasGuessTimes = YES;
  result.guessTimes = value;
  return self;
}
- (PBFeed_Builder*) clearGuessTimes {
  result.hasGuessTimes = NO;
  result.guessTimes = 0;
  return self;
}
- (BOOL) hasCommentTimes {
  return result.hasCommentTimes;
}
- (int32_t) commentTimes {
  return result.commentTimes;
}
- (PBFeed_Builder*) setCommentTimes:(int32_t) value {
  result.hasCommentTimes = YES;
  result.commentTimes = value;
  return self;
}
- (PBFeed_Builder*) clearCommentTimes {
  result.hasCommentTimes = NO;
  result.commentTimes = 0;
  return self;
}
@end
