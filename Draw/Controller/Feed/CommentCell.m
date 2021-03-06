//
//  CommentCell.m
//  Draw
//
//  Created by  on 12-6-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CommentCell.h"
#import "TimeUtils.h"
#import "LocaleUtils.h"
#import "DeviceDetection.h"
#import "LocaleUtils.h"
#import "WordManager.h"
#import "CommonUserInfoView.h"
#import "ShareImageManager.h"


@implementation CommentCell
@synthesize commentLabel;
@synthesize timeLabel;
@synthesize nickNameLabel;
@synthesize itemImage;

+ (id)createCell:(id)delegate
{
    NSString* cellId = [self getCellIdentifier];
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:cellId owner:self options:nil];
    if (topLevelObjects == nil || [topLevelObjects count] <= 0){
        return nil;
    }
    
    ((PPTableViewCell*)[topLevelObjects objectAtIndex:0]).delegate = delegate;
    
    return [topLevelObjects objectAtIndex:0];
}

+ (NSString*)getCellIdentifier
{
    return @"CommentCell";
}


#define COMMENT_WIDTH ([DeviceDetection isIPAD] ? 550 : 209)
#define COMMENT_FONT_SIZE ([DeviceDetection isIPAD] ? 11*2 : 11)
#define COMMENT_SPACE ([DeviceDetection isIPAD] ? 20 : 10)
#define COMMENT_BASE_X ([DeviceDetection isIPAD] ? 102 : 44)
#define COMMENT_BASE_Y ([DeviceDetection isIPAD] ? 64 : 30)

#define COMMENT_ITEM_HEIGHT ([DeviceDetection isIPAD] ? 120 : 60)

#define AVATAR_VIEW_FRAME [DeviceDetection isIPAD] ? CGRectMake(11, 14, 71, 74) : CGRectMake(5, 9, 31, 32)


+ (CGFloat)getCellHeight:(CommentFeed *)feed
{
    if (feed.feedType == ItemTypeFlower || feed.feedType == ItemTypeTomato) {
        return COMMENT_ITEM_HEIGHT;
    }
    NSString *comment = [feed comment];
    UIFont *font = [UIFont systemFontOfSize:COMMENT_FONT_SIZE];
    CGSize commentSize = [comment sizeWithFont:font constrainedToSize:CGSizeMake(COMMENT_WIDTH, 10000000) lineBreakMode:UILineBreakModeCharacterWrap];
    int height = COMMENT_BASE_Y + COMMENT_SPACE + commentSize.height;
    return height;
}

#define SHOW_COMMENT_COUNT 3

- (void)setCellInfo:(CommentFeed *)feed;
{
    //set avatar
    FeedUser *author = feed.author;
    [_avatarView removeFromSuperview];
    _avatarView = [[AvatarView alloc] initWithUrlString:author.avatar 
                                                  frame:AVATAR_VIEW_FRAME 
                                                 gender:author.gender 
                                                  level:0];
    _avatarView.delegate = self;
    _avatarView.userId = feed.author.userId;
    [self addSubview:_avatarView];
    [_avatarView release];
    
    //set times
    NSString *timeString = nil;
    if ([LocaleUtils isChinese]) {
        timeString = chineseBeforeTime(feed.createDate);
    } else {
        timeString = englishBeforeTime(feed.createDate);
    }
    
    if (timeString) {
        [self.timeLabel setText:timeString];
    }else {
        NSString *formate = @"yy-MM-dd HH:mm";
        timeString = dateToStringByFormat(feed.createDate, formate);
        [self.timeLabel setText:timeString];
    }
    
     NSString *comment = [feed comment];
    //set user name
    [self.nickNameLabel setText:author.nickName];
    
    itemImage.hidden = YES;
    commentLabel.hidden = NO;
    if (feed.feedType == ItemTypeFlower) {
        itemImage.hidden = NO;
        [itemImage setImage:[[ShareImageManager defaultManager] flower]];
        
    }else if(feed.feedType == ItemTypeTomato)
    {
        itemImage.hidden = NO;
        [itemImage setImage:[[ShareImageManager defaultManager] tomato]];
    }
        
    //set comment

    UIFont *font = [UIFont systemFontOfSize:COMMENT_FONT_SIZE];
    CGSize commentSize = [comment sizeWithFont:font constrainedToSize:CGSizeMake(COMMENT_WIDTH, 10000000) lineBreakMode:UILineBreakModeCharacterWrap];
    
    self.commentLabel.frame = CGRectMake(COMMENT_BASE_X, COMMENT_BASE_Y, COMMENT_WIDTH,commentSize.height);
        
    [self.commentLabel setText:[NSString stringWithFormat:@"%@", comment]];
    [self.commentLabel setFont:font];
    
    
}



- (void)dealloc {
    PPRelease(commentLabel);
    PPRelease(timeLabel);
    PPRelease(nickNameLabel);
    [itemImage release];
    [super dealloc];
}

#pragma mark - avatar view delegate
- (void)didClickOnAvatar:(NSString *)userId
{
    [CommonUserInfoView showUser:userId 
                        nickName:nil 
                          avatar:nil 
                          gender:nil 
                        location:nil 
                           level:1
                         hasSina:NO 
                           hasQQ:NO 
                     hasFacebook:NO 
                      infoInView:self.delegate];
}
@end
