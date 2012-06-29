//
//  CommonUserInfoView.m
//  Draw
//
//  Created by Orange on 12-6-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CommonUserInfoView.h"
#import "ShareImageManager.h"
#import "AnimationManager.h"
#import "LocaleUtils.h"
#import "Friend.h"
#import "StableView.h"
#import "DeviceDetection.h"
#import "FriendManager.h"
#import "CommonMessageCenter.h"
#import "UserFeedController.h"
#import "ChatDetailController.h"
#import "SelectWordController.h"
#import "LocaleUtils.h"
#import "WordManager.h"

#define RUN_OUT_TIME 0.2
#define RUN_IN_TIME 0.4

@implementation CommonUserInfoView
@synthesize backgroundImageView;
@synthesize mask;
@synthesize contentView;
@synthesize userName;
@synthesize snsTagImageView;
@synthesize genderLabel;
@synthesize locationLabel;
@synthesize playWithUserLabel;
@synthesize chatToUserLabel;
@synthesize drawToUserButton;
@synthesize exploreUserFeedButton;
@synthesize chatToUserButton;
@synthesize followUserButton;
@synthesize statusLabel;
@synthesize targetFriend = _targetFriend;
@synthesize superViewController = _superViewController;
@synthesize userId;
@synthesize userAvatar;
@synthesize userNickName;
@synthesize userLocation;
@synthesize userGender;
@synthesize hasQQ;
@synthesize hasSina;
@synthesize hasFacebook;
@synthesize userLevel;

- (void)dealloc {
    [backgroundImageView release];
    [mask release];
    [contentView release];
    [userName release];
    [snsTagImageView release];
    [genderLabel release];
    [locationLabel release];
    [playWithUserLabel release];
    [chatToUserLabel release];
    [drawToUserButton release];
    [exploreUserFeedButton release];
    [chatToUserButton release];
    [followUserButton release];
    [statusLabel release];
    [_superViewController release];
    [userAvatar release];
    [userNickName release];
    [userGender release];
    [userLocation release];
    [userId release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)initTitle
{
    [self.playWithUserLabel setText:NSLS(@"kPlayWithHim")];
    [self.chatToUserLabel setText:NSLS(@"kChatToHim")];
}

#define AVATAR_FRAME [DeviceDetection isIPAD]?CGRectMake(0, 0, 0, 0):CGRectMake(18, 46, 42, 42)
- (void)initAvatar
{
    CGRect rect = AVATAR_FRAME;
    AvatarView* view = [[AvatarView alloc] initWithUrlString:self.userAvatar
                                                       frame:rect
                                                      gender:([self.userGender isEqualToString:@"m"])
                                                       level:self.userLevel];
    [self.contentView addSubview:view];
}

- (void)initButton
{
    [self.chatToUserButton setTitle:NSLS(@"kChat") forState:UIControlStateNormal];
    [self.chatToUserButton setBackgroundImage:[ShareImageManager defaultManager].orangeImage forState:UIControlStateNormal];
    [self.drawToUserButton setTitle:NSLS(@"kDrawToHim") forState:UIControlStateNormal];
    [self.drawToUserButton setBackgroundImage:[ShareImageManager defaultManager].orangeImage forState:UIControlStateNormal];
    [self.exploreUserFeedButton setTitle:NSLS(@"kExploreHim") forState:UIControlStateNormal];
    [self.exploreUserFeedButton setBackgroundImage:[ShareImageManager defaultManager].orangeImage forState:UIControlStateNormal];
}

- (void)resetUserInfo
{
    [self.userName setText:self.userNickName];
    
    NSString* location = [LocaleUtils isTraditionalChinese]?[WordManager changeToTraditionalChinese:self.userLocation]:self.userLocation;
    [self.locationLabel setText:location];
    
    ShareImageManager *imageManager = [ShareImageManager defaultManager];
    if (hasSina) {
        self.snsTagImageView.hidden = NO;
        [self.snsTagImageView setImage:[imageManager sinaWeiboImage]];
    }else if (hasQQ){
        self.snsTagImageView.hidden = NO;
        [self.snsTagImageView setImage:[imageManager qqWeiboImage]];
    }else if (hasFacebook){
        self.snsTagImageView.hidden = NO;
        [self.snsTagImageView setImage:[imageManager facebookImage]];
    }else {
        self.snsTagImageView.hidden = YES;
    }
    
    NSString* gender = [self.userGender isEqualToString:@"m"]?NSLS(@"kMale"):NSLS(@"kFemale");
    [self.genderLabel setText:gender];
    
    [self initAvatar];
    
    //set followbutton or statusLabel
    [self.followUserButton setBackgroundImage:[[ShareImageManager defaultManager] normalButtonImage] forState:UIControlStateNormal];
    [self.followUserButton setTitle:NSLS(@"kAddAsFriend") forState:UIControlStateNormal];
    if ([[[UserManager defaultManager] userId] isEqualToString:self.userId]){
        statusLabel.hidden = NO;
        self.followUserButton.hidden = YES;
        statusLabel.text = NSLS(@"kMyself");
    }else if ([[FriendManager defaultManager] isFollowFriend:self.userId]) {
        statusLabel.hidden = NO;
        self.followUserButton.hidden = YES;
        statusLabel.text = NSLS(@"kAlreadyBeFriend");
    }
    else {
        statusLabel.hidden = YES;
        self.followUserButton.hidden = NO; 
    }
}


- (void)initView
{
    [self.backgroundImageView setImage:[ShareImageManager defaultManager].friendDetailBgImage];
    [self initTitle];
    [self initButton];
    [self resetUserInfo];
    
}

- (void)initViewWithFriend:(Friend*)aFriend
{  
    [self initViewWithUserId:aFriend.friendUserId 
                    nickName:aFriend.nickName 
                      avatar:aFriend.avatar 
                      gender:aFriend.gender 
                     hasSina:(aFriend.sinaNick == nil) 
                       hasQQ:(aFriend.qqNick == nil) 
                 hasFacebook:(aFriend.facebookNick == nil) ];
}

- (void)initViewWithUserId:(NSString*)aUserId 
                  nickName:(NSString*)nickName 
                    avatar:(NSString*)avatar 
                    gender:(NSString*)aGender 
                   hasSina:(BOOL)didHasSina 
                     hasQQ:(BOOL)didHasQQ 
               hasFacebook:(BOOL)didHasFacebook
{
    
    
    self.userId = aUserId;
    self.userNickName = nickName;
    self.userAvatar = avatar;
    self.userGender = aGender;
    self.hasQQ = didHasQQ;
    self.hasSina = didHasSina;
    self.hasFacebook = didHasFacebook;
    
    [self initView];
}

+ (CommonUserInfoView*)createUserInfoView
{
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CommonUserInfoView" owner:self options:nil];
    if (topLevelObjects == nil || [topLevelObjects count] <= 0){
        NSLog(@"create <CommonUserInfoView> but cannot find cell object from Nib");
        return nil;
    }
    CommonUserInfoView* view =  (CommonUserInfoView*)[topLevelObjects objectAtIndex:0];
    
    CAAnimation *runIn = [AnimationManager scaleAnimationWithFromScale:0.1 toScale:1 duration:RUN_IN_TIME delegate:self removeCompeleted:NO];
    [view.contentView.layer addAnimation:runIn forKey:@"runIn"];
    
    return view;
}

+ (void)showUser:(Friend*)afriend 
      infoInView:(PPViewController<FriendServiceDelegate>*)superController
{
    CommonUserInfoView* view = [CommonUserInfoView createUserInfoView];
    [view initViewWithFriend:afriend];
    view.superViewController = superController;
    [superController.view addSubview:view];
}

+ (void)showUser:(NSString*)userId 
        nickName:(NSString*)nickName 
          avatar:(NSString*)avatar 
          gender:(NSString*)aGender 
         hasSina:(BOOL)didHasSina 
           hasQQ:(BOOL)didHasQQ 
     hasFacebook:(BOOL)didHasFacebook
      infoInView:(PPViewController*)superController
{
    if (![[[UserManager defaultManager] userId] isEqualToString:userId]) {
        CommonUserInfoView* view = [CommonUserInfoView createUserInfoView];
        [view initViewWithUserId:userId 
                        nickName:nickName 
                          avatar:avatar 
                          gender:aGender 
                         hasSina:didHasSina 
                           hasQQ:didHasQQ 
                     hasFacebook:didHasFacebook];
        view.superViewController = superController;
        [superController showActivity];
        [[UserService defaultService] getUserSimpleInfoByUserId:userId delegate:view];
        //[superController.view addSubview:view];
    }
    
}

- (void)startRunOutAnimation
{
    CAAnimation *runOut = [AnimationManager scaleAnimationWithFromScale:1 toScale:0.1 duration:RUN_OUT_TIME delegate:self removeCompeleted:NO];
    [runOut setValue:@"runOut" forKey:@"AnimationKey"];
    [self.contentView.layer addAnimation:runOut forKey:@"runOut"];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSString* value = [anim valueForKey:@"AnimationKey"];
    if ([value isEqualToString:@"runOut"]) {
        [self setHidden:YES];
        [self removeFromSuperview];
    }
}

- (IBAction)clickMask:(id)sender
{
    [self startRunOutAnimation];
}

- (IBAction)clickFollowButton:(id)sender
{
    [[FriendService defaultService] followUser:self.userId withDelegate:self];
    [self.superViewController showActivityWithText:NSLS(@"kFollowing")];
}

- (void)didFollowUser:(int)resultCode
{
    [self.superViewController hideActivity];
    if (resultCode) {
        [[CommonMessageCenter defaultCenter] postMessageWithText:NSLS(@"kFollowFailed")
                                                       delayTime:1.5 
                                                         isHappy:NO];        
    } else {        
        [[CommonMessageCenter defaultCenter] postMessageWithText:NSLS(@"kFollowSuccessfully")
                                                       delayTime:1.5 
                                                         isHappy:YES];
        [self.followUserButton setHidden:YES];
        [self.statusLabel setText:NSLS(@"kAlreadyBeFriend")];
    }
}

- (IBAction)drawToHim:(id)sender
{
    [SelectWordController startSelectWordFrom:self.superViewController targetUid:self.userId];
}

- (IBAction)talkToHim:(id)sender
{
    ChatDetailController *controller = [[ChatDetailController alloc] initWithFriendUserId:self.userId
                                                                           friendNickname:self.userNickName
                                                                             friendAvatar:self.userAvatar
                                                                             friendGender:self.userGender];
    [self.superViewController.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (IBAction)seeHisFeed:(id)sender
{
    UserFeedController *userFeed = [[UserFeedController alloc] initWithUserId:self.userId nickName:self.userNickName];
    [self.superViewController.navigationController pushViewController:userFeed animated:YES];
    [userFeed release];
}

#pragma mark - user service delegate
- (void)didGetUserNickName:(NSString*)nickName
                UserAvatar:(NSString*)avatar
                UserGender:(NSString*)gender
              UserLocation:(NSString*)location 
                 UserLevel:(NSString*)level 
                  SinaNick:(NSString*)sinaNick 
                    QQNick:(NSString*)qqNick 
                FacebookId:(NSString*)facebookId
{
    if (nickName != nil) {
        self.userNickName = nickName;
    }
    
    if (avatar != nil) {
        self.userAvatar = avatar;
    }
    
    if (gender != nil) {
        self.userGender = gender;
    }
    
    if (location != nil) {
        self.userLocation = location;
    }
    
    if (level != nil) {
        self.userLevel = level.intValue;
    }
    
    if (sinaNick != nil) {
        self.hasSina = YES;
    }
    
    if (qqNick != nil) {
        self.hasQQ = YES;
    }
    
    if (facebookId != nil) {
        self.hasFacebook = YES;
    }
    [self resetUserInfo];
    [self.superViewController hideActivity];
    [self.superViewController.view addSubview:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


@end
