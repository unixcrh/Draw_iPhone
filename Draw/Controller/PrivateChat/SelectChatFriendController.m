//
//  SelectChatFriendController.m
//  Draw
//
//  Created by haodong qiu on 12年6月13日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import "SelectChatFriendController.h"
#import "Friend.h"
#import "FriendCell.h"
#import "FriendManager.h"
#import "ChatDetailController.h"
#import "ShareImageManager.h"

@interface SelectChatFriendController ()
- (IBAction)clickCancel:(id)sender;
@end

@implementation SelectChatFriendController
@synthesize delegate;
@synthesize cancelButton;
@synthesize titleLabel;


- (void)viewDidLoad
{
    [super viewDidLoad];
    [titleLabel setText:NSLS(@"kSelectContacts")];
    
    ShareImageManager *imageManager = [ShareImageManager defaultManager];
    [cancelButton setBackgroundImage:[imageManager orangeImage] forState:UIControlStateNormal];
    [cancelButton setTitle:NSLS(@"kCancel") forState:UIControlStateNormal];
    
    self.dataList = [[FriendManager defaultManager] findAllFollowFriends];
}

- (void)viewDidUnload
{
    [self setCancelButton:nil];
    [self setTitleLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [FriendCell getCellHeight];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath == nil) {
        return nil;
    }
    NSString *indentifier = [FriendCell getCellIdentifier];
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [FriendCell createCell:self];
    }
    
    Friend *friend = [dataList objectAtIndex:[indexPath row]];
    [cell setCellWithFriend:friend indexPath:indexPath fromType:FromFriendList];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Friend *aFriend = [dataList objectAtIndex:indexPath.row];
    if (delegate && [delegate respondsToSelector:@selector(didSelectFriend:)]) {
        [delegate didSelectFriend:aFriend];
    }
}


- (IBAction)clickCancel:(id)sender {
    if (delegate && [delegate respondsToSelector:@selector(didCancel)]) {
        [delegate didCancel];
    }
}

- (void)dealloc {
    [cancelButton release];
    [titleLabel release];
    [super dealloc];
}
@end
