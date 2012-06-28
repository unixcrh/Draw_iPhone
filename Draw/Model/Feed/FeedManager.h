//
//  FeedManager.h
//  Draw
//
//  Created by  on 12-6-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Feed.h"

typedef enum{
    ActionTypeHidden = 0,
    ActionTypeOneMore = 1,
    ActionTypeGuess = 2,
    ActionTypeCorrect = 3
}ActionType;

typedef enum{
    FeedActionDescNo = 0,
    FeedActionDescGuessed = 1,
    FeedActionDescTried,
    FeedActionDescDrawed,
    FeedActionDescDrawedToUser,
    
    FeedActionDescDrawedNoWord = 1001,
    FeedActionDescGuessedNoWord,
    FeedActionDescTriedNoWord,
    FeedActionDescDrawedToUserNoWord,    
    
    
}FeedActionDescType;


@interface FeedManager : NSObject
{
    NSMutableDictionary *_dataMap;
}
+ (FeedManager *)defaultManager;
- (NSMutableArray *)feedListForType:(FeedListType)type;
- (void)setFeedList:(NSMutableArray *)feedList forType:(FeedListType)type;
- (void)addFeedList:(NSArray *)feedList forType:(FeedListType)type;
- (void)cleanData;


+ (ActionType)actionTypeForFeed:(Feed *)feed;
+ (NSString *)userNameForFeed:(Feed *)feed;
+ (NSString *)opusCreatorForFeed:(Feed *)feed;
+ (FeedActionDescType)feedActionDescFor:(Feed *)feed;

@end
