//
//  DiceGameService.m
//  Draw
//
//  Created by  on 12-7-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DiceGameService.h"
#import "GameMessage.pb.h"
#import "PPDebug.h"
#import "DiceNetworkClient.h"
#import "DiceGameSession.h"
#import "DiceNotification.h"


#define DICE_GAME_ID    @"LiarDice"

@implementation DiceGameService

static DiceGameService* _defaultService;

+ (DiceGameService*)defaultService
{
    if (_defaultService == nil){
        _defaultService = [[DiceGameService alloc] init];
    }
    
    return _defaultService;
}

- (id)init
{
    self = [super init];
    
    _gameId = DICE_GAME_ID;
    _networkClient = [[DiceNetworkClient alloc] init];
    [_networkClient setDelegate:self]; 
    
    return self;
}

- (void)handleNextPlayerStartNotification:(GameMessage*)message
{
    // update game status and fire notification
    [self.diceSession setCurrentPlayUserId:message.currentPlayUserId];
    [self postNotification:NOTIFICATION_NEXT_PLAYER_START message:message];
}

- (void)handleRollDiceBegin:(GameMessage*)message
{
    NSMutableArray* newUserList = [NSMutableArray array];
    
    for (PBGameUser* user in [[self session] userList]){
        PBGameUser* newUser = [[[PBGameUser builderWithPrototype:user] setIsPlaying:YES] build];
        [newUserList addObject:newUser];
    }
    
    [self.session.userList removeAllObjects];
    [self.session.userList addObjectsFromArray:newUserList];
    
    [self postNotification:NOTIFICATION_ROLL_DICE_BEGIN message:message];
    
}

- (void)handleRollDiceEnd:(GameMessage *)message
{
    NSMutableDictionary *diceDic= [NSMutableDictionary dictionary];
    
    
    for(PBUserDice *userDice in [[message rollDiceEndNotificationRequest] userDiceList])
    {
        [diceDic setObject:userDice.dicesList forKey:userDice.userId];
    }
    
    [self diceSession].userDiceList = diceDic;
    
    [[NSNotificationCenter defaultCenter] 
     postNotificationName:NOTIFICATION_ROLL_DICE_END
     object:self 
     userInfo:[CommonGameNetworkService messageToUserInfo:message]];     
}

- (void)handleCallDiceRequest:(GameMessage *)message
{
    self.diceSession.lastCallDiceUserId = message.userId;
    self.diceSession.lastCallDice = message.callDiceRequest.dice;
    self.diceSession.lastCallDiceCount = message.callDiceRequest.num;
    
    [[NSNotificationCenter defaultCenter] 
     postNotificationName:NOTIFICATION_CALL_DICE_REQUEST
     object:self 
     userInfo:[CommonGameNetworkService messageToUserInfo:message]];      
}

- (void)handleOpenDiceRequest:(GameMessage*)message
{
    self.diceSession.openDiceUserId = message.userId;
    
    [[NSNotificationCenter defaultCenter] 
     postNotificationName:NOTIFICATION_OPEN_DICE_REQUEST
     object:self 
     userInfo:[CommonGameNetworkService messageToUserInfo:message]]; 
}

- (void)handleOpenDiceResponse:(GameMessage*)message
{
    if (message.resultCode == 0) {
        [[NSNotificationCenter defaultCenter] 
         postNotificationName:NOTIFICATION_OPEN_DICE_RESPONSE
         object:self 
         userInfo:[CommonGameNetworkService messageToUserInfo:message]]; 
    }    
}

- (void)handleCustomMessage:(GameMessage*)message
{
    switch ([message command]){
        case GameCommandTypeRollDiceBeginNotificationRequest:
            [self handleRollDiceBegin:message];
            break;

        case GameCommandTypeRollDiceEndNotificationRequest:
            // TODO
            [self handleRollDiceEnd:message];
            break;

        case GameCommandTypeNextPlayerStartNotificationRequest:
            [self handleNextPlayerStartNotification:message];
            break;
            
        case GameCommandTypeCallDiceRequest:
            [self handleCallDiceRequest:message];
            break;
        case GameCommandTypeOpenDiceRequest: 
            [self handleOpenDiceRequest];
            break;
        case GameCommandTypeOpenDiceResponse: 
            [self handleOpenDiceResponse];
            break;
        default:
            PPDebug(@"<handleCustomMessage> unknown command=%d", [message command]);
            break;
    }
}

- (CommonGameSession*)createSession
{    
    return [[[DiceGameSession alloc] init] autorelease];
}

- (DiceGameSession*)diceSession
{
    return (DiceGameSession*)(self.session);
}

- (NSArray *)myDiceList
{
    return [[[self diceSession] userDiceList] objectForKey:self.user.userId];
}

- (void)callDice:(int)dice count:(int)count
{
    [(DiceNetworkClient *)_networkClient sendCallDiceRequest:self.user.userId
                                                   sessionId:self.session.sessionId
                                                        dice:dice
                                                       count:count];
}

- (NSString *)lastCallUserId
{
    return [[self diceSession] lastCallDiceUserId];
}

- (int)lastCallDice
{
    return [[self diceSession] lastCallDice];
}

- (int)lastCallDiceCount
{
    return [[self diceSession] lastCallDiceCount];
}

- (void)openDice
{
    [_networkClient sendSimpleMessage:GameCommandTypeOpenDiceRequest
                               userId:self.diceSession.userId
                            sessionId:self.diceSession.sessionId];
}

@end
