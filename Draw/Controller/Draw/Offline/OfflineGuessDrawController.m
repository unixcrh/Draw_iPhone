//
//  ShowDrawController.m
//  Draw
//
//  Created by  on 12-3-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OfflineGuessDrawController.h"
#import "ShowDrawView.h"
#import "Paint.h"
#import "GameSessionUser.h"
#import "GameSession.h"
#import "Word.h"
#import "WordManager.h"
#import "LocaleUtils.h"
#import "AnimationManager.h"
#import "GameTurn.h"
#import "ResultController.h"
#import "HJManagedImageV.h"
#import "PPApplication.h"
#import "HomeController.h"
#import "DrawAction.h"
#import "ShareImageManager.h"
#import "RoomController.h"
#import "GameMessage.pb.h"
#import "PPDebug.h"
#import "ItemManager.h"
#import "AccountService.h"
#import "ItemShopController.h"
#import "DrawConstants.h"
#import "AudioManager.h"
#import "ConfigManager.h"
#import "CommonMessageCenter.h"
#import "Draw.h"
#import "AccountManager.h"
#import "CoinShopController.h"
#import "FeedController.h"
#import "FeedDetailController.h"
#import "CommonUserInfoView.h"
#import "FeedService.h"
#import "DrawGameAnimationManager.h"
#import "ItemService.h"
#import "VendingController.h"

#define PAPER_VIEW_TAG 20120403
#define TOOLVIEW_CENTER (([DeviceDetection isIPAD]) ? CGPointMake(695, 920):CGPointMake(284, 424))
#define MOVE_BUTTON_FONT_SIZE (([DeviceDetection isIPAD]) ? 36.0 : 18.0)

#define ITEM_FRAME  ([DeviceDetection isIPAD]?CGRectMake(0, 0, 122, 122):CGRectMake(0, 0, 61, 61))

#define MAX_TOMATO_CAN_THROW 10
#define MAX_FLOWER_CAN_THROW 10

#define TOOLVIEW_TAG_TIPS   120120730
#define TOOLVIEW_TAG_FLOWER 220120730
#define TOOLVIEW_TAG_TOMATO 320120730


@implementation OfflineGuessDrawController
@synthesize showView;
@synthesize candidateString = _candidateString;
@synthesize drawBackground;
@synthesize word = _word;
@synthesize titleLabel;
@synthesize feed = _feed;
@synthesize superController = _supperController;
@synthesize delegate = _delegate;


+ (OfflineGuessDrawController *)startOfflineGuess:(DrawFeed *)feed 
           fromController:(UIViewController *)fromController
{
    OfflineGuessDrawController *offGuess = [[OfflineGuessDrawController alloc] 
                                            initWithFeed:feed];
    offGuess.superController = fromController;
    [fromController.navigationController pushViewController:offGuess animated:YES];
    [offGuess release];        
    return offGuess;
}

- (void)dealloc
{
    moveButton = nil;
    _shopController = nil;
    lastScaleTarget = nil;
    
    PPRelease(_candidateString);
//    PPRelease(toolView);
    PPRelease(showView);
    PPRelease(drawBackground);
    PPRelease(titleLabel);
    PPRelease(_feed);
    PPRelease(_guessWords);
    PPRelease(_supperController);
    PPRelease(_pickToolView);
    [super dealloc];
}

#pragma mark - throw item animation
- (void)throwTool:(ToolView*)toolView
{
    UIImageView* item = [[[UIImageView alloc] initWithFrame:ITEM_FRAME] autorelease];
    [self.view addSubview:item];
    [item setImage:toolView.imageView.image];
    if (toolView.itemType == ItemTypeTomato) {
        [DrawGameAnimationManager showThrowTomato:item animInController:self];
    }
    if (toolView.itemType == ItemTypeFlower) {
        [DrawGameAnimationManager showThrowFlower:item animInController:self];

    }
}


#pragma mark - Constroction
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _guessWords = [[NSMutableArray alloc] init];
    }
    return self;
}


- (id)init{
    self = [super init];
    if (self) {
        shareImageManager = [ShareImageManager defaultManager];        
    }
    return self;
}

- (id)initWithFeed:(DrawFeed *)feed
{
    self = [super init];
    if (self) {
        shareImageManager = [ShareImageManager defaultManager];        
        self.feed = feed;
        _opusId = _feed.feedId;
        _draw = _feed.drawData;
        _authorId = _feed.author.userId;
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


#pragma mark - init the buttons

#define TARGET_BASE_TAG 11
#define TARGET_END_TAG 17
#define CANDIDATE_BASE_TAG 21
#define CANDIDATE_END_TAG 39

#define RowNumber 2
#define WORD_BASE_X (([DeviceDetection isIPAD])? 26 : 9)
#define WORD_BASE_Y_1 (([DeviceDetection isIPAD])? 855 : 390)
#define WORD_BASE_Y_2 (([DeviceDetection isIPAD])? 930 : 425)
#define WORD_SPACE_X (([DeviceDetection isIPAD])? 22 : 4)


#define WORD_FONT (([DeviceDetection isIPAD])? [UIFont systemFontOfSize:18 * 2]: [UIFont systemFontOfSize:18])

#define WORD_BUTTON_WIDTH (([DeviceDetection isIPAD])? 30 * 2: 30)
#define WORD_BUTTON_HEIGHT (([DeviceDetection isIPAD])? 30 * 2: 30)

#define ZOOM_SCALE 1.2


- (void)resetWordButtons:(NSInteger)count
{
    int tag = CANDIDATE_BASE_TAG;

    CGFloat x,y;
    for (int i = 0; i < count; ++ i) {
        UIButton *button = (UIButton *)[self.view viewWithTag:tag ++];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[shareImageManager woodImage]
                          forState:UIControlStateNormal];
        [button.titleLabel setFont:WORD_FONT];                
        NSInteger rowCount = count / RowNumber;
        NSInteger row = i / rowCount;
        NSInteger num = i % rowCount;
        
        x = WORD_BASE_X + (WORD_BUTTON_WIDTH + WORD_SPACE_X) * num; 
        y = (row == 0) ? WORD_BASE_Y_1 : WORD_BASE_Y_2;
        
        button.frame = CGRectMake(x, y, WORD_BUTTON_WIDTH, WORD_BUTTON_HEIGHT);
        button.hidden = NO;
        button.enabled = NO;
    }
    
    for (; tag <= CANDIDATE_END_TAG; ++ tag) {
        UIButton *button = (UIButton *)[self.view viewWithTag:tag];
        [button setTitle:nil forState:UIControlStateNormal];
        button.hidden = YES;
    }
}

- (UIButton *)targetButton:(CGPoint)point
{
    
    for (int tag = TARGET_BASE_TAG; tag <= TARGET_END_TAG; ++ tag) {
        UIButton *button = (UIButton *)[self.view viewWithTag:tag];
        //can write
        if (button.hidden == NO && [[button titleForState:UIControlStateNormal] length] == 0) {
            //distance
            if ([DrawUtils distanceBetweenPoint:point point2:button.center] < button.frame.size.width) {
                return button;
            }
        }
    }
    return nil;
}


- (UIButton *)candidateButtonForText:(NSString *)text
{
    for (int i = 0; i < [self.candidateString length]; ++ i) {
        NSString *sub = [self.candidateString substringWithRange:NSMakeRange(i, 1)];
        if ([sub isEqualToString:text]) {
            UIButton *button = (UIButton *)[self.view viewWithTag:CANDIDATE_BASE_TAG + i];
            if ([[button titleForState:UIControlStateNormal] length] == 0) {
                return button;
            }
        }
    }
    return nil;
}

- (void)clickWriteButton:(UIButton *)button
{
    NSString *text = [self realValueForButton:button];
    if ([text length] != 0) {
        UIButton *pButton = [self candidateButtonForText:text];
        if (pButton) {
            [self setButton:pButton title:text enabled:YES];
            [self setButton:button title:nil enabled:NO];
        }
        
    }
}


- (NSString *)getAnswer
{
    //get the word
    NSString *answer = @"";
    NSInteger endIndex = TARGET_END_TAG;
    for (int i = TARGET_BASE_TAG; i <= endIndex; ++ i) {
        UIButton *button = (UIButton *)[self.view viewWithTag:i];
        NSString *text = [self realValueForButton:button];
        if ([text length] == 1 && ![text isEqualToString:@" "]) {
            answer = [NSString stringWithFormat:@"%@%@",answer,text];
        }
    }
    return answer;
}

- (UIButton *)getTheFirstEmptyButton
{
    NSInteger endIndex = TARGET_END_TAG;//(languageType == ChineseType) ? (TARGET_END_TAG - 1) : TARGET_END_TAG;
    for (int i = TARGET_BASE_TAG; i <= endIndex; ++ i) {
        UIButton *button = (UIButton *)[self.view viewWithTag:i];
        if (button.hidden == NO && [[button titleForState:UIControlStateNormal] length] == 0) {
            return button;
        }
    }
    return nil;
}

- (void)clickPickingButton:(UIButton *)button target:(UIButton *)target text:(NSString *)text
{
    [[AudioManager defaultManager] playSoundById:CLICK_WORD];
    if ([text length] != 0) {
        if (target) {
            [self setButton:target title:text enabled:YES];
            [self setButton:button title:nil enabled:NO];
            
            NSString *ans = [self getAnswer];
            if ([ans length] == [self.word.text length]) {
                [self commitAnswer:ans];;
            } 
        }
    }
}

- (void) dragBegan: (UIControl *) c withEvent:ev
{

    UIButton *bt = (UIButton *)c;
    NSString *title = [self realValueForButton:bt];
    moveButton.hidden = NO;
    [self setButton:moveButton title:title enabled:YES];
    [self setButton:bt title:nil enabled:NO];
    moveButton.center = [[[ev allTouches] anyObject] locationInView:self.view];
    
}
- (void) dragMoving: (UIControl *) c withEvent:ev
{
    moveButton.center = [[[ev allTouches] anyObject] locationInView:self.view];
    UIButton *targetButton = [self targetButton:moveButton.center];
    if (targetButton != lastScaleTarget) {
        //scale
        lastScaleTarget.layer.transform = CATransform3DMakeScale(1, 1, 1);
        targetButton.layer.transform = CATransform3DMakeScale(ZOOM_SCALE, ZOOM_SCALE, 1);
        lastScaleTarget = targetButton;
    }
}
- (void) dragEnded: (UIControl *) c withEvent:ev
{
    moveButton.center = [[[ev allTouches] anyObject] locationInView:self.view];
    CGPoint touchPoint = [[[ev allTouches] anyObject] locationInView:self.view]; 
    NSString *title = [self realValueForButton:moveButton];
    UIButton *targetButton = [self targetButton:moveButton.center];
    UIButton *bt = (UIButton *)c;    
    
    lastScaleTarget.layer.transform = CATransform3DMakeScale(1, 1, 1);
    lastScaleTarget = nil;

    
    if (targetButton != nil) {
        [self clickPickingButton:bt target:targetButton text:title];
    }else{ 
        NSInteger distance = [DrawUtils distanceBetweenPoint:touchPoint point2:c.center];
        if(distance < c.frame.size.width / 2 && 
           (targetButton = [self getTheFirstEmptyButton]) != nil)
        {
            [self clickPickingButton:bt target:targetButton text:title];            
        }else{
            [self setButton:bt title:title enabled:YES];
        }
    }
    [self setButton:moveButton title:nil enabled:NO];
    moveButton.hidden = YES;
}

- (void)addDragActions:(UIButton *)button
{
    [button addTarget:self action:@selector(dragBegan:withEvent: )
     forControlEvents: UIControlEventTouchDown];
    [button addTarget:self action:@selector(dragMoving:withEvent: )
     forControlEvents: UIControlEventTouchDragInside];
    [button addTarget:self action:@selector(dragMoving:withEvent: )
     forControlEvents: UIControlEventTouchDragOutside];
    
    [button addTarget:self action:@selector(dragEnded:withEvent: )
     forControlEvents: UIControlEventTouchUpInside | 
     UIControlEventTouchUpOutside];
    [button addTarget:self action:@selector(dragEnded:withEvent:) forControlEvents:UIControlEventTouchCancel];
    
}

- (void)initMoveButton
{
    moveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [moveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [moveButton setBackgroundImage:[UIImage imageNamed:@"wood_button.png"] forState:UIControlStateNormal];
    moveButton.hidden = YES;
    [moveButton.titleLabel setFont:[UIFont systemFontOfSize:MOVE_BUTTON_FONT_SIZE]];
    moveButton.frame = CGRectMake(0, 0, WORD_BUTTON_WIDTH, WORD_BUTTON_HEIGHT);
    moveButton.layer.transform = CATransform3DMakeScale(ZOOM_SCALE, ZOOM_SCALE, 1);
    [self.view addSubview:moveButton];
}

- (void)initCandidateButton:(UIButton *)button
{

    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[shareImageManager woodImage]
                      forState:UIControlStateNormal];
    button.enabled = NO;
    button.frame = CGRectMake(0, 0, WORD_BUTTON_WIDTH, WORD_BUTTON_HEIGHT);
    [self addDragActions:button];
    
}
- (void)initWordViews
{
    
    for (int i = CANDIDATE_BASE_TAG; i <= CANDIDATE_END_TAG; ++ i) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTag:i];
        [self initCandidateButton:button];
        [self.view addSubview:button];
    }
    [self resetWordButtons:CANDIDATE_WORD_NUMBER];
    [self initMoveButton];
}


- (void)initPickToolView
{
    NSMutableArray *array = [NSMutableArray array];
    ItemManager *itemManager = [ItemManager defaultManager];
    ToolView *tips = [ToolView tipsViewWithNumber:[itemManager amountForItem:ItemTypeTips]];
    tips.tag = TOOLVIEW_TAG_TIPS;
    ToolView *flower = [ToolView flowerViewWithNumber:[itemManager amountForItem:ItemTypeFlower]];
    flower.tag = TOOLVIEW_TAG_FLOWER;
    ToolView *tomato = [ToolView tomatoViewWithNumber:[itemManager amountForItem:ItemTypeTomato]];
    tomato.tag = TOOLVIEW_TAG_TOMATO;
    [array addObject:tips];
    [array addObject:flower];
    [array addObject:tomato];
    _pickToolView = [[PickToolView alloc] initWithTools:array];
    _pickToolView.hidden = YES;
    _pickToolView.delegate = self;
    [self.view addSubview:_pickToolView];
}


#pragma mark - Word && Word Views


- (void)updateCandidateViewsWithText:(NSString *)text
{
    self.candidateString = text;
    NSInteger tag = CANDIDATE_BASE_TAG;
    
    for (int i = 0; i < text.length; ++ i) {
        UIButton *button = (UIButton *)[self.view viewWithTag:tag ++];
        NSString *title = [self.candidateString substringWithRange:NSMakeRange(i, 1)];
        if ([title isEqualToString:@" "]) {
            [self setButton:button title:nil enabled:NO];
        }else{
            [self setButton:button title:title enabled:YES];
        }
    }
    for (; tag <= CANDIDATE_END_TAG; ++ tag) {
        UIButton *button = (UIButton *)[self.view viewWithTag:tag];
        [self setButton:button title:nil enabled:NO];
        button.hidden = YES;
    }
}


//- (void)updateBomb
//{
//    toolView.number = [[ItemManager defaultManager] tipsItemAmount];
//}
//
- (void)updateCandidateViews:(Word *)word lang:(LanguageType)lang
{
    self.word = word;
    languageType = lang;
    if (lang == EnglishType) {
        NSString *upperString = [WordManager upperText:word.text];
        self.word.text = upperString;        
    }
    NSString *text = nil;
    if (languageType == ChineseType) {
        text = [[WordManager defaultManager] randChinesStringWithWord:
                self.word count:CANDIDATE_WORD_NUMBER];
    }else{
        text = [[WordManager defaultManager] randEnglishStringWithWord:
                self.word count:CANDIDATE_WORD_NUMBER];        
    }
    [self resetWordButtons:CANDIDATE_WORD_NUMBER];
    [self updateCandidateViewsWithText:text];
}



- (void)setWordButtonsEnabled:(BOOL)enabled
{
    for (int i = TARGET_BASE_TAG; i <= TARGET_END_TAG; ++ i) {
        UIButton *button = (UIButton *)[self.view viewWithTag:i];
        [button setEnabled:enabled];
    }
    
    for (int i = CANDIDATE_BASE_TAG; i <= CANDIDATE_END_TAG; ++ i) {
        UIButton *button = (UIButton *)[self.view viewWithTag:i];
        [button setEnabled:enabled];
    }
//    [toolView setEnabled:enabled];
}

- (void)updateDrawInfo
{

    self.word = _draw.word;
    [self updateTargetViews:_draw.word];
    [self updateCandidateViews:_draw.word lang:_draw.languageType];
//    toolView.enabled = YES;
    if ([_draw.drawActionList count] != 0) {
        
        NSMutableArray *list =  [NSMutableArray arrayWithArray:_draw.drawActionList];            
        [self.showView setDrawActionList:list];
        double speed = [DrawAction calculateSpeed:self.showView.drawActionList defaultSpeed:1.0/30.0 maxSecond:30];
        self.showView.playSpeed = speed;
        [self.showView play];
    }
    
    AvatarView *avatar = [[AvatarView alloc] initWithUrlString:_draw.avatar type:Guesser gender:YES level:1];
    avatar.userId = _draw.userId;
    if ([DeviceDetection isIPAD]) {
        avatar.center = CGPointMake(21 * 2, 22 * 2);
    }else{
        avatar.center = CGPointMake(21, 22);
    }
    avatar.delegate = self;
    [self.view addSubview:avatar];
    [avatar release];
    
    if ([[_draw nickName] length] != 0) {
        if ([_draw.userId isEqualToString:[UserManager defaultManager].userId]) {
            [self.titleLabel setText:[NSString stringWithFormat:NSLS(@"kGuessUserDraw_MyDraw")]];
        } else {
            [self.titleLabel setText:[NSString stringWithFormat:NSLS(@"kGuessUserDraw"),[_draw nickName]]];
        }
    }

}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.titleLabel setText:NSLS(@"kGuessDraw")];
    
    [self initShowView];
    
    //init the toolView for bomb the candidate words
//    [self initBomb];
    [self initWordViews];
    [self initTargetViews];

    _shopController = nil;
    
    [self updateDrawInfo];
    [self initPickToolView];
    
    _maxFlower = MAX_FLOWER_CAN_THROW;
    _maxTomato = MAX_TOMATO_CAN_THROW;
}


- (void)viewDidAppear:(BOOL)animated
{
//    [self updateBomb];
    [super viewDidAppear:animated];
}



- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    _shopController = nil;
}

- (void)viewDidUnload
{
    [self setShowView:nil];
    [self setDrawBackground:nil];
    [self setTitleLabel:nil];
    [super viewDidUnload];
    [self setWord:nil];
}



- (void)updateFeed:(BOOL)isCorrect
{
    if ([_guessWords count] != 0) {
        [self.feed incGuessTimes];
        if (isCorrect) {
            [self.feed incCorrectTimes];
        }
        if (_delegate && [_delegate respondsToSelector:@selector(didGuessFeed:isCorrect:words:)]) {
            [_delegate didGuessFeed:_feed isCorrect:isCorrect words:_guessWords];
        }
    }
}

#pragma mark - Common Dialog Delegate
#define SHOP_DIALOG_TAG 20120406
#define QUIT_DIALOG_TAG 20120613
#define ESCAPE_DEDUT_COIN 1
#define ITEM_TAG_OFFSET 20120728

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
        case QUIT_DIALOG_TAG:
        default:
            //if have no words, don't send the action.
            if ([_guessWords count] != 0) {
                [[DrawDataService defaultService] guessDraw:_guessWords opusId:_opusId opusCreatorUid:_authorId isCorrect:NO score:0 delegate:nil];            
                [self updateFeed:NO];
            }
            UIViewController *feedDetail = [self superViewControllerForClass:[FeedDetailController class]];
            if (feedDetail) {
                [self.navigationController popToViewController:feedDetail animated:YES];
            }else{
                [HomeController returnRoom:self];        
            }
            break;
    }
    //run away
//    if (dialog.tag == SHOP_DIALOG_TAG) {
//        VendingController *itemShop = [VendingController instance];
//        [self.navigationController pushViewController:itemShop animated:YES];
//        _shopController = itemShop;
//    }else if(dialog.tag == QUIT_DIALOG_TAG){
//
//        //if have no words, don't send the action.
//        if ([_guessWords count] != 0) {
//            [[DrawDataService defaultService] guessDraw:_guessWords opusId:_opusId opusCreatorUid:_draw.userId isCorrect:NO score:0 delegate:nil];            
//            [self updateFeed:NO];
//        }
//        UIViewController *feedDetail = [self superViewControllerForClass:[FeedDetailController class]];
//        if (feedDetail) {
//            [self.navigationController popToViewController:feedDetail animated:YES];
//        }else{
//            [HomeController returnRoom:self];        
//        }
//    }
}
- (void)clickBack:(CommonDialog *)dialog
{
    
}

#pragma mark - Actions

- (void)commitAnswer:(NSString *)answer
{
    [_guessWords addObject:answer];
    
    //alter if the word is correct
    if ([answer isEqualToString:self.word.text]) {
        if ([self.showView status] != Stop) {
            [self.showView show];            
        }

        
        [[CommonMessageCenter defaultCenter] postMessageWithText:NSLS(@"kGuessCorrect") delayTime:1 isHappy:YES];
        [[AudioManager defaultManager] playSoundById:BINGO];
        [self setWordButtonsEnabled:NO];
    
        NSInteger score = [_draw.word score]; // * [ConfigManager guessDifficultLevel];
        
        ResultController *result = [[ResultController alloc] initWithImage:showView.createImage drawUserId:_draw.userId drawUserNickName:_draw.nickName wordText:_draw.word.text score:score correct:YES isMyPaint:NO drawActionList:_draw.drawActionList feed:self.feed];
    
        //send http request.
        [[DrawDataService defaultService] guessDraw:_guessWords opusId:_opusId opusCreatorUid:_draw.userId isCorrect:YES score:score delegate:nil];
        [self updateFeed:YES];
        
        //store locally.
        [[UserManager defaultManager] guessCorrectOpus:_opusId];
        [self.navigationController pushViewController:result animated:YES];
        [result release];
        
    }else{
        [[CommonMessageCenter defaultCenter] postMessageWithText:NSLS(@"kGuessWrong") delayTime:1 isHappy:NO];
        [[AudioManager defaultManager] playSoundById:WRONG];
    }
}



- (BOOL)bomb:(ToolView *)toolView
{
    if ([self.candidateString length] == 0) {
        return NO;
    }
    [self updateTargetViews:self.word];
    NSString *result  = [WordManager bombCandidateString:self.candidateString word:self.word];
    [self updateCandidateViewsWithText:result];
    [toolView setEnabled:NO];
    return YES;
}


- (BOOL)throwFlower:(ToolView *)toolView
{
    // add throw animation
    [self throwTool:toolView];
    
    // send request for item usage and award
    [[ItemService defaultService] sendItemAward:toolView.itemType 
                                   targetUserId:_draw.userId 
                                      isOffline:YES
                                     feedOpusId:_opusId
                                     feedAuthor:_authorId];    
    
    [toolView decreaseNumber];
    if (--_maxFlower <= 0) {
        [toolView setEnabled:NO];
    }
    
    return NO;
}

- (BOOL)throwTomato:(ToolView *)toolView
{
    // throw animation
    [self throwTool:toolView];
    
    // send request for item usage and award
    [[ItemService defaultService] sendItemAward:toolView.itemType 
                                   targetUserId:_draw.userId 
                                      isOffline:YES
                                     feedOpusId:_opusId
                                     feedAuthor:_authorId];    
    
    [toolView decreaseNumber];
    if (--_maxTomato <= 0) {
        [toolView setEnabled:NO];
    }
    
    return NO;
}
#pragma mark - click tool delegate
- (void)didPickedPickView:(PickView *)pickView toolView:(ToolView *)toolView
{
    NSInteger amout = [[ItemManager defaultManager] amountForItem:toolView.itemType];
    if(amout <= 0){
        //TODO go the shopping page.
        CommonDialog *dialog = [CommonDialog createDialogWithTitle:NSLS(@"kNoItemTitle") message:NSLS(@"kNoItemMessage") style:CommonDialogStyleDoubleButton delegate:self];
        dialog.tag = ITEM_TAG_OFFSET + toolView.itemType;
        [dialog showInView:self.view];
        return;
    }
    BOOL flag = NO;
    if (toolView.itemType == ItemTypeTips) {
        flag = [self bomb:toolView];
    }else if(toolView.itemType == ItemTypeFlower)
    {
        flag = [self throwFlower:toolView];
    }else if(toolView.itemType == ItemTypeTomato)
    {
        flag = [self throwTomato:toolView];
    }
    if (flag) {
        [[AccountService defaultService] consumeItem:ItemTypeTips 
                                              amount:toolView.itemType];        
        [toolView decreaseNumber];
    }

}


- (IBAction)clickToolBox:(id)sender {
    [self.view bringSubviewToFront:_pickToolView];
    [_pickToolView setHidden:!_pickToolView.hidden animated:YES];
}

- (IBAction)clickRunAway:(id)sender {
    CommonDialog *dialog = [CommonDialog createDialogWithTitle:NSLS(@"kQuitGameAlertTitle") message:NSLS(@"kQuitGameAlertMessage") style:CommonDialogStyleDoubleButton delegate:self];
    dialog.tag = QUIT_DIALOG_TAG;
    [self.view addSubview:dialog];
}

- (void)initTargetViews
{
    NSInteger tag = TARGET_BASE_TAG;
    for (int i = TARGET_BASE_TAG; i <= TARGET_END_TAG; ++ i)
    {
        UIButton *button = (UIButton *)[self.view viewWithTag: tag ++];
        [button addTarget:self action:@selector(clickWriteButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view bringSubviewToFront:button];
        button.hidden = YES;
    }    
}
- (void)updateTargetViews:(Word *)word
{
    NSInteger tag = TARGET_BASE_TAG;
    for (int i = 0; i < word.length; ++ i)
    {
        UIButton *button = (UIButton *)[self.view viewWithTag: tag ++];
        [self setButton:button title:nil enabled:NO];
        button.hidden = NO;
    }
    
}

- (void)initShowView
{
    showView = [[ShowDrawView alloc] initWithFrame:DRAW_VIEW_FRAME];  
    [self.view insertSubview:showView aboveSubview:drawBackground];
    showView.playSpeed = 1.0/28.0;
}

- (void)setButton:(UIButton *)button title:(NSString *)title enabled:(BOOL)enabled
{
    [button setTitle:title forState:UIControlStateSelected];
    [button setEnabled:enabled];
    if (languageType == ChineseType && [LocaleUtils isTraditionalChinese]) {
        NSString *realValue = [WordManager changeToTraditionalChinese:title];
        [button setTitle:realValue forState:UIControlStateNormal];
    }else{
        [button setTitle:title forState:UIControlStateNormal];
    }
}
- (NSString *)realValueForButton:(UIButton *)button
{
    return [button titleForState:UIControlStateSelected];
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
                      infoInView:self];
}

#pragma mark - animation delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [DrawGameAnimationManager animation:anim didStopWithFlag:flag];
}

#pragma mark - commonItemInfoView delegate
- (void)didBuyItem:(Item *)anItem 
            result:(int)result
{
    if (result == 0) {
        [[CommonMessageCenter defaultCenter]postMessageWithText:NSLS(@"kBuySuccess") delayTime:1 isHappy:YES];
        ToolView* toolview = nil;
        switch (anItem.type) {
            case ItemTypeTips: {
                toolview = (ToolView*)[self.view viewWithTag:TOOLVIEW_TAG_TIPS];
            } break;
            case ItemTypeFlower: {
                toolview = (ToolView*)[self.view viewWithTag:TOOLVIEW_TAG_FLOWER];
            } break;
            case ItemTypeTomato: {
                toolview = (ToolView*)[self.view viewWithTag:TOOLVIEW_TAG_TOMATO];
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
