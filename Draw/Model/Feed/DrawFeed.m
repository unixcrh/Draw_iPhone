//
//  DrawFeed.m
//  Draw
//
//  Created by  on 12-8-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DrawFeed.h"
#import "Draw.h"
#import "ShareImageManager.h"

@implementation DrawFeed

@synthesize timesSet = _timesSet;
@synthesize drawImageUrl = _drawImageUrl;
@synthesize drawImage = _drawImage;
@synthesize drawData = _drawData;
@synthesize wordText = _wordText;

- (void)initTimeList:(NSArray *)feedTimesList
{
    if ([feedTimesList count] !=0 ) {
        NSMutableSet *set = [NSMutableSet set];
        for (PBFeedTimes *pbFeedTimes in feedTimesList) {
            FeedTimes *feedTimes = [FeedTimes feedTimesWithPbFeedTimes:pbFeedTimes];
            [set addObject:feedTimes];
        }            
        self.timesSet = set;
    }    
}



- (void)initDrawInfo:(NSString *)drawImageUrl drawData:(PBDraw *)drawData
{
    self.drawImageUrl = drawImageUrl;
    if ([self.drawImageUrl length] == 0) {
        PPDebug(@"<DrawFeed>initDrawInfo, drawImageUrl is nil, load image from local. feedID = %@",self.feedId);        
        
        //load draw data from local
        self.drawImage = [[ShareImageManager defaultManager] 
                          getImageWithName:self.feedId];
        
        if (self.drawImage == nil && drawData) {
            Draw* draw = [[Draw alloc]initWithPBDraw:drawData];
            self.drawData = draw;
            [draw release];
            PPDebug(@"<DrawFeed>initDrawInfo, drawImageUrl is nil, load image from local, feedID = %@",self.feedId);        
        }
    }else{
        PPDebug(@"<DrawFeed>initDrawInfo, drawImageUrl = %@,feedID = %@", self.drawImageUrl,self.feedId);
    }

}

- (id)initWithPBFeed:(PBFeed *)pbFeed
{
    self = [super initWithPBFeed:pbFeed];
    if (self) {
        //set times info
        [self initTimeList:pbFeed.feedTimesList];
        
        //set draw info
        self.wordText = pbFeed.opusWord;
        [self initDrawInfo:pbFeed.opusImage drawData:pbFeed.drawData];
    }
    return self;
}

- (void)parseDrawData:(PBFeed *)pbFeed
{
    if (self.drawData == nil && pbFeed.drawData != nil) {
        Draw* drawData = [[Draw alloc] initWithPBDraw:pbFeed.drawData];
        self.drawData = drawData;        
        [drawData release];
    }
}

- (id)initWithFeedId:(NSString *)feedId
              userId:(NSString *)userId 
            nickName:(NSString *)nickName 
              avatar:(NSString *)avatar 
              gender:(BOOL)gender 
        drawImageUrl:(NSString *)drawImageUrl 
              pbDraw:(PBDraw *)pbDraw 
            wordText:(NSString *)wordText 
          timesArray:(NSArray *)timesArray;
{
    self = [super init];
    if (self) {
        self.feedId = feedId;
        self.feedUser = [FeedUser feedUserWithUserId:userId 
                                            nickName:nickName 
                                              avatar:avatar 
                                              gender:gender];
        self.wordText = wordText;
        [self initTimeList:timesArray];
        [self initDrawInfo:drawImageUrl drawData:pbDraw];
    }
    return self;
}

- (void)updateDesc
{
    if ([self isMyOpus]) {
        self.desc = [NSString stringWithFormat:NSLS(@"kDrawDesc"), self.wordText];      
    }else if ([self hasGuessed]) {
        self.desc = [NSString stringWithFormat:NSLS(@"kDrawDesc"), self.wordText];      
    }else{
        self.desc = [NSString stringWithFormat:NSLS(@"kDrawDescNoWord"), self.wordText];      
    }
}

- (BOOL)isMyOpus
{
    UserManager *defaultManager  = [UserManager defaultManager];
    return [defaultManager isMe:self.author.userId];
}

- (BOOL) hasGuessed
{
    UserManager *defaultManager  = [UserManager defaultManager];
    return [defaultManager hasGuessOpus:self.feedId];    
}

- (FeedUser *)author
{
    return self.feedUser;
}
- (void)incTimesForType:(NSInteger)type;
{
    for (FeedTimes *feedTimes in self.timesSet) {
        if (feedTimes.type == type) {
            feedTimes.times ++;
        }
    }
}


- (NSInteger)timesForType:(NSInteger)type;
{
    for (FeedTimes *feedTimes in self.timesSet) {
        if (feedTimes.type == type) {
            return feedTimes.times;
        }
    }
    return 0;
}

- (void)incGuessTimes
{
    [self incTimesForType:FeedTimesTypeGuess];
}
- (void)incCorrectTimes
{
    [self incTimesForType:FeedTimesTypeCorrect];    
}

- (NSInteger)guessTimes
{
    return [self timesForType:FeedTimesTypeGuess];
}
- (NSInteger)matchTimes
{
    return [self timesForType:FeedTimesTypeMatch];    
}
- (NSInteger)correctTimes
{
    return [self timesForType:FeedTimesTypeCorrect];    
}
- (NSInteger)saveTimes
{
    return [self timesForType:FeedTimesTypeSave];
}
- (NSInteger)flowerTimes
{
    return [self timesForType:FeedTimesTypeFlower];
}
- (NSInteger)tomatoTimes
{
    return [self timesForType:FeedTimesTypeTomato];
}

- (ActionType)actionType
{
    BOOL isMyOpus = [self isMyOpus];
    UserManager *userManager = [UserManager defaultManager];
    if (isMyOpus) {
        return ActionTypeHidden;
    }
    
    if ([self isDrawType]) {
        if ([userManager hasGuessOpus:self.feedId]) {
            return ActionTypeChallenge;
        }else{
            return ActionTypeGuess;
        }
    }
    return ActionTypeHidden;
}
- (void)dealloc
{
    PPRelease(_drawImage);    
    PPRelease(_drawData);
    PPRelease(_wordText);    
    PPRelease(_drawImageUrl);
    PPRelease(_timesSet);    
    [super dealloc];
}


@end
