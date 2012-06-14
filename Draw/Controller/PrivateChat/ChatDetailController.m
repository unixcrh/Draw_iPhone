//
//  ChatDetailController.m
//  Draw
//
//  Created by haodong qiu on 12年6月7日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import "ChatDetailController.h"
#import "DeviceDetection.h"
#import "ChatMessage.h"
#import "ChatMessageManager.h"
#import "UserManager.h"
#import "DrawConstants.h"
#import "DrawDataService.h"
#import "DrawAction.h"
#import "GameBasic.pb.h"
#import "ShowDrawView.h"

@interface ChatDetailController ()

@property (retain, nonatomic) NSString *friendUserId;
@property (retain, nonatomic) NSString *friendNickname;
@property (retain, nonatomic) OfflineDrawViewController *offlineDrawViewController;

- (IBAction)clickBack:(id)sender;

@end


@implementation ChatDetailController
@synthesize titleLabel;
@synthesize graffitiButton;
@synthesize inputView;
@synthesize inputTextField;
@synthesize sendButton;
@synthesize friendUserId = _friendUserId;
@synthesize friendNickname = _friendNickname;
@synthesize offlineDrawViewController = _offlineDrawViewController;

- (void)dealloc {
    PPRelease(_offlineDrawViewController);
    PPRelease(_friendNickname);
    PPRelease(_friendUserId);
    PPRelease(titleLabel);
    PPRelease(graffitiButton);
    PPRelease(sendButton);
    PPRelease(inputTextField);
    PPRelease(inputView);
    [super dealloc];
}

- (id)initWithFriendUserId:(NSString *)frindUserId friendNickname:(NSString *)friendNickname
{
    self = [super init];
    if (self) {
        self.friendUserId = frindUserId;
        self.friendNickname = friendNickname;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Add a single tap Recognizer
    UITapGestureRecognizer* singleTapRecognizer;
    singleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapFrom:)];
    singleTapRecognizer.numberOfTapsRequired = 1; // For single tap
    [self.dataTableView addGestureRecognizer:singleTapRecognizer];
    [singleTapRecognizer release];
    
    self.titleLabel.text = self.friendNickname;
    

    PPDebug(@"%@",_friendUserId);
    self.dataList = [[ChatMessageManager defaultManager] findMessagesByFriendUserId:_friendUserId];
    PPDebug(@"%d",[dataList count]);
    [self findAllMessages];
    
    
    NSIndexPath *indPath = [NSIndexPath indexPathForRow:[dataList count]-1 inSection:0];
    [dataTableView scrollToRowAtIndexPath:indPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}

- (void)viewDidUnload
{
    [self setTitleLabel:nil];
    [self setGraffitiButton:nil];
    [self setSendButton:nil];
    [self setInputTextField:nil];
    [self setInputView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)findAllMessages
{
    [[ChatService defaultService] findAllMessages:self friendUserId:_friendUserId starOffset:0 maxCount:100];
}

- (void)didFindAllMessagesByFriendUserId:(NSArray *)totalList
{
    self.dataList = totalList;
    [dataTableView reloadData];
}

- (void)didSendMessage:(int)resultCode
{
    if (resultCode == 0) {
        [inputTextField setText:@""];
        //to do
    } else {
        [self popupMessage:NSLS(@"kSendMessageFailed") title:nil];
    }
    [inputTextField resignFirstResponder];
    
    PPDebug(@"%d",[dataList count]);
    
    self.dataList = [[ChatMessageManager defaultManager] findMessagesByFriendUserId:_friendUserId];
    [dataTableView reloadData];
}

//- (NSInteger)linesWithString:(NSString *)str contentSize:(CGSize)size withFont:(UIFont *)font {
//    
//    CGSize singleLineSize = [str sizeWithFont:font forWidth:size.width lineBreakMode:UILineBreakModeWordWrap];
//    CGSize multLineSize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
//    
//    NSInteger lines = (NSInteger)ceil(multLineSize.height / singleLineSize.height);
//    
//    
//    return lines;
//}


- (ShowDrawView *)createThumbImageBy:(NSArray *)drawActionList
{
    ShowDrawView *showDrawView = [[[ShowDrawView alloc] init] autorelease];
    //线条的缩放
    NSMutableArray *scaleActionList = nil;
    if ([DeviceDetection isIPAD]) {
        scaleActionList = [DrawAction scaleActionList:drawActionList 
                                               xScale:IPAD_WIDTH_SCALE 
                                               yScale:IPAD_HEIGHT_SCALE];
    } else {
        scaleActionList = [DrawAction scaleActionList:drawActionList 
                                               xScale:0.6 
                                               yScale:0.6];
        //scaleActionList = [NSMutableArray arrayWithArray:drawActionList];
    }
    [showDrawView setDrawActionList:scaleActionList]; 
    [showDrawView setShowPenHidden:YES];
    [showDrawView setPlaySpeed:0.1];
    //[showDrawView playFromDrawActionIndex:[drawActionList count]-1];
    [showDrawView play];
    
    return showDrawView;
//    UIImage *thumbImage = [showDrawView createImage];
//    [showDrawView release];
//    
//    return thumbImage;
}


#define TEXT_WIDTH_MAX    (([DeviceDetection isIPAD])?(400.0):(200.0))
#define TEXT_HEIGHT_MAX   (([DeviceDetection isIPAD])?(2000.0):(1000.0))
#define TEXT_FONT_SIZE  (([DeviceDetection isIPAD])?(24):(15))
#define SPACE_Y         (([DeviceDetection isIPAD])?(20):(10))
#define SCREEN_WIDTH    (([DeviceDetection isIPAD])?(768):(320))
#define TEXTVIEW_BORDER_X (([DeviceDetection isIPAD])?(16):(8))
#define TEXTVIEW_BORDER_Y (([DeviceDetection isIPAD])?(16):(8))
#define BUBBLE_TIP_WIDTH   (([DeviceDetection isIPAD])?(20):(10))
#define BUBBLE_NOT_TIP_WIDTH    (([DeviceDetection isIPAD])?(10):(5))

#define IMAGE_WIDTH_MAX (([DeviceDetection isIPAD])?(400.0):(200.0))
#define IMAGE_BORDER_X (([DeviceDetection isIPAD])?(16):(8))
#define IMAGE_BORDER_Y (([DeviceDetection isIPAD])?(20):(10))

/*
 TEXT_WIDTH_MAX 是消息的最大长度
 TEXT_HEIGHT_MAX  是消息的最大高度
 TEXT_FONT_SIZE  是字体
 SPACE_Y  是上一个气泡图与下一个的距离
 SCREEN_WIDTH    是屏幕宽度
 TEXTVIEW_BORDER_X  是TextView的文字与左或右边界的宽度
 TEXTVIEW_BORDER_Y  是TextView的文字与上或下边界的宽度
 BUBBLE_TIP_WIDTH   是气泡图尖角的宽度
 BUBBLE_NOT_TIP_WIDTH 是气泡图非尖角的宽度
 */
- (UIView *)bubbleView:(ChatMessage *)message
{
    UIView *returnView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
	returnView.backgroundColor = [UIColor clearColor];
    
    BOOL fromSelf = [message.from isEqualToString:[[UserManager defaultManager] userId]];
	UIImage *bubble = [UIImage imageNamed:fromSelf ? @"sent_message.png" : @"receive_message.png"];
	UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:[bubble stretchableImageWithLeftCapWidth:14 topCapHeight:14]];
    bubbleImageView.backgroundColor =[UIColor clearColor];
    
    
    if ([message.text length] > 0) {
        UIFont *font = [UIFont systemFontOfSize:TEXT_FONT_SIZE];
        
        //string的大小
        CGSize textSize = [message.text sizeWithFont:font constrainedToSize:CGSizeMake(TEXT_WIDTH_MAX, TEXT_HEIGHT_MAX) lineBreakMode:UILineBreakModeCharacterWrap];
        
        //设置文本
        CGRect contentTextViewFrame;
        if (fromSelf){
            contentTextViewFrame = CGRectMake(BUBBLE_NOT_TIP_WIDTH, 0, textSize.width+2*TEXTVIEW_BORDER_X, textSize.height+ 2*TEXTVIEW_BORDER_Y);
        }else {
            contentTextViewFrame = CGRectMake(BUBBLE_TIP_WIDTH, 0, textSize.width+2*TEXTVIEW_BORDER_X, textSize.height+ 2*TEXTVIEW_BORDER_Y);
        }
        UITextView *contentTextView = [[UITextView alloc] initWithFrame:contentTextViewFrame];
        contentTextView.delegate = self;
        contentTextView.backgroundColor = [UIColor clearColor];
        contentTextView.font = font;
        contentTextView.text = message.text;
        
        
        //设置气泡的frame
        bubbleImageView.frame = CGRectMake(0.0f, SPACE_Y, contentTextView.frame.size.width+BUBBLE_TIP_WIDTH + BUBBLE_NOT_TIP_WIDTH, contentTextView.frame.size.height);
        
        [bubbleImageView addSubview:contentTextView];
        [contentTextView release];
        
    }else {
        //to do
        NSArray* drawActionList = [[ChatMessageManager defaultManager] unarchiveDataToDrawActionList:message.drawData];
        
        //设置图片
        //UIImage *thumbImage = [self createThumbImageBy:drawActionList];
        ShowDrawView *thumbImageView = [self createThumbImageBy:drawActionList];
        
        //UIImageView *thumbImageView = [[UIImageView alloc] initWithImage:thumbImage];
        CGRect thumbFrame = thumbImageView.frame;
        
        if (fromSelf){
            thumbFrame = CGRectMake(BUBBLE_NOT_TIP_WIDTH + IMAGE_BORDER_X, IMAGE_BORDER_Y, IMAGE_WIDTH_MAX, IMAGE_WIDTH_MAX );
        }else {
            thumbFrame = CGRectMake(BUBBLE_TIP_WIDTH + IMAGE_BORDER_X, IMAGE_BORDER_Y, IMAGE_WIDTH_MAX, IMAGE_WIDTH_MAX);
        }
        thumbImageView.frame = thumbFrame;
        
        //设置气泡的frame
        bubbleImageView.frame = CGRectMake(0.0f, SPACE_Y, thumbImageView.frame.size.width+BUBBLE_TIP_WIDTH + BUBBLE_NOT_TIP_WIDTH + 2*IMAGE_BORDER_X, thumbImageView.frame.size.width + 2*IMAGE_BORDER_Y);
        
        [bubbleImageView addSubview:thumbImageView];
        //[thumbImageView release];
    }
    
    
    //设置returnView的frame
    if(fromSelf)
        returnView.frame = CGRectMake(SCREEN_WIDTH-bubbleImageView.frame.size.width, 0, bubbleImageView.frame.size.width, bubbleImageView.frame.size.height + SPACE_Y);
    else
        returnView.frame = CGRectMake(0, 0, bubbleImageView.frame.size.width, bubbleImageView.frame.size.height + SPACE_Y);
    
    [returnView addSubview:bubbleImageView];
    [bubbleImageView release];
    
    return returnView;
}





- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatMessage *message = (ChatMessage *)[dataList objectAtIndex:indexPath.row];
    UIView *view = [self bubbleView:message];
    return view.frame.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"chatDetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    
    ChatMessage *message = (ChatMessage *)[dataList objectAtIndex:indexPath.row];
    UIView *view = [self bubbleView:message];
    
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell.contentView addSubview:view];
    
    return cell;
}


- (IBAction)clickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickGraffitiButton:(id)sender {

    OfflineDrawViewController *odc = [[OfflineDrawViewController alloc] initWithTargetType:TypeGraffiti delegate:self];
    self.offlineDrawViewController = odc;
    [odc release];
    
    PPDebug(@"offlineDrawViewController:%d",[_offlineDrawViewController retainCount]);
    
    [self.view addSubview:_offlineDrawViewController.view];
    CGRect frame = _offlineDrawViewController.view.frame;
    _offlineDrawViewController.view.frame = CGRectMake(0, self.view.frame.size.height, frame.size.width, frame.size.height);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    _offlineDrawViewController.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    [UIImageView commitAnimations]; 
}

- (void)hideGraffitiView
{
    if (_offlineDrawViewController) {
        CGRect frame = _offlineDrawViewController.view.frame;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.4];
        _offlineDrawViewController.view.frame = CGRectMake(0, self.view.frame.size.height, frame.size.width, frame.size.height);
        [UIImageView commitAnimations];
    }
}

- (IBAction)clickSendButton:(id)sender {
    
    [[ChatService defaultService] sendMessage:self 
                                 friendUserId:_friendUserId 
                                         text:inputTextField.text 
                               drawActionList:nil];
    
    //test data
//    [[ChatMessageManager defaultManager] createMessageWithMessageId:@"999" 
//                                                               from:[[UserManager defaultManager] userId]
//                                                                 to:@"456" 
//                                                           drawData:nil 
//                                                         createDate:[NSDate date] 
//                                                               text:inputTextField.text  
//                                                             status:[NSNumber numberWithInt:MessageStatusNotRead]];
}


- (void)handleSingleTapFrom:(UITapGestureRecognizer*)recognizer {
    [inputTextField resignFirstResponder];
}


#pragma mark  - super Keyboard Methods
- (void)keyboardDidShowWithRect:(CGRect)keyboardRect
{
    CGRect frame = CGRectMake(0, 460 - keyboardRect.size.height - inputView.frame.size.height, inputView.frame.size.width, inputView.frame.size.height);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    inputView.frame = frame;
    [UIImageView commitAnimations]; 
}

- (void)keyboardDidHide:(NSNotification *)notification
{
    CGRect frame = CGRectMake(0, 460 - inputView.frame.size.height, inputView.frame.size.width, inputView.frame.size.height);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    inputView.frame = frame;
    [UIImageView commitAnimations]; 
}


#pragma mark - OfflineDrawDelegate
- (void)didClickBack
{
    [self hideGraffitiView];
}

- (void)didClickSubmit:(NSArray *)drawActionList
{
    [self hideGraffitiView];
  
    [[ChatService defaultService] sendMessage:self 
                                 friendUserId:_friendUserId 
                                         text:nil 
                               drawActionList:drawActionList];
}

@end
