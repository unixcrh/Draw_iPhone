//
//  FeedService.m
//  Draw
//
//  Created by  on 12-6-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FeedService.h"
#import "GameNetworkRequest.h"
#import "GameNetworkConstants.h"
#import "PPNetworkRequest.h"
#import "GameMessage.pb.h"
#import "GameBasic.pb.h"
#import "UserManager.h"
#import "GameNetworkConstants.h"
#import "ConfigManager.h"
#import "ItemType.h"

static FeedService *_staticFeedService = nil;
@implementation FeedService

+ (FeedService *)defaultService
{
    if (_staticFeedService == nil) {
        _staticFeedService = [[FeedService alloc] init];
    }
    return _staticFeedService;
}

- (void)getFeedList:(FeedListType)feedListType 
             offset:(NSInteger)offset 
              limit:(NSInteger)limit 
           delegate:(PPViewController<FeedServiceDelegate> *)delegate;
{
    
    NSString *userId = [[UserManager defaultManager] userId];
    LanguageType lang = UnknowType;
    lang = [[UserManager defaultManager] getLanguageType];
    
    dispatch_async(workingQueue, ^{
        
        CommonNetworkOutput* output = [GameNetworkRequest 
                                       getFeedListWithProtocolBuffer:TRAFFIC_SERVER_URL 
                                       userId:userId 
                                       feedListType:feedListType 
                                       offset:offset 
                                       limit:limit 
                                       lang:lang];
        NSArray *list = nil;
        NSInteger resultCode = output.resultCode;
        if (resultCode == ERROR_SUCCESS){
            PPDebug(@"<FeedService> getFeedList finish, start to parse data.");
            [delegate showActivityWithText:NSLS(@"kParsingData")];
            DataQueryResponse *response = [DataQueryResponse parseFromData:output.responseData];
            resultCode = [response resultCode];
            NSArray *pbFeedList = [response feedList];
            list = [FeedManager parsePbFeedList:pbFeedList];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (delegate && [delegate respondsToSelector:@selector(didGetFeedList:feedListType:resultCode:)]) {
                [delegate didGetFeedList:list feedListType:feedListType resultCode:resultCode];
            }
            
        });
    });

}

- (void)getUserFeedList:(NSString *)userId
                 offset:(NSInteger)offset 
                  limit:(NSInteger)limit 
               delegate:(PPViewController<FeedServiceDelegate> *)delegate
{
    dispatch_async(workingQueue, ^{
        
        CommonNetworkOutput* output = [GameNetworkRequest 
                                       getFeedListWithProtocolBuffer:TRAFFIC_SERVER_URL 
                                       userId:userId 
                                       feedListType:FeedListTypeUser 
                                       offset:offset 
                                       limit:limit 
                                       lang:UnknowType];
        NSArray *list = nil;
        NSInteger resultCode = output.resultCode;
        if (resultCode == ERROR_SUCCESS){
            PPDebug(@"<FeedService> getUserFeedList finish, start to parse data.");
            [delegate showActivityWithText:NSLS(@"kParsingData")];
            DataQueryResponse *response = [DataQueryResponse parseFromData:output.responseData];
            resultCode = [response resultCode];
            NSArray *pbFeedList = [response feedList];
            list = [FeedManager parsePbFeedList:pbFeedList];
        }
        PPDebug(@"<FeedService> parse data finish, start display the views.");        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (delegate && [delegate respondsToSelector:@selector(didGetFeedList:targetUser:resultCode:)]) {
                [delegate didGetFeedList:list targetUser:userId resultCode:resultCode];
            }
        });
    });
}

- (void)getOpusCommentList:(NSString *)opusId
                    offset:(NSInteger)offset 
                     limit:(NSInteger)limit 
                  delegate:(id<FeedServiceDelegate>)delegate
{
    dispatch_async(workingQueue, ^{
        
        CommonNetworkOutput* output = [GameNetworkRequest 
                                       getFeedCommentListWithProtocolBuffer:TRAFFIC_SERVER_URL opusId:opusId offset:offset limit:limit];
        NSArray *list = nil;
        NSInteger resultCode = output.resultCode;
        if (resultCode == ERROR_SUCCESS){
            DataQueryResponse *response = [DataQueryResponse parseFromData:output.responseData];
            resultCode = [response resultCode];
            NSArray *pbFeedList = [response feedList];
            list = [FeedManager parsePbCommentFeedList:pbFeedList];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (delegate && [delegate respondsToSelector:@selector(didGetFeedCommentList:opusId:resultCode:)]) {
                [delegate didGetFeedCommentList:list opusId:opusId resultCode:resultCode];
            }            
        });
    });

}

- (void)getFeedByFeedId:(NSString *)feedId 
               delegate:(id<FeedServiceDelegate>)delegate
{
    dispatch_async(workingQueue, ^{
        NSString* userId = [[UserManager defaultManager] userId];
        
        CommonNetworkOutput* output = [GameNetworkRequest 
                                       getFeedWithProtocolBuffer:TRAFFIC_SERVER_URL 
                                       userId:userId feedId:feedId];
        
            DrawFeed *feed = nil;
            NSInteger resultCode = [output resultCode];            
            if (output.resultCode == ERROR_SUCCESS && [output.responseData length] > 0) {
                DataQueryResponse *response = [DataQueryResponse parseFromData:output.responseData];
                NSArray *list = [response feedList];
                PBFeed *pbFeed = ([list count] != 0) ? [list objectAtIndex:0] : nil;
                if (pbFeed && (pbFeed.actionType == FeedTypeDraw || pbFeed.actionType == FeedTypeDrawToUser)) {
                    feed = [[[DrawFeed alloc] initWithPBFeed:pbFeed] autorelease];
                    [feed parseDrawData:pbFeed];
                }
                resultCode = [response resultCode];
            }        
            dispatch_async(dispatch_get_main_queue(), ^{
                if (delegate && [delegate respondsToSelector:@selector(didGetFeed:resultCode:)]) {
                    [delegate didGetFeed:feed resultCode:resultCode];
                }           
            });
        });
}


- (void)commentOpus:(NSString *)opusId 
             author:(NSString *)author 
            comment:(NSString *)comment            
           delegate:(id<FeedServiceDelegate>)delegate
{
    NSString* userId = [[UserManager defaultManager] userId];
    NSString* nick = [[UserManager defaultManager] nickName];
    NSString* gender = [[UserManager defaultManager] gender];
    NSString* avatar = [[UserManager defaultManager] avatarURL];
    NSString* appId = [ConfigManager appId];
    

    dispatch_async(workingQueue, ^{
        CommonNetworkOutput* output = [GameNetworkRequest commentOpus:TRAFFIC_SERVER_URL appId:appId userId:userId nick:nick avatar:avatar gender:gender opusId:opusId opusCreatorUId:author comment:comment];
        NSString *commentId = nil;
        if (output.resultCode == 0) {
            commentId = [output.jsonDataDict objectForKey:PARA_FEED_ID];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (delegate && [delegate respondsToSelector:@selector(didCommentOpus:commentFeedId:comment:resultCode:)]){
                [delegate didCommentOpus:opusId 
                           commentFeedId:commentId
                                 comment:comment 
                              resultCode:output.resultCode];
            }
        });
    });
    
}

- (void)deleteFeed:(Feed *)feed
          delegate:(id<FeedServiceDelegate>)delegate
{
        NSString* userId = [[UserManager defaultManager] userId];
        NSString* appId = [ConfigManager appId];
    
        dispatch_async(workingQueue, ^{
            CommonNetworkOutput* output = [GameNetworkRequest deleteFeed:TRAFFIC_SERVER_URL appId:appId feedId:feed.feedId userId:userId];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (delegate && [delegate respondsToSelector:@selector(didDeleteFeed:resultCode:)]) {
                    [delegate didDeleteFeed:feed resultCode:output.resultCode];
                }
            });
        });

}

- (void)throwItem:(ItemType)itemType toOpus:(NSString *)opusId 
                   author:(NSString *)author   
                 delegate:(id<FeedServiceDelegate>)delegate
{
    NSString* userId = [[UserManager defaultManager] userId];
    NSString* nick = [[UserManager defaultManager] nickName];
    NSString* gender = [[UserManager defaultManager] gender];
    NSString* avatar = [[UserManager defaultManager] avatarURL];
    NSString* appId = [ConfigManager appId];
    
    
    dispatch_async(workingQueue, ^{
        CommonNetworkOutput* output = [GameNetworkRequest throwItemToOpus:TRAFFIC_SERVER_URL appId:appId userId:userId nick:nick avatar:avatar gender:gender opusId:opusId opusCreatorUId:author itemType:itemType];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (itemType == ItemTypeFlower && delegate && [delegate respondsToSelector:@selector(didThrowFlowerToOpus:resultCode:)]) {
                [delegate didThrowFlowerToOpus:opusId resultCode:output.resultCode];
                
            }else if(itemType == ItemTypeTomato && delegate && [delegate respondsToSelector:@selector(didThrowTomatoToOpus:resultCode:)]){
                [delegate didThrowTomatoToOpus:opusId resultCode:output.resultCode];
                
            }
        });
    });

}


- (void)throwFlowerToOpus:(NSString *)opusId 
                   author:(NSString *)author  
                 delegate:(id<FeedServiceDelegate>)delegate
{
    [self throwItem:ItemTypeFlower toOpus:opusId author:author delegate:delegate];
}

- (void)throwTomatoToOpus:(NSString *)opusId 
                   author:(NSString *)author 
                 delegate:(id<FeedServiceDelegate>)delegate;
{
    [self throwItem:ItemTypeTomato toOpus:opusId author:author delegate:delegate];    
}

- (void)actionSaveOpus:(NSString *)opusId 
            actionName:(NSString*)actionName
{
    NSString* userId = [[UserManager defaultManager] userId];
    NSString* appId = [ConfigManager appId];    
    
    dispatch_async(workingQueue, ^{
        CommonNetworkOutput* output = [GameNetworkRequest actionSaveOnOpus:TRAFFIC_SERVER_URL appId:appId userId:userId actionName:actionName opusId:opusId];
        
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//        });
    });
    
}

@end
