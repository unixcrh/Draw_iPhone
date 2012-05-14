//
//  SearchUserController.m
//  Draw
//
//  Created by haodong qiu on 12年5月8日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import "SearchUserController.h"
#import "ShareImageManager.h"
#import "UIImageUtil.h"
#import "DeviceDetection.h"
#import "FriendService.h"
#import "LogUtil.h"
#import "HJManagedImageV.h"
#import "PPApplication.h"
#import "FriendManager.h"
#import "GameNetworkConstants.h"
#import "TimeUtils.h"

@interface SearchUserController ()

@property (assign, nonatomic) int selectedIndex;
- (void)clickFollowButton:(id)sender;
- (void)createCellContent:(UITableViewCell *)cell;

@end

@implementation SearchUserController
@synthesize searchButton;
@synthesize titleLabel;
@synthesize resultLabel;
@synthesize inputImageView;
@synthesize inputTextField;
@synthesize selectedIndex;

- (void)dealloc {
    [searchButton release];
    [titleLabel release];
    [resultLabel release];
    [inputTextField release];
    [inputImageView release];
    [super dealloc];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [titleLabel setText:NSLS(@"kAddFriend")];
    
    ShareImageManager *imageManager = [ShareImageManager defaultManager];
    
    [inputImageView setImage:[imageManager inputImage]];
    [inputTextField setPlaceholder:NSLS(@"kSearchUserPlaceholder")];
    
    [searchButton setBackgroundImage:[imageManager orangeImage] forState:UIControlStateNormal];
    [searchButton setTitle:NSLS(@"kSearch") forState:UIControlStateNormal];
    
    resultLabel.textColor = [UIColor colorWithRed:105.0/255.0 green:50.0/255.0 blue:12.0/255.0 alpha:1.0];
    resultLabel.hidden = YES;
    
    dataTableView.separatorColor = [UIColor colorWithRed:175.0/255.0 green:124.0/255.0 blue:68.0/255.0 alpha:1.0];
    dataTableView.hidden = YES;
    
    [inputTextField becomeFirstResponder];
}


- (void)viewDidUnload
{
    [self setSearchButton:nil];
    [self setTitleLabel:nil];
    [self setResultLabel:nil];
    [self setInputTextField:nil];
    [self setInputImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


#define CELL_HEIGHT_IPHONE  55
#define CELL_HEIGHT_IPAD    110
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([DeviceDetection isIPAD]) {
        return CELL_HEIGHT_IPAD;
    }else {
        return CELL_HEIGHT_IPHONE;
    }
}


#define AVATAR_TAG  71
#define NICK_TAG    72
#define STATUS_TAG  73
#define FOLLOW_TAG  74
- (void)createCellContent:(UITableViewCell *)cell
{
    CGFloat cellHeight, avatarWidth, avatarHeight, nickWidth, nickHeight, space, statusWidth, statusHeight, nickLabelFont, statusLabelFont, edge;
    cellHeight = CELL_HEIGHT_IPHONE;
    avatarWidth = 37;
    avatarHeight = 39;
    nickWidth = 100;
    nickHeight = 40;
    space = 6;
    statusWidth = 66;
    statusHeight = 26;
    nickLabelFont = 14;
    statusLabelFont = 13;
    edge = 2;
    
    if ([DeviceDetection isIPAD]) {
        cellHeight = CELL_HEIGHT_IPAD;
        avatarWidth = 2 * avatarWidth;
        avatarHeight = 2 * avatarHeight;
        nickWidth = 2 * nickWidth;
        nickHeight = 2 * nickHeight;
        space = 2 * space;
        statusWidth = 2 * statusWidth;
        statusHeight = 2 * statusHeight;
        nickLabelFont = 2 * nickLabelFont;
        statusLabelFont = 2 * statusLabelFont;
        edge = 2 * edge;
    }
    
    UIImageView *avatarBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, (cellHeight-avatarHeight)/2, avatarWidth, avatarHeight)];
    [avatarBackground setImage:[UIImage imageNamed:@"user_picbg.png"]];
    [cell.contentView addSubview:avatarBackground];
    [avatarBackground release];
    
    HJManagedImageV *avatarImageView = [[HJManagedImageV alloc] initWithFrame:CGRectMake(edge, (cellHeight-avatarHeight)/2 + edge, avatarWidth-2*edge, avatarWidth-2*edge)];
    avatarImageView.tag = AVATAR_TAG;
    [cell.contentView addSubview:avatarImageView];
    [avatarImageView release];
    
    UILabel *nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(avatarWidth+space, (cellHeight-nickHeight)/2, nickWidth, nickHeight)];
    nickLabel.backgroundColor = [UIColor clearColor];
    nickLabel.font = [UIFont systemFontOfSize:nickLabelFont];
    nickLabel.textColor = [UIColor colorWithRed:105.0/255.0 green:50.0/255.0 blue:12.0/255.0 alpha:1.0];
    nickLabel.tag = NICK_TAG;
    [cell.contentView addSubview:nickLabel];
    [nickLabel release];    
    
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(avatarWidth + nickWidth + 2*space, (cellHeight-statusHeight)/2, statusWidth, statusHeight)];
    statusLabel.font = [UIFont systemFontOfSize:statusLabelFont];
    statusLabel.backgroundColor = [UIColor clearColor];
    statusLabel.tag = STATUS_TAG;
    [cell.contentView addSubview:statusLabel];
    [statusLabel release];
    
    UIView *followView = [[UIView alloc] initWithFrame:CGRectMake(avatarWidth + nickWidth + 2*space, (cellHeight-statusHeight)/2, statusWidth, statusHeight)];
    followView.tag = FOLLOW_TAG;
    [cell.contentView addSubview:followView];
    [followView release];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SearchUserCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier]autorelease];
        
        [self createCellContent:cell];
    }
    HJManagedImageV *avatarImageView = (HJManagedImageV *)[cell.contentView viewWithTag:AVATAR_TAG];
    UILabel *nickLabel = (UILabel *)[cell.contentView viewWithTag:NICK_TAG];
    UILabel *statusLabel = (UILabel *)[cell.contentView viewWithTag:STATUS_TAG];
    UIView  *followView = (UIView *)[cell.contentView viewWithTag:FOLLOW_TAG];
    
    NSDictionary *userDic = (NSDictionary *)[dataList objectAtIndex:[indexPath row]];
    NSString* userId = [userDic objectForKey:PARA_USERID];
    NSString* avatar = [userDic objectForKey:PARA_AVATAR];
    NSString* gender = [userDic objectForKey:PARA_GENDER];
    NSString* nickName = [userDic objectForKey:PARA_NICKNAME];
    NSString* sinaNick = [userDic objectForKey:PARA_SINA_NICKNAME];
    NSString* qqNick = [userDic objectForKey:PARA_QQ_NICKNAME];
    NSString* facebookNick = [userDic objectForKey:PARA_FACEBOOK_NICKNAME];
    
    //set avatar
    if ([gender isEqualToString:MALE])
    {
        [avatarImageView setImage:[[ShareImageManager defaultManager] maleDefaultAvatarImage]];
    }else {
        [avatarImageView setImage:[[ShareImageManager defaultManager] femaleDefaultAvatarImage]];
    }
    [avatarImageView setUrl:[NSURL URLWithString:avatar]];
    [GlobalGetImageCache() manage:avatarImageView];
    
    
    //set nick
    if (nickName) {
        nickLabel.text = nickName;
    }
    else if (sinaNick){
        nickLabel.text = sinaNick;
    }
    else if (qqNick){
        nickLabel.text = qqNick;
    }
    else if (facebookNick){
        nickLabel.text = facebookNick;
    }
    
    
    CGFloat followButtonFont = 13;
    if ([DeviceDetection isIPAD]) {
        followButtonFont = 2 * followButtonFont;
    }
    UIButton *followButton = [[UIButton alloc] initWithFrame:followView.bounds];
    [followButton setBackgroundImage:[[ShareImageManager defaultManager] normalButtonImage] forState:UIControlStateNormal];
    [followButton.titleLabel setFont:[UIFont systemFontOfSize:followButtonFont]];
    [followButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [followButton setTitle:NSLS(@"kAddFriend") forState:UIControlStateNormal];
    followButton.tag = [indexPath row];
    [followButton addTarget:self action:@selector(clickFollowButton:) forControlEvents:UIControlEventTouchUpInside];
    [followView addSubview:followButton];
    [followButton release];
    
    //set button or label
    if ([[FriendManager defaultManager] isFollowFriend:userId]) {
        statusLabel.hidden = NO;
        followView.hidden = YES;
        statusLabel.text = NSLS(@"kAlreadyBeFriend");
    }
    else if ([[[UserManager defaultManager] userId] isEqualToString:userId]){
        statusLabel.hidden = NO;
        followView.hidden = YES;
        statusLabel.text = NSLS(@"kMyself");
    }
    else {
        statusLabel.hidden = YES;
        followView.hidden = NO; 
    }
    
    return cell;
}


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


#pragma -mark Button Action
- (IBAction)clickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)backgroundTap:(id)sender
{
    [inputTextField resignFirstResponder];
}


- (IBAction)clickSearch:(id)sender
{
    [inputTextField resignFirstResponder];
    
    if ([inputTextField.text length] == 0) {
        resultLabel.hidden = NO;
        dataTableView.hidden = YES;
        [resultLabel setText:NSLS(@"kEnterWords")];
    }else {
        [[FriendService defaultService] searchUsersByString:inputTextField.text viewController:self];
    }
}


- (void)clickFollowButton:(id)sender
{
    UIButton *button = (UIButton *)sender;
    selectedIndex = button.tag;
    NSDictionary *userDic = (NSDictionary *)[dataList objectAtIndex:selectedIndex];
    NSString* userId = [userDic objectForKey:PARA_USERID];
    
    [[FriendService defaultService] followUser:userId viewController:self
     ];
}


#pragma -mark FriendServiceDelegate Method
- (void)didSearchUsers:(NSArray *)userList result:(int)resultCode
{
    if (resultCode == 0)
    {
        self.dataList = userList;
        [dataTableView reloadData];
        if ([dataList count] == 0) {
            dataTableView.hidden = YES;
            resultLabel.hidden = NO;
            [resultLabel setText:NSLS(@"kDidNottFindThisUser")];
        }
        else {
            dataTableView.hidden = NO;
            resultLabel.hidden = YES;
        }
    }else {
        dataTableView.hidden = YES;
        resultLabel.hidden = NO;
        [resultLabel setText:NSLS(@"kSearchFailed")];
    }
}


- (void)didFollowUser:(int)resultCode
{
    if (resultCode == 0) {
        NSDictionary *userDic = (NSDictionary *)[dataList objectAtIndex:selectedIndex];
        NSString* userId = [userDic objectForKey:PARA_USERID];
        NSString* nickName = [userDic objectForKey:PARA_NICKNAME];
        NSString* avatar = [userDic objectForKey:PARA_AVATAR];     
        NSString* gender = [userDic objectForKey:PARA_GENDER];
        NSString* sinaId = [userDic objectForKey:PARA_SINA_ID];
        NSString* qqId = [userDic objectForKey:PARA_QQ_ID];
        NSString* facebookId = [userDic objectForKey:PARA_FACEBOOKID];
        NSString* sinaNick = [userDic objectForKey:PARA_SINA_NICKNAME];
        NSString* qqNick = [userDic objectForKey:PARA_QQ_NICKNAME];
        NSString* facebookNick = [userDic objectForKey:PARA_FACEBOOK_NICKNAME];
        NSString* lastModifiedDateStr = [userDic objectForKey:PARA_LASTMODIFIEDDATE];
        NSNumber* type = [NSNumber numberWithInt:FOLLOW];
        NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter setDateFormat:DEFAULT_DATE_FORMAT];
        NSDate* lastModifiedDate = [dateFormatter dateFromString:lastModifiedDateStr];
        
        [[FriendManager defaultManager] createFriendWithUserId:userId type:type nickName:nickName avatar:avatar gender:gender sinaId:sinaId qqId:qqId facebookId:facebookId sinaNick:sinaNick qqNick:qqNick facebookNick:facebookNick createDate:[NSDate date] lastModifiedDate:lastModifiedDate];
        
        [dataTableView reloadData];
    } else {
        [self popupMessage:NSLS(@"kFollowFailed") title:nil];
    }
    
}

@end