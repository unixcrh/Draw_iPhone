//
//  ChatService.h
//  Draw
//
//  Created by haodong qiu on 12年6月8日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonService.h"

@protocol ChatServiceDelegate <NSObject>

@optional
- (void)didFindAllMessageTotals:(NSArray *)totalList;
- (void)didFindAllMessagesByFriendUserId:(NSArray *)list;
- (void)didSendMessage:(int)resultCode;
- (void)didSendHasReadMessage:(int)resultCode;

@end

@interface ChatService : CommonService

+ (ChatService*)defaultService;

- (void)findAllMessageTotals:(id<ChatServiceDelegate>)delegate 
                  starOffset:(int)starOffset 
                    maxCount:(int)maxCount;

- (void)findAllMessages:(id<ChatServiceDelegate>)delegate 
           friendUserId:(NSString *)friendUserId 
             starOffset:(int)starOffset 
               maxCount:(int)maxCount;

- (void)sendMessage:(id<ChatServiceDelegate>)delegate
       friendUserId:(NSString *)friendUserId
               text:(NSString *)text 
               data:(NSData *)data;

- (void)sendHasReadMessage:(id<ChatServiceDelegate>)delegate messageIdArray:(NSArray*)messageIdArray; 

@end
