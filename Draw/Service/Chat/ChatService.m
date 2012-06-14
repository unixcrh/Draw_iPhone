//
//  ChatService.m
//  Draw
//
//  Created by haodong qiu on 12年6月8日.
//  Copyright (c) 2012年 orange. All rights reserved.
//

#import "ChatService.h"
#import "GameNetworkRequest.h"
#import "GameNetworkConstants.h"
#import "UserManager.h"
#import "PPNetworkRequest.h"
#import "LogUtil.h"
#import "GameMessage.pb.h"
#import "GameBasic.pb.h"
#import "ChatMessageManager.h"
#import "MessageTotalManager.h"
#import "DrawDataService.h"

static ChatService *_chatService = nil;

@implementation ChatService

+ (ChatService*)defaultService
{
    if (_chatService == nil) {
        _chatService = [[ChatService alloc] init];
    }
    return _chatService;
}


- (void)findAllMessageTotals:(id<ChatServiceDelegate>)delegate 
                  starOffset:(int)starOffset 
                    maxCount:(int)maxCount
{
    NSString *userId = [[UserManager defaultManager] userId];
    
    dispatch_async(workingQueue, ^{            
        CommonNetworkOutput* output = [GameNetworkRequest getUserMessage:TRAFFIC_SERVER_URL 
                                                                   appId:APP_ID 
                                                                  userId:userId
                                                            friendUserId:nil 
                                                             startOffset:starOffset 
                                                                maxCount:maxCount];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            
            if (output.resultCode == ERROR_SUCCESS){
                
                //to do save data
                DataQueryResponse *travelResponse = [DataQueryResponse parseFromData:output.responseData];
                NSArray *messageStatList = [travelResponse messageStatList];
                for (PBMessageStat *pbMessageStat in messageStatList) {
                    [[MessageTotalManager defaultManager] createByPBMessageStat:pbMessageStat];
                }
                
                PPDebug(@"<ChatService>findAllMessageTotals success");
            }else {
                PPDebug(@"<ChatService>findAllMessageTotals failed");
            }
            
            if (delegate && [delegate respondsToSelector:@selector(didFindAllMessageTotals:)]){
                NSArray *array = [[MessageTotalManager defaultManager] findAllMessageTotals];
                [delegate didFindAllMessageTotals:array];
            }
        }); 
    });
}


- (void)findAllMessages:(id<ChatServiceDelegate>)delegate 
           friendUserId:(NSString *)friendUserId 
             starOffset:(int)starOffset 
               maxCount:(int)maxCount
{
    NSString *userId = [[UserManager defaultManager] userId];
    
    dispatch_async(workingQueue, ^{            
        CommonNetworkOutput* output = [GameNetworkRequest getUserMessage:TRAFFIC_SERVER_URL 
                                                                   appId:APP_ID 
                                                                  userId:userId
                                                            friendUserId:friendUserId 
                                                             startOffset:starOffset 
                                                                maxCount:maxCount];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (output.resultCode == ERROR_SUCCESS){
                
                //to do save data
                DataQueryResponse *travelResponse = [DataQueryResponse parseFromData:output.responseData];
                NSArray *messageList = [travelResponse messageList];
                for (PBMessage *pbMessage in messageList) {
                    [[ChatMessageManager defaultManager] createByPBMessage:pbMessage];
                }
                
                PPDebug(@"<ChatService>findAllMessages success");
            }else {
                PPDebug(@"<ChatService>findAllMessages failed");
            }
            
            if (delegate && [delegate respondsToSelector:@selector(didFindAllMessagesByFriendUserId:)]){
                NSArray *array = [[ChatMessageManager defaultManager] findMessagesByFriendUserId:friendUserId];
                [delegate didFindAllMessagesByFriendUserId:array];
            }
        }); 
    });
}


- (void)sendMessage:(id<ChatServiceDelegate>)delegate
       friendUserId:(NSString *)friendUserId
               text:(NSString *)text 
     drawActionList:(NSArray*)drawActionList; 
{
    NSString *userId = [[UserManager defaultManager] userId];
    
    PBDraw *draw = nil;
    NSData *data = nil;
    if (drawActionList != nil) {
        draw = [[DrawDataService defaultService] buildPBDraw:nil 
                                                        nick:nil 
                                                      avatar:nil
                                              drawActionList:drawActionList
                                                    drawWord:nil 
                                                    language:ChineseType];
        data = [draw data];
    }
    
    dispatch_async(workingQueue, ^{            
        CommonNetworkOutput* output = [GameNetworkRequest sendMessage:TRAFFIC_SERVER_URL 
                                                                appId:APP_ID 
                                                               userId:userId 
                                                         targetUserId:friendUserId 
                                                                 text:text
                                                                 data:data];
        
        NSString* messageId = [output.jsonDataDict objectForKey:PARA_MESSAGE_ID];
        NSData* dataForSave = [NSKeyedArchiver archivedDataWithRootObject:drawActionList];
        
        [[ChatMessageManager defaultManager] createMessageWithMessageId:messageId 
                                                                   from:userId 
                                                                     to:friendUserId 
                                                               drawData:dataForSave
                                                             createDate:[NSDate date] 
                                                                   text:text 
                                                                 status:[NSNumber numberWithInt:MessageStatusSendSuccess]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (output.resultCode == ERROR_SUCCESS){
                NSString* messageId = [output.jsonDataDict objectForKey:PARA_MESSAGE_ID];
                NSData* dataForSave = [NSKeyedArchiver archivedDataWithRootObject:drawActionList];
                
                [[ChatMessageManager defaultManager] createMessageWithMessageId:messageId 
                                                                           from:userId 
                                                                             to:friendUserId 
                                                                       drawData:dataForSave
                                                                     createDate:[NSDate date] 
                                                                           text:text 
                                                                         status:[NSNumber numberWithInt:MessageStatusSendSuccess]];
                PPDebug(@"<ChatService>sendMessage success");
            }else {
                PPDebug(@"<ChatService>sendMessage failed");
            }
            
            if (delegate && [delegate respondsToSelector:@selector(didSendMessage:)]){
                [delegate didSendMessage:output.resultCode];
            }
        }); 
    });
}


- (void)sendHasReadMessage:(id<ChatServiceDelegate>)delegate friendUserId:(NSString *)friendUserId 
{
    NSString *userId = [[UserManager defaultManager] userId];
    
    dispatch_async(workingQueue, ^{
        //要改成可以发送一个messageId列表
        CommonNetworkOutput* output = [GameNetworkRequest userHasReadMessage:TRAFFIC_SERVER_URL 
                                                                       appId:APP_ID 
                                                                      userId:userId 
                                                                friendUserId:friendUserId];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (output.resultCode == ERROR_SUCCESS){
                PPDebug(@"<ChatService>sendHasReadMessage success");
            }else {
                PPDebug(@"<ChatService>sendHasReadMessage failed");
            }
            
            if (delegate && [delegate respondsToSelector:@selector(didSendHasReadMessage:)]){
                [delegate didSendHasReadMessage:output.resultCode];
            }
        }); 
    });
}

@end
