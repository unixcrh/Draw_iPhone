//
//  FeedDetailController.m
//  Draw
//
//  Created by  on 12-6-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FeedDetailController.h"
#import "PPDebug.h"
#import "LocaleUtils.h"
#import "FeedManager.h"
#import "TimeUtils.h"
#import "StableView.h"
#import "ShowDrawView.h"
#import "DrawAction.h"
#import "Draw.h"
#import "ShareImageManager.h"
#import "CommentCell.h"
#import "OfflineGuessDrawController.h"
#import "SelectWordController.h"
#import "TimeUtils.h"
//#import "OfflineGuessDrawController.h
@interface FeedDetailController()
- (void)textViewDidChange:(UITextView *)textView;
@end;

@implementation FeedDetailController
@synthesize commentInput;
@synthesize commentLabel = _commentLabel;
@synthesize nickNameLabel;
@synthesize titleLabel;
@synthesize actionButton;
@synthesize sendButton;
@synthesize guessStatLabel;
@synthesize noCommentTipsLabel;
@synthesize timeLabel;
@synthesize feed = _feed;
@synthesize drawView = _drawView;
@synthesize inputBackgroundView = inputBackgroundView;
@synthesize followButton = _followButton;
@synthesize replayButton = _replayButton;
@synthesize inputBackground = _inputBackground;
@synthesize paperImage = _paperImage;
@synthesize avatarView = _avatarView;


#define AVATAR_VIEW_FRAME ([DeviceDetection isIPAD] ?  CGRectMake(660, 11, 84, 78) : CGRectMake(278, 6, 29, 28))
#define SHOW_DRAW_VIEW_FRAME ([DeviceDetection isIPAD] ?  CGRectMake(435, 141, 285, 258) :CGRectMake(200, 76, 95, 100))


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
}

- (id)initWithFeed:(Feed *)feed
{
    self = [super init];
    if (self) {
        self.feed = feed;
        _feedService = [FeedService defaultService];
        _startIndex = 0;
    }
    return self;
}


- (void)updateTime:(Feed *)feed
{
    if (time != nil) {
        [self.timeLabel setText:chineseBeforeTime(feed.createDate)];
    } else {
        NSString *formate = @"yy-MM-dd HH:mm";
        NSString *timeString = dateToStringByFormat(feed.createDate, formate);
        [self.timeLabel setText:timeString];
    }
    
}


- (void)updateUser:(Feed *)feed
{
    //avatar
//    [self.avatarView removeFromSuperview];
    self.avatarView = [[[AvatarView alloc] initWithUrlString:_avatar frame:AVATAR_VIEW_FRAME gender:feed.gender level:0] autorelease];
    [self.view addSubview:self.avatarView];
    
    //name
    [self.nickNameLabel setText:[FeedManager opusCreatorForFeed:feed]];
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
    ShareImageManager* imageManager = [ShareImageManager defaultManager];
    self.actionButton.hidden = NO;
    [self.actionButton setBackgroundImage:[imageManager greenImage] forState:UIControlStateNormal];
    self.actionButton.userInteractionEnabled = YES;
    self.actionButton.selected = NO;
    
    
    ActionType type = [FeedManager actionTypeForFeed:feed];
    if (type == ActionTypeGuess) {
        [self.actionButton setTitle:NSLS(@"kIGuessAction") forState:UIControlStateNormal];
    }else if(type == ActionTypeOneMore)
    {
        [self.actionButton setTitle:NSLS(@"kOneMoreAction") forState:UIControlStateNormal];        
    }else if(type == ActionTypeCorrect){
        [self.actionButton setTitle:NSLS(@"kIGuessCorrect") forState:UIControlStateSelected];
        [self.actionButton setBackgroundImage:[imageManager normalButtonImage] forState:UIControlStateNormal];
        self.actionButton.userInteractionEnabled = NO;
        self.actionButton.selected = YES;
        self.actionButton.hidden = YES;
    }else{
        self.actionButton.hidden = YES;
    }

}


- (void)updateDrawView:(Feed *)feed
{
//    self.drawView = [[[ShowDrawView alloc] initWithFrame:SHOW_DRAW_VIEW_FRAME] autorelease];
    [self.drawView setShowPenHidden:YES];
    [self.drawView setBackgroundColor:[UIColor clearColor]];
    //[self.view insertSubview:_drawView aboveSubview:self.followButton];
    [self.drawView cleanAllActions];
    CGRect normalFrame = DRAW_VEIW_FRAME;
    CGRect currentFrame = SHOW_DRAW_VIEW_FRAME;
    CGFloat xScale = currentFrame.size.width / normalFrame.size.width;
    CGFloat yScale = currentFrame.size.height / normalFrame.size.height;
    
    self.drawView.drawActionList = [DrawAction scaleActionList:feed.drawData.drawActionList xScale:xScale yScale:yScale];
    [self.drawView setPlaySpeed:0.01];
    [self.drawView play];
}

#define INPUT_BG_TAG 2012061501
- (void)updateInputView:(Feed *)feed
{
    commentInput.layer.cornerRadius = 6;
    commentInput.layer.masksToBounds = YES;
    _maskView = [[UIButton alloc] initWithFrame:self.view.frame];
    _maskView.hidden = YES;
    _maskView.backgroundColor = [UIColor clearColor];
    [_maskView addTarget:self action:@selector(clickMaskView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view bringSubviewToFront:inputBackgroundView];
    [self.view insertSubview:_maskView belowSubview:inputBackgroundView];
    [self.inputBackground setImage:[ShareImageManager defaultManager].inputImage];
}

- (void)updateCommentTableView:(Feed *)feed
{
    //load data.
}

- (void)updateSendButton:(Feed *)feed
{
    //load data.
    [self.sendButton setBackgroundImage:[[ShareImageManager defaultManager] greenImage]forState:UIControlStateNormal];
    [self.sendButton setTitle:NSLS(@"kComment") forState:UIControlStateNormal];

}



- (void)updateInfo:(Feed *)feed
{
    if (feed.feedType == FeedTypeDraw) {
        _opusId = feed.feedId;
        _userNickName = feed.nickName;
        _avatar = feed.avatar;
        _author = feed.userId;
    }else if(feed.feedType == FeedTypeGuess)
    {
        _opusId = feed.opusId;
        _userNickName = feed.drawData.nickName;
        _avatar = feed.drawData.avatar;
        _author = feed.drawData.userId;
    }else{
        PPDebug(@"<FeedDetailController>:warning feed type is error");
    }
}


#define COMMENT_COUNT 20
- (void)updateCommentList
{
    [self showActivityWithText:NSLS(@"kLoading")];
    [_feedService getOpusCommentList:_opusId offset:_startIndex limit:COMMENT_COUNT delegate:self];
}

- (void)updateNoCommentLabel
{
    self.noCommentTipsLabel.hidden = YES;
    [self.noCommentTipsLabel setText:NSLS(@"kNoCommentTips")];
}

- (void)updateTitle
{
    [self.titleLabel setText:NSLS(@"kFeedDetail")];
    [self.commentLabel setText:NSLS(@"kFeeds")];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self setSupportRefreshFooter:YES];
    [self setSupportRefreshHeader:YES];
    
    [super viewDidLoad];
    [self updateInfo:_feed];
    [self updateTime:_feed];
    [self updateUser:_feed];
    [self updateGuessDesc:_feed];
    [self updateActionButton:_feed];
    [self updateDrawView:_feed];
    [self updateCommentTableView:_feed];
    [self updateSendButton:_feed];
    [self updateNoCommentLabel];
    [self updateTitle];
    [self updateInputView:_feed];
    [self updateCommentList];
}

- (void)viewDidUnload
{
    [self setTitleLabel:nil];
    [self setNoCommentTipsLabel:nil];
    [self setTimeLabel:nil];
    [self setGuessStatLabel:nil];
    [self setActionButton:nil];
    [self setNickNameLabel:nil];
    [self setCommentInput:nil];
    [self setSendButton:nil];
    [self setInputBackgroundView:nil];
    [self setFollowButton:nil];
    [self setCommentLabel:nil];
    [self setReplayButton:nil];
    [self setDrawView:nil];
    [self setInputBackground:nil];
    [self setPaperImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)clickActionButton:(id)sender {
    ActionType type = [FeedManager actionTypeForFeed:self.feed];
    if (type == ActionTypeGuess) {
        [OfflineGuessDrawController startOfflineGuess:self.feed fromController:self];        
    }else if(type == ActionTypeOneMore){
        [SelectWordController startSelectWordFrom:self gameType:OfflineDraw];
    }
}

- (IBAction)clickFollowButton:(id)sender
{
    
}

- (IBAction)clickReplayShowDrawView:(id)sender
{
    [self.drawView setPlaySpeed:0.01];
    [self.drawView play];
}

- (IBAction)clickBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc {
    PPRelease(_feed);
    PPRelease(_avatarView);
    PPRelease(_drawView);
    [titleLabel release];
    [noCommentTipsLabel release];
    [timeLabel release];
    [guessStatLabel release];
    [actionButton release];
    [nickNameLabel release];
    [commentInput release];
    [sendButton release];
    [inputBackgroundView release];
    [_maskView release];
    [_followButton release];
    [_commentLabel release];
    [_replayButton release];
    [_drawView release];
    [_inputBackground release];
    [_paperImage release];
    [super dealloc];
}
- (IBAction)clickSendButton:(id)sender {
    NSString *msg = commentInput.text;
    if ([msg length] != 0) {
        [self showActivityWithText:NSLS(@"kSending")];
        [_feedService commentOpus:_opusId author:_author comment:msg delegate:self];        
    }
}

#pragma mark - feed service delegate
- (void)didCommentOpus:(NSString *)opusId
               comment:(NSString *)comment
            resultCode:(NSInteger)resultCode;
{
    [self hideActivity];
    
    if (resultCode == 0) {
        [self.commentInput setText:@""];
        [self.commentInput resignFirstResponder];
        [self textViewDidChange:self.commentInput];
        
        PPDebug(@"comment succ: opusId = %@, comment = %@", opusId, comment);
        Feed *feed = [[Feed alloc] init];
        UserManager *manager = [UserManager defaultManager];
        feed.userId = [manager userId];
        feed.nickName = [manager nickName];
        feed.avatar = [manager avatarURL];
        feed.gender = [manager isUserMale];
        feed.createDate = [NSDate date];
        feed.opusId = opusId;
        feed.comment = comment;
        NSMutableArray *array = [NSMutableArray arrayWithObject:feed];
        [feed release];
        
        if (self.dataList != nil) {
            [array addObjectsFromArray:self.dataList];
        }
        self.dataList = array;
        [self.dataTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        
    }else{
        [[CommonMessageCenter defaultCenter] postMessageWithText:NSLS(@"kCommentFail") delayTime:1 isHappy:NO];
        PPDebug(@"comment fail: opusId = %@, comment = %@", opusId, comment);        
    }
}

- (void)didGetFeedCommentList:(NSArray *)feedList 
                       opusId:(NSString *)opusId 
                   resultCode:(NSInteger)resultCode
{
    [self hideActivity];
    [self dataSourceDidFinishLoadingNewData];   
    [self dataSourceDidFinishLoadingMoreData];
    if (resultCode == 0) {
        PPDebug(@"<didGetFeedCommentList>get feed(%@)  succ!", opusId);
        if (_startIndex == 0) {
            self.dataList = feedList;
            [self.dataTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationTop];
        }else{
            NSMutableArray *array = [NSMutableArray array];
            if ([self.dataList count] != 0) {
                [array  addObjectsFromArray:self.dataList];
            }
            if ([feedList count] != 0) {
                [array addObjectsFromArray:feedList];
            }
            NSInteger start = [self.dataList count];
            NSInteger end = [array count];
            self.dataList = array;
            NSMutableArray *indexPaths = [NSMutableArray array];
            for (int i = start; i < end; ++ i) {
                NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:0];
                [indexPaths addObject:path];
            }
            if ([indexPaths count] != 0) {
                [self.dataTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            }
            
        }
        NSInteger count = [feedList count];
        _startIndex += count;
        self.noMoreData = (count < COMMENT_COUNT);        
    }else{
        PPDebug(@"<didGetFeedCommentList>get feed(%@)  fail!", opusId);
    }
}


#pragma mark - table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Feed *feed = [self.dataList objectAtIndex:indexPath.row];
	CGFloat height = [CommentCell getCellHeight:feed];
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = [dataList count];
    self.noCommentTipsLabel.hidden = (count != 0);
    
    if (count != 0) {
        self.dataTableView.separatorColor = [UIColor lightGrayColor];
    }else{
        self.dataTableView.separatorColor = [UIColor clearColor];
    }
    return count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [CommentCell getCellIdentifier];
    CommentCell *cell = [theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [CommentCell createCell:self];
    }
    cell.indexPath = indexPath;
    cell.accessoryType = UITableViewCellAccessoryNone;
    Feed *feed = [self.dataList objectAtIndex:indexPath.row];
    [cell setCellInfo:feed];
    return cell;
}

#pragma mark - refresh header & footer delegate
- (void)reloadTableViewDataSource
{
    _startIndex = 0;
    [self updateCommentList];
}

- (void)loadMoreTableViewDataSource
{
    [self updateCommentList];
}

#define MAX_LENGTH 140

#pragma mark - UITextViewDelegate methods
#define INPUT_TEXT_WIDTH_MAX    (([DeviceDetection isIPAD])?(550.0):(230.0))
#define INPUT_TEXT_HEIGHT_MAX   (([DeviceDetection isIPAD])?(120.0):(60.0))
#define TEXTTVIEW_HEIGHT_MIN    (([DeviceDetection isIPAD])?(64.0):(32.0))
#define INPUTBACKGROUNDVIEW_HEIGHT_MIN  (([DeviceDetection isIPAD])?(80.0):(38.0))
- (void)textViewDidChange:(UITextView *)textView
{
    UIFont *font = textView.font;
    CGSize size = [textView.text sizeWithFont:font constrainedToSize:CGSizeMake(INPUT_TEXT_WIDTH_MAX, INPUT_TEXT_HEIGHT_MAX) lineBreakMode:UILineBreakModeCharacterWrap];
    PPDebug(@"%f %f %f", textView.frame.size.height, size.height, size.width);
    CGRect oldFrame = textView.frame;
    CGFloat newHeight = size.height + 12;
    CGRect oldBackgroundFrame = inputBackgroundView.frame;
    
    if (newHeight > TEXTTVIEW_HEIGHT_MIN) {
        CGFloat addHeight = newHeight - oldFrame.size.height;
        [textView setFrame: CGRectMake(oldFrame.origin.x, oldFrame.origin.y, oldFrame.size.width, newHeight)];
        [inputBackgroundView setFrame:CGRectMake(oldBackgroundFrame.origin.x, oldBackgroundFrame.origin.y-addHeight, oldBackgroundFrame.size.width, oldBackgroundFrame.size.height+addHeight)];
    }else {
        [textView setFrame: CGRectMake(oldFrame.origin.x, oldFrame.origin.y, oldFrame.size.width, TEXTTVIEW_HEIGHT_MIN)];
        CGFloat delHeight = oldBackgroundFrame.size.height - INPUTBACKGROUNDVIEW_HEIGHT_MIN;
        [inputBackgroundView setFrame:CGRectMake(oldBackgroundFrame.origin.x, oldBackgroundFrame.origin.y+delHeight, oldBackgroundFrame.size.width, INPUTBACKGROUNDVIEW_HEIGHT_MIN)];
    }
    
    self.inputBackground.frame = CGRectMake(self.inputBackground.frame.origin.x, self.inputBackground.frame.origin.y, self.inputBackground.frame.size.width, textView.frame.size.height );//这个IMAGE_AND_TEXT_DIFF参照xib
    self.inputBackground.center = textView.center;
    
    [self changeTableSize:NO duration:0];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [_maskView setHidden:NO];
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [_maskView setHidden:YES];
    return YES;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text  
{  
    
    if ([text isEqualToString:@"\n"]) {  
        [self clickSendButton:self.sendButton];
        return NO;  
    }  
    return YES;  
} 

- (void)clickMaskView:(id)sender
{
    [commentInput resignFirstResponder];
}


#pragma mark - super methods: keyboard show and hide
#define SUPER_VIEW_HEIGHT (([DeviceDetection isIPAD])?(1004.0):(460.0))
- (void)keyboardWillShowWithRect:(CGRect)keyboardRect
{
    CGRect frame = CGRectMake(0, SUPER_VIEW_HEIGHT-keyboardRect.size.height-inputBackgroundView.frame.size.height, inputBackgroundView.frame.size.width, inputBackgroundView.frame.size.height);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    inputBackgroundView.frame = frame;
    [UIImageView commitAnimations];
    
    [self changeTableSize:YES duration:0.25];
}


- (void)keyboardWillHideWithRect:(CGRect)keyboardRect
{
    CGRect frame = CGRectMake(0, SUPER_VIEW_HEIGHT-inputBackgroundView.frame.size.height, inputBackgroundView.frame.size.width, inputBackgroundView.frame.size.height);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    inputBackgroundView.frame = frame;
    [UIImageView commitAnimations];
    
    [self changeTableSize:YES duration:0.25];
}

#define TABLE_AND_INPUT_SPACE (([DeviceDetection isIPAD])?(24.0):(12.0))
- (void)changeTableSize:(BOOL)animated duration:(NSTimeInterval)duration
{
    CGFloat newPaperHeight = self.inputBackgroundView.frame.origin.y - self.paperImage.frame.origin.y;
    CGRect newPaperFrame = CGRectMake(self.paperImage.frame.origin.x, self.paperImage.frame.origin.y, self.paperImage.frame.size.width, newPaperHeight);
//    CGFloat newTableHeight = inputBackgroundView.frame.origin.y - dataTableView.frame.origin.y - TABLE_AND_INPUT_SPACE;
//    CGRect newTableFrame = CGRectMake(dataTableView.frame.origin.x, dataTableView.frame.origin.y, dataTableView.frame.size.width, newTableHeight);
    
    if (animated) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:duration];
        self.paperImage.frame = newPaperFrame;
        //dataTableView.frame = newTableFrame;
        [UIView commitAnimations];
    }else {
        self.paperImage.frame = newPaperFrame;
        //dataTableView.frame = newTableFrame;
    }
}


@end
