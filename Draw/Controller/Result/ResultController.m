//
//  ResultController.m
//  Draw
//
//  Created by  on 12-3-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ResultController.h"
#import "HomeController.h"
#import "RoomController.h"
#import "DrawGameService.h"
#import "GameConstants.h"
#import "MyPaint.h"
#import "MyPaintManager.h"
#import "PPDebug.h"
#import "GameSession.h"
#import "GameTurn.h"
#import "ShareImageManager.h"
#import "LocaleUtils.h"
#import "AccountService.h"
#import "Account.h"
#import "DrawAction.h"
#import "WordManager.h"
#import "AudioManager.h"
#import "DrawConstants.h"
#import "AnimationManager.h"
#import "CommonMessageCenter.h"
#import "FeedController.h"
#import "FeedDetailController.h"
#import "OfflineGuessDrawController.h"
#import "DrawDataService.h"
#import "ShareService.h"
#import "AdService.h"
#import "UIButtonExt.h"
#import "FeedService.h"
#import "DeviceDetection.h"
#import "DrawGameAnimationManager.h"
#import "ItemManager.h"
#import "ItemShopController.h"
#import "AccountManager.h"
#import "ConfigManager.h"
#import "ItemService.h"
#import "VendingController.h"
#import "Feed.h"

#define CONTINUE_TIME 10

#define TOMATO_TOOLVIEW_TAG 20120718
#define FLOWER_TOOLVIEW_TAG 120120718

#define ITEM_FRAME  ([DeviceDetection isIPAD]?CGRectMake(0, 0, 122, 122):CGRectMake(0, 0, 61, 61))

#define MAX_TOMATO 10
#define MAX_FLOWER 10


@interface ResultController()

//- (BOOL)fromFeedDetailController;
//- (BOOL)fromFeedController;
- (BOOL)throwItem:(ToolView*)toolView;
- (void)receiveFlower;
- (void)receiveTomato;


@end

@implementation ResultController
@synthesize drawImage;
@synthesize upButton;
@synthesize downButton;
@synthesize continueButton;
@synthesize saveButton;
@synthesize wordText;
@synthesize score;
@synthesize wordLabel;
@synthesize scoreLabel;
@synthesize whitePaper;
@synthesize resultLabel;
@synthesize drawActionList = _drawActionList;
@synthesize drawUserId = _drawUserId;
@synthesize drawUserNickName = _drawUserNickName;
@synthesize adView = _adView;
@synthesize experienceLabel;
@synthesize titleLabel;
@synthesize upLabel;
@synthesize downLabel;
@synthesize backButton;
//@synthesize resultType = _resultType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
    [[WordManager defaultManager] clearWordBaseDictionary];
    
}


- (id)initWithImage:(UIImage *)image 
         drawUserId:(NSString *)drawUserId
   drawUserNickName:(NSString *)drawUserNickName
           wordText:(NSString *)aWordText 
              score:(NSInteger)aScore 
            correct:(BOOL)correct 
          isMyPaint:(BOOL)isMyPaint 
     drawActionList:(NSArray *)drawActionList;

{
    self = [super init];
    if (self) {
        _image = image;
        [_image retain];
        self.wordText = aWordText;
        self.score = aScore;
        _correct = correct;
        _isMyPaint = isMyPaint;
        self.drawActionList = [NSArray arrayWithArray:drawActionList];
        
        self.drawUserNickName = drawUserNickName;
        self.drawUserId = drawUserId;        
        
        drawGameService = [DrawGameService defaultService];
    }
    return self;
}

- (id)initWithImage:(UIImage *)image 
         drawUserId:(NSString *)drawUserId
   drawUserNickName:(NSString *)drawUserNickName
           wordText:(NSString *)aWordText 
              score:(NSInteger)aScore 
            correct:(BOOL)correct 
          isMyPaint:(BOOL)isMyPaint 
     drawActionList:(NSArray *)drawActionList 
               feed:(Feed *)feed

{
    self = [self initWithImage:image 
                    drawUserId:drawUserId 
              drawUserNickName:drawUserNickName 
                      wordText:aWordText 
                         score:aScore 
                       correct:correct 
                     isMyPaint:isMyPaint 
                drawActionList:drawActionList];
    _feed = feed;
    return self;
}

- (void)updateContinueButton:(NSInteger)count
{
    [self.continueButton setTitle:[NSString stringWithFormat:NSLS(@"kContinue"),count] forState:UIControlStateNormal];
}

- (void)resetTimer
{
    if (continueTimer && [continueTimer isValid]) {
            [continueTimer invalidate];
    }
    continueTimer = nil;
    retainCount = CONTINUE_TIME;
}

- (void)handleContinueTimer:(NSTimer *)theTimer
{
    PPDebug(@"<ResultController> handle timer");    
    
    -- retainCount;
    if (retainCount <= 0) {
        retainCount = 0;
        [self clickContinueButton:nil];
        return;
    }
    [self updateContinueButton:retainCount];
}

- (void)startTimer
{
    [self resetTimer];
    continueTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleContinueTimer:) userInfo:nil repeats:YES];
}

- (void)setUpAndDownButtonEnabled:(BOOL)enabled
{
    [upButton setEnabled:enabled];
    [downButton setEnabled:enabled];
}


- (BOOL)fromFeedDetailController
{
    return [self hasSuperViewControllerForClass:[FeedDetailController class]];
}
//- (BOOL)fromFeedController
//{
//    return [self hasSuperViewControllerForClass:[FeedController class]];
//}
- (BOOL)fromOfflineGuessController
{
    return [self hasSuperViewControllerForClass:[OfflineGuessDrawController class]];
}

- (void)initResultType
{
    if([self fromFeedDetailController]){
        _resultType = FeedGuess;
        [self.backButton setImage:[ShareImageManager defaultManager].backButtonImage forState:UIControlStateNormal];
        [self.backButton setCenter:CGPointMake(self.view.frame.size.width - self.backButton.center.x, self.backButton.center.y)];
    }
    else if ([self fromOfflineGuessController]) 
    {
        _resultType = OfflineGuess;
        [self.backButton setImage:[ShareImageManager defaultManager].backButtonImage forState:UIControlStateNormal];
        [self.backButton setCenter:CGPointMake(self.view.frame.size.width - self.backButton.center.x, self.backButton.center.y)];
    }else if(_isMyPaint){
        _resultType = OnlineDraw;
    }else{
        _resultType = OnlineGuess;
    }

}

- (void)initTitleLabel
{
    if (_resultType == OnlineDraw || _resultType == OnlineDraw) {
        [titleLabel setText:NSLS(@"kOnlineResultTitle")];
    }else{
        [titleLabel setText:NSLS(@"kOfflineResultTitle")];        
    }
}

- (void)initDrawImage
{
    ShareImageManager *shareImageManager = [ShareImageManager defaultManager];
    [self.whitePaper setImage:[shareImageManager whitePaperImage]];
    [self.drawImage setImage:_image];
}

- (void)initScore
{
    //init score
    [self.scoreLabel setText:[NSString stringWithFormat:@"+ %d",self.score]];
    //add score
    if (self.score > 0) {
        BalanceSourceType type = (_isMyPaint) ? DrawRewardType : GuessRewardType;
        [[AccountService defaultService] chargeAccount:self.score source:type];    
        
        [[AudioManager defaultManager] playSoundById:GAME_WIN];
    }

    //init experience.
    NSInteger exp = 0;
    if (_isMyPaint) {
        exp = DRAWER_EXP;
    }else{
        exp = NORMAL_EXP;
    }
    [[LevelService defaultService] addExp:exp delegate:self];
    [self.experienceLabel setText:[NSString stringWithFormat:@"+ %d",exp]];
}

- (void)initAnswer
{
    NSString *answer = nil;
    if (self.wordText) {
        answer = self.wordText;        
        if ([LocaleUtils isTraditionalChinese]) {
            answer = [WordManager changeToTraditionalChinese:answer];
        }
    }else{
        answer = NSLS(@"kNoWord");
    }
    
    [self.wordLabel setText:answer];

}

- (void)initResultLabel
{
    if (_isMyPaint) {
        [self.resultLabel setText:NSLS(@"kTurnResult")];   
    }else if (_correct) {
        [self.resultLabel setText:NSLS(@"kCongratulations")];        
    }else{
        [self.resultLabel setText:NSLS(@"kPity")];
    }
}

- (void)initToolViews
{
    ToolView* tomato = [[[ToolView alloc] initWithItemType:ItemTypeTomato number:[[ItemManager defaultManager] amountForItem:ItemTypeTomato]] autorelease];
    ToolView* flower = [[[ToolView alloc] initWithItemType:ItemTypeFlower number:[[ItemManager defaultManager] amountForItem:ItemTypeFlower]] autorelease];
    tomato.tag = TOMATO_TOOLVIEW_TAG;
    flower.tag = FLOWER_TOOLVIEW_TAG;
    [self.view addSubview:tomato];
    [self.view addSubview:flower];
    [tomato setCenter:downButton.center];
    [flower setCenter:upButton.center];
    [tomato addTarget:self action:@selector(clickDownButton:)];
    [flower addTarget:self action:@selector(clickUpButton:)];
    [flower setFrame:upButton.frame];
    [tomato setFrame:downButton.frame];
    
}
- (void)initActionButton
{
    //init the up & down button
    if (_resultType != OnlineDraw) {
        [self initToolViews];
        [upLabel setText:NSLS(@"kThrowFlower")];
        [downLabel setText:NSLS(@"kThrowTomato")];
        upButton.hidden = YES;
        downButton.hidden = YES;
    }else{
        upButton.hidden = downButton.hidden = YES;
        upLabel.hidden = downLabel.hidden = YES;
        continueButton.frame = upButton.frame;
    }
    
    //init the continue button
    if (_resultType == OnlineDraw || _resultType == OnlineGuess) {
        [self startTimer];        
        [self updateContinueButton:retainCount];     
    }else if(_resultType == OfflineGuess)
    {
        [self.continueButton setTitle:NSLS(@"kOneMore") forState:UIControlStateNormal];
    }else{
        continueButton.hidden = YES;
        downButton.center = CGPointMake(self.view.frame.size.width/2, downButton.center.y);
        ToolView* tomatoToolView = (ToolView*)[self.view viewWithTag:TOMATO_TOOLVIEW_TAG];
        [tomatoToolView setCenter:CGPointMake(downButton.center.x, tomatoToolView.center.y)];
        [downLabel setCenter:CGPointMake(downButton.center.x, downLabel.center.y)];
    }
    
    //init the share button
    [self.saveButton setTitle:NSLS(@"kSaveAndShare") forState:UIControlStateNormal];
    
    
    [self.saveButton centerImageAndTitle:-1];
    [self.continueButton centerImageAndTitle:-1];
    [self.upButton centerImageAndTitle:-1];
    [self.downButton centerImageAndTitle:-1];
    
    _maxFlower = MAX_FLOWER;
    _maxTomato = MAX_TOMATO;
        
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{        
    
    [super viewDidLoad];
    [self initResultType];
    [self initTitleLabel];
    [self initDrawImage];
    [self initScore];
    [self initResultLabel];
    [self initActionButton];
    [self initAnswer];   
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [[DrawGameService defaultService] unregisterObserver:self];
    
    [[AdService defaultService] clearAdView:_adView];
    [self setAdView:nil];

    [super viewDidDisappear:animated];
        
}
- (void)viewDidAppear:(BOOL)animated
{
    [[DrawGameService defaultService] registerObserver:self];    
    
    [super viewDidAppear:animated];

    if (self.adView == nil){
        self.adView = [[AdService defaultService] createAdInView:self 
                                                           frame:CGRectMake(0, 47, 320, 50) 
                                                       iPadFrame:CGRectMake(224, 780, 320, 50)
                                                         useLmAd:NO];   
    }        
}

- (void)viewDidUnload
{    
    
    [[AdService defaultService] clearAdView:_adView];
    [self setAdView:nil];    
    
    [self setUpButton:nil];
    [self setDownButton:nil];
    [self setContinueButton:nil];
    [self setSaveButton:nil];
    [self setDrawImage:nil];
    _image = nil;
    [self setWordLabel:nil];
    [self setScoreLabel:nil];
    [self setWhitePaper:nil];
    [self setResultLabel:nil];
    [self setExperienceLabel:nil];
    [self setTitleLabel:nil];
    [self setUpLabel:nil];
    [self setDownLabel:nil];
    [self setBackButton:nil];
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {

    [[AdService defaultService] clearAdView:_adView];
    PPRelease(_adView);
    
    PPRelease(_drawUserId);
    PPRelease(_drawUserNickName);
    PPRelease(upButton);
    PPRelease(downButton);
    PPRelease(continueButton);
    PPRelease(saveButton);
    PPRelease(drawImage);
    PPRelease(_image);
    PPRelease(wordText);
    PPRelease(wordLabel);
    PPRelease(scoreLabel);
    PPRelease(whitePaper);
    PPRelease(resultLabel);
    PPRelease(_drawActionList);
    [experienceLabel release];
    [titleLabel release];
    [upLabel release];
    [downLabel release];
    [backButton release];
    [super dealloc];
}

- (BOOL)isOffline
{
    return (_resultType == OfflineGuess || _resultType == FeedGuess);
}

- (IBAction)clickUpButton:(id)sender {
    
    ToolView* toolView = (ToolView*)sender;    
    
    // show animation
    if (![self throwItem:toolView]) 
        return;
        
    // send request
    [[ItemService defaultService] sendItemAward:toolView.itemType
                                   targetUserId:_drawUserId
                                      isOffline:[self isOffline] 
                                     feedOpusId:_feed.feedId
                                     feedAuthor:_feed.author.userId];  

    // update UI
    [self setUpAndDownButtonEnabled:NO];
    [toolView decreaseNumber];
    if (--_maxFlower <= 0) {
        [toolView setEnabled:NO];
    }
}

- (IBAction)clickDownButton:(id)sender {

    ToolView* toolView = (ToolView*)sender;    
    
    // throw item animation
    if (![self throwItem:toolView]) 
        return;

    // send request
    [[ItemService defaultService] sendItemAward:toolView.itemType
                                   targetUserId:_drawUserId
                                      isOffline:[self isOffline]
                                     feedOpusId:_feed.feedId
                                     feedAuthor:_feed.author.userId];
    
    // update UI
    [self setUpAndDownButtonEnabled:NO];
    [toolView decreaseNumber];
    if (--_maxTomato <= 0) {
        [toolView setEnabled:NO];
    }
}

- (IBAction)clickContinueButton:(id)sender {
    
    
    if (_resultType == OfflineGuess) {
        [self showActivityWithText:NSLS(@"kLoading")];
        [[DrawDataService defaultService] matchDraw:self];
    }else{
        [self resetTimer];
        if ([drawGameService sessionStatus] == SESSION_WAITING) {
            [RoomController returnRoom:self startNow:NO];        
        }else{
            [RoomController returnRoom:self startNow:YES];
        }
    }

}

- (IBAction)clickSaveButton:(id)sender {

    if (_isMyPaint == NO){
        [[FeedService defaultService] actionSaveOpus:_feed.feedId
                                          actionName:DB_FIELD_ACTION_SAVE_TIMES];
    }
    
    [[ShareService defaultService] shareWithImage:_image drawUserId:_drawUserId isDrawByMe:_isMyPaint drawWord:wordText];    
    
    [[DrawDataService defaultService] saveActionList:self.drawActionList userId:_drawUserId nickName:_drawUserNickName isMyPaint:_isMyPaint word:self.wordText image:_image viewController:self];
    self.saveButton.enabled = NO;
    self.saveButton.selected = YES;
}

- (IBAction)clickExitButton:(id)sender {
    
    UIViewController *viewController = [self superViewControllerForClass:[FeedDetailController class]];
    
    if (viewController) {
        [self.navigationController popToViewController:viewController animated:YES];
    }else{
        if ([[DrawGameService defaultService] session] != nil){
            [[DrawGameService defaultService] quitGame];
        }
        [HomeController returnRoom:self];
    }
    
}

- (void)didReceiveRank:(NSNumber*)rank fromUserId:(NSString*)userId
{        
    if (rank.integerValue == RANK_TOMATO) {
        PPDebug(@"%@ give you an tomato", userId);
        [[ItemService defaultService] receiveItem:ItemTypeTomato];
        [self receiveTomato];
    }else{
        PPDebug(@"%@ give you a flower", userId);
        [[ItemService defaultService] receiveItem:ItemTypeFlower];
        [self receiveFlower];
    }
    
    // TODO show animation here
}

#pragma mark - LevelServiceDelegate

- (void)levelUp:(int)level
{
//    [[CommonMessageCenter defaultCenter] postMessageWithText:[NSString stringWithFormat:NSLS(@"kUpgradeMsg"),level] delayTime:1.5 isHappy:YES];
    [AnimationManager fireworksAnimationAtView:self.view];
}


#pragma mark - draw data service delegate
- (void)didMatchDraw:(DrawFeed *)feed result:(int)resultCode
{
    [self hideActivity];
    if (resultCode == 0 && feed) {
        [HomeController startOfflineGuessDraw:feed from:self];
    }else{
        CommonMessageCenter *center = [CommonMessageCenter defaultCenter];
        [center postMessageWithText:NSLS(@"kMathOpusFail") delayTime:1.5 isHappy:NO];
    }
}

#pragma mark - throw item animation
#define ITEM_TAG_OFFSET 20120728
- (BOOL)throwItem:(ToolView*)toolView
{
    if([[ItemManager defaultManager] hasEnoughItem:toolView.itemType] == NO){
        //TODO go the shopping page.
        CommonDialog *dialog = [CommonDialog createDialogWithTitle:NSLS(@"kNoItemTitle") message:NSLS(@"kNoItemMessage") style:CommonDialogStyleDoubleButton delegate:self];
        dialog.tag = ITEM_TAG_OFFSET + toolView.itemType;
        [dialog showInView:self.view];
        return NO;
    }
    UIImageView* item = [[[UIImageView alloc] initWithFrame:ITEM_FRAME] autorelease];
    [self.view addSubview:item];
    [item setImage:toolView.imageView.image];
    if (toolView.itemType == ItemTypeTomato) {
        [DrawGameAnimationManager showThrowTomato:item animInController:self];
    }
    if (toolView.itemType == ItemTypeFlower) {
        [DrawGameAnimationManager showThrowFlower:item animInController:self];
    }
    return YES;
}

- (void)receiveFlower
{
    UIImageView* item = [[[UIImageView alloc] initWithFrame:ITEM_FRAME] autorelease];
    [self.view addSubview:item];
    [item setImage:[ShareImageManager defaultManager].flower];
    [DrawGameAnimationManager showReceiveFlower:item animationInController:self];
    //[self popupMessage:[NSString stringWithFormat:NSLS(@"kReceiveFlowerMessage"),REWARD_EXP, REWARD_COINS] title:nil];
}
- (void)receiveTomato
{
    UIImageView* item = [[[UIImageView alloc] initWithFrame:ITEM_FRAME] autorelease];
    [self.view addSubview:item];
    [item setImage:[ShareImageManager defaultManager].tomato];
    [DrawGameAnimationManager showReceiveFlower:item animationInController:self];
    //[self popupMessage:[NSString stringWithFormat:NSLS(@"kReceiveTomatoMessage"),REWARD_EXP, REWARD_COINS] title:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [DrawGameAnimationManager animation:anim didStopWithFlag:flag];
}

#pragma mark - Common Dialog Delegate
#define SHOP_DIALOG_TAG 20120406


- (void)clickOk:(CommonDialog *)dialog
{
    switch (dialog.tag) {
        case (ItemTypeTomato + ITEM_TAG_OFFSET): {
            [CommonItemInfoView showItem:[Item tomato] infoInView:self];
        } break;
        case (ItemTypeFlower + ITEM_TAG_OFFSET): {
            [CommonItemInfoView showItem:[Item flower] infoInView:self];
        } break;
        case (ItemTypeTips + ITEM_TAG_OFFSET): {
            [CommonItemInfoView showItem:[Item tips] infoInView:self];
        } break;
        default:
            break;
    }

}
- (void)clickBack:(CommonDialog *)dialog
{
    
}

#pragma mark - commonItemInfoView delegate
- (void)didBuyItem:(Item *)anItem 
            result:(int)result
{
    if (result == 0) {
        [[CommonMessageCenter defaultCenter]postMessageWithText:NSLS(@"kBuySuccess") delayTime:1 isHappy:YES];
        ToolView* toolview = nil;
        switch (anItem.type) {
            case ItemTypeFlower: {
                toolview = (ToolView*)[self.view viewWithTag:FLOWER_TOOLVIEW_TAG];
            } break;
            case ItemTypeTomato: {
                toolview = (ToolView*)[self.view viewWithTag:TOMATO_TOOLVIEW_TAG];
            } break;
            default:
                break;
        }
        [toolview setNumber:[[ItemManager defaultManager] amountForItem:toolview.itemType]];
    }
    if (result == ERROR_COINS_NOT_ENOUGH)
    {
        [[CommonMessageCenter defaultCenter]postMessageWithText:NSLS(@"kNotEnoughCoin") delayTime:1 isHappy:NO];
    }
    //TODO : add other situation deal method
}


@end
