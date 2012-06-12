//
//  ChatListController.m
//  Draw
//
//  Created by haodong qiu on 12年6月7日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import "ChatListController.h"
#import "ChatCell.h"
#import "ShareImageManager.h"
#import "ChatDetailController.h"
#import "MessageTotal.h"
#import "MessageTotalManager.h"
#import "ChatMessageManager.h"


#import "UserManager.h"

@interface ChatListController ()

- (IBAction)clickBack:(id)sender;
- (void)findAllMessageTotals;

@end

@implementation ChatListController
@synthesize titleLabel;
@synthesize addChatButton;

- (void)dealloc {
    [titleLabel release];
    [addChatButton release];
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
    [titleLabel setText:NSLS(@"kChatListTitle")];
    
    
    //test data
    [[MessageTotalManager defaultManager] createMessageTotalWithUserId:[[UserManager defaultManager] userId]
                                                          friendUserId:@"123" 
                                                        friendNickName:@"张三" 
                                                          friendAvatar:@"http://www.xiaake.cn/uploads/120606/9_094247_8.jpg" 
                                                            latestFrom:@"123"
                                                              latestTo:[[UserManager defaultManager] userId]
                                                        latestDrawData:nil 
                                                            latestText:@"早上好啊" 
                                                      latestCreateDate:[NSDate date] 
                                                       totalNewMessage:[NSNumber numberWithInt:1] 
                                                          totalMessage:[NSNumber numberWithInt:10]];
    
    [[MessageTotalManager defaultManager] createMessageTotalWithUserId:[[UserManager defaultManager] userId]
                                                          friendUserId:@"456" 
                                                        friendNickName:@"李四" 
                                                          friendAvatar:@"http://www.xiaake.cn/uploads/120606/9_094247_2.jpg" 
                                                            latestFrom:[[UserManager defaultManager] userId]
                                                              latestTo:@"456" 
                                                        latestDrawData:nil 
                                                            latestText:@"问那么多问为什么干嘛" 
                                                      latestCreateDate:[NSDate date] 
                                                       totalNewMessage:[NSNumber numberWithInt:1] 
                                                          totalMessage:[NSNumber numberWithInt:3]];
    
    [[ChatMessageManager defaultManager] createMessageWithMessageId:@"991" 
                                                                  from:@"123" 
                                                                    to:[[UserManager defaultManager] userId]
                                                              drawData:nil 
                                                            createDate:[NSDate date] 
                                                                  text:@"早上好啊"  
                                                                status:[NSNumber numberWithInt:MessageStatusNotRead]];
    
    [[ChatMessageManager defaultManager] createMessageWithMessageId:@"992" 
                                                               from:@"456"
                                                                 to:[[UserManager defaultManager] userId]
                                                           drawData:nil 
                                                         createDate:[NSDate date] 
                                                               text:@"为什么"  
                                                             status:[NSNumber numberWithInt:MessageStatusNotRead]];
    
    [[ChatMessageManager defaultManager] createMessageWithMessageId:@"993" 
                                                               from:[[UserManager defaultManager] userId]
                                                                 to:@"456" 
                                                           drawData:nil 
                                                         createDate:[NSDate date] 
                                                               text:@"问那么多问什么干嘛"  
                                                             status:[NSNumber numberWithInt:MessageStatusNotRead]];
    

    
    
    self.dataList = [[MessageTotalManager defaultManager] findAllMessageTotals];
    PPDebug(@"%d",[dataList count]);
    
    //[self findAllMessageTotals];
}


- (void)viewDidUnload
{
    [self setTitleLabel:nil];
    [self setAddChatButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)findAllMessageTotals
{
    [[ChatService defaultService] findAllMessageTotals:self starOffset:0 maxCount:100];
}

- (void)didFindAllMessageTotals:(NSArray *)totalList
{
    self.dataList = totalList;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ChatCell getCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indentifier = [ChatCell getCellIdentifier];
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [ChatCell createCell:self];
    }
    
    MessageTotal *messageTotal = (MessageTotal *)[dataList objectAtIndex:indexPath.row];
    [cell setCellByMessageTotal:messageTotal indexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageTotal *messageTotal = (MessageTotal *)[dataList objectAtIndex:indexPath.row];
    NSString *selectFriendUserId = messageTotal.friendUserId;
    ChatDetailController *controller = [[ChatDetailController alloc] initWithFriendUserId:selectFriendUserId];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}

- (IBAction)clickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
