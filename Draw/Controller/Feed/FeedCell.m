//
//  FeedCell.m
//  Draw
//
//  Created by  on 12-6-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FeedCell.h"
#import "TimeUtils.h"
#import "Feed.h"
#import "Draw.h"
#import "UserManager.h"
#import "ShareImageManager.h"
#import "StableView.h"
#import "ShowDrawView.h"
#import "DrawAction.h"
#import "FeedManager.h"


@implementation FeedCell
@synthesize guessStatLabel;
@synthesize descLabel;
@synthesize userNameLabel;
@synthesize timeLabel;
@synthesize actionButton;
@synthesize avatarView = _avatarView;
@synthesize drawView = _drawView;

#define AVATAR_VIEW_FRAME CGRectMake(4, 4, 31, 32)
#define SHOW_DRAW_VIEW_FRAME CGRectMake(220, 28, 70, 72)


+ (id)createCell:(id)delegate
{
    NSString* cellId = [self getCellIdentifier];
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:cellId owner:self options:nil];
    if (topLevelObjects == nil || [topLevelObjects count] <= 0){
        NSLog(@"create %@ but cannot find cell object from Nib", cellId);
        return nil;
    }
    FeedCell *cell = ((FeedCell*)[topLevelObjects objectAtIndex:0]);
    
    cell.delegate = delegate;
    
    if (cell) {
        ShareImageManager* imageManager = [ShareImageManager defaultManager];
        [cell.actionButton setBackgroundImage:[imageManager greenImage] forState:UIControlStateNormal];
        cell.drawView = [[[ShowDrawView alloc] initWithFrame:SHOW_DRAW_VIEW_FRAME]autorelease];
        [cell addSubview:cell.drawView];
        [cell.drawView setShowPenHidden:YES];
        cell.drawView.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}



+ (NSString*)getCellIdentifier
{
    return @"FeedCell";
}

+ (CGFloat)getCellHeight
{
    return 105.0f;
    
}


- (void)updateTime:(Feed *)feed
{
    NSString *timeString = dateToString(feed.createDate);
    [self.timeLabel setText:timeString];
}

- (void)updateDesc:(Feed *)feed
{
    NSString *desc = nil;
    if (feed.feedType == FeedTypeDraw) {
        desc = [NSString stringWithFormat:NSLS(@"kDrawDesc"),[FeedManager userNameForFeed:feed]];
    }else if (feed.feedType == FeedTypeGuess){
        if (feed.isCorrect) {
            desc = [NSString stringWithFormat:NSLS(@"kGuessRightDesc"),[FeedManager userNameForFeed:feed], [FeedManager opusCreatorForFeed:feed]];                    
        }else{
            desc = [NSString stringWithFormat:NSLS(@"kTryGuessDesc"),[FeedManager userNameForFeed:feed], [FeedManager opusCreatorForFeed:feed]];                    
        }
    }
    [self.descLabel setText:desc];
}

- (void)updateUser:(Feed *)feed
{
    //avatar
    [self.avatarView removeFromSuperview];
    self.avatarView = [[[AvatarView alloc] initWithUrlString:feed.avatar frame:AVATAR_VIEW_FRAME gender:feed.gender level:0] autorelease];
    [self addSubview:self.avatarView];
    
    //name
    [self.userNameLabel setText:[FeedManager userNameForFeed:feed]];
}

- (void)updateGuessDesc:(Feed *)feed
{
    if (feed.matchTimes == 0) {
        [self.guessStatLabel setText:NSLS(@"kNoGuess")];
    }else{
        NSInteger guessTimes = feed.matchTimes;
        NSInteger correctTimes = feed.correctTimes;
        NSString *desc = [NSString stringWithFormat:NSLS(@"kGuessStat"),guessTimes, correctTimes];
        [self.guessStatLabel setText:desc];        
    }
}




- (void)updateActionButton:(Feed *)feed
{
    self.actionButton.hidden = NO;
    ActionType type = [FeedManager actionTypeForFeed:feed];
    if (type == ActionTypeGuess) {
        [self.actionButton setTitle:NSLS(@"kIGuessAction") forState:UIControlStateNormal];
    }else if(type == ActionTypeOneMore)
    {
        [self.actionButton setTitle:NSLS(@"kOneMoreAction") forState:UIControlStateNormal];        
    }else{
        self.actionButton.hidden = YES;
    }
}


- (void)updateDrawView:(Feed *)feed
{
    [self.drawView cleanAllActions];
    CGRect normalFrame = DRAW_VEIW_FRAME;
    CGRect currentFrame = SHOW_DRAW_VIEW_FRAME;
    CGFloat xScale = currentFrame.size.width / normalFrame.size.width;
    CGFloat yScale = currentFrame.size.height / normalFrame.size.height;
    
    self.drawView.drawActionList = [DrawAction scaleActionList:feed.drawData.drawActionList xScale:xScale yScale:yScale];
    [self.drawView play];
}
- (void)setCellInfo:(Feed *)feed
{
    [self updateDesc:feed];
    [self updateTime:feed];
    [self updateUser:feed];
    [self updateGuessDesc:feed];
    [self updateActionButton:feed];
    [self updateDrawView:feed];
}


- (IBAction)clickActionButton:(id)sender {
    //
    
    if (delegate && [delegate respondsToSelector:@selector(didClickDrawOneMoreButtonAtIndexPath:)]) {
        [delegate didClickDrawOneMoreButtonAtIndexPath:self.indexPath];
    }
}

- (void)dealloc {
    [timeLabel release];
    [descLabel release];
    [userNameLabel release];
    [guessStatLabel release];
    [actionButton release];
    [_drawView release];
    [super dealloc];
}
@end
