//
//  NotificationManager.m
//  Draw
//
//  Created by  on 12-6-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NotificationManager.h"
#import "LocaleUtils.h"
#import "CustomStatueBar.h"
#import "AudioManager.h"
#import "DrawConstants.h"
#import "DeviceDetection.h"

#pragma mark - inner class Status message

@interface StatusMessage : NSObject {
    NSInteger _type;
    NSInteger _count;
}
@property(nonatomic, assign)NSInteger type;
@property(nonatomic, assign)NSInteger count;
- (id)initWithType:(NSInteger)type count:(NSInteger)count;
- (NSString *)description;
@end

@implementation StatusMessage
@synthesize type = _type;
@synthesize count = _count;

- (id)initWithType:(NSInteger)type count:(NSInteger)count
{
    self = [super init];
    if (self) {
        self.type = type;
        self.count = count;
    }
    return self;
}

- (NSString *)description
{
    switch (self.type) {
        case NotificationTypeFan:
            return [NSString stringWithFormat:NSLS(@"kFanStatus"),self.count];
        case NotificationTypeFeed:
            return [NSString stringWithFormat:NSLS(@"kFeedStatus"),self.count];
        case NotificationTypeRoom:
            return [NSString stringWithFormat:NSLS(@"kRoomStatus"),self.count];
        case NotificationTypeMessage:
            return [NSString stringWithFormat:NSLS(@"kMessageStatus"),self.count];
        default:
            return nil;
    }
}

@end


#pragma mark - Notification Manager

NotificationManager *_staticNotificationManager = nil;

@interface NotificationManager()
{
//    NSMutableArray *statusArray;
    CustomStatueBar *statueBar;
    StatusMessage *statusMessage;
}
@end

@implementation NotificationManager

#define PUSH_TYPE (@"PT")

#define FAN_BADGE  @"FAB"
#define MESSAGE_BADGE  @"MB"
#define FEED_BADGE  @"FEB"
#define ROOM_BADGE  @"RB"


+ (NotificationManager *)defaultManager
{
    if (_staticNotificationManager == nil) {
        _staticNotificationManager = [[NotificationManager alloc] init];
    }
    return _staticNotificationManager;
}

#define OFFSET ([DeviceDetection isIPAD] ? 0 : 0 )
#define WIDTH ([DeviceDetection isIPAD] ? 768  : 320 )

- (id)init
{
    self = [super init];
    if (self) {
//        statusArray = [[NSMutableArray alloc] init];
        statueBar = [[CustomStatueBar alloc] initWithFrame:CGRectMake(OFFSET, 0, WIDTH-OFFSET, 20)];
        [statueBar setBackgroundColor:[UIColor blackColor]];
        statueBar.hidden = YES;
        statusMessage = [[StatusMessage alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [statusMessage release];
    [statueBar release];
    [super dealloc];
}

- (void)showNotification:(NSDictionary *)notification
{
    NotificationType type = [NotificationManager typeForUserInfo:notification];
    int count = [NotificationManager badgeForType:type withNotification:notification];
    count = (count == 0 ? 1 : count );
    statusMessage.type = type;
    statusMessage.count = count;
    [statueBar changeMessge:statusMessage.description];
    [[AudioManager defaultManager] playSoundById:CLICK_WORD];
    [[AudioManager defaultManager] vibrate];
    
}

- (void)hideNotification
{
    [statueBar hide];
}
- (void)hideNotificationForType:(NotificationType)type
{
    if (statusMessage.type == type) {
        [statueBar hide];
    }
}

+ (int)intValueOfUserInfo:(NSDictionary *)userInfo forKey:(NSString *)key
{
    if (key == nil || userInfo == nil) {
        return 0;
    }
    NSNumber *value = [userInfo objectForKey:key];
    if (value) {
        return value.intValue;
    }
    return 0;    
}

+ (NotificationType) typeForUserInfo:(NSDictionary *)userInfo
{
    NSNumber *type = [userInfo objectForKey:PUSH_TYPE];
    if (type) {
        return type.integerValue;
    }
    return NotificationTypeNone;
}

+ (int)badgeForType:(NotificationType)type withNotification:(NSDictionary *)notification
{
    switch (type) {
        case NotificationTypeFan:
            return [NotificationManager fanBadge:notification];
        case NotificationTypeRoom:
            return [NotificationManager roomBadge:notification];
        case NotificationTypeMessage:
            return [NotificationManager messageBadge:notification];
        case NotificationTypeFeed:
            return [NotificationManager feedBadge:notification];
        default:
            return 0;
    }
}

+ (int)feedBadge:(NSDictionary *)userInfo
{
    return [NotificationManager intValueOfUserInfo:userInfo forKey:FEED_BADGE];
}
+ (int)fanBadge:(NSDictionary *)userInfo
{
    return [NotificationManager intValueOfUserInfo:userInfo forKey:FAN_BADGE];    
}
+ (int)roomBadge:(NSDictionary *)userInfo
{
    return [NotificationManager intValueOfUserInfo:userInfo forKey:ROOM_BADGE];
}
+ (int)messageBadge:(NSDictionary *)userInfo
{
    return [NotificationManager intValueOfUserInfo:userInfo forKey:MESSAGE_BADGE];
}


@end
