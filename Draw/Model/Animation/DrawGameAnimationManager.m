//
//  DrawGameAnimationManager.m
//  Draw
//
//  Created by Orange on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DrawGameAnimationManager.h"
#import "AnimationManager.h"
#import "DeviceDetection.h"
#import "CommonMessageCenter.h"
#import "LocaleUtils.h"

#define THROW_ITEM_TAG  20120713
#define RECIEVE_ITEM_TAG    120120713

#define THROWING_TIME   2
#define ROATE_RATE      10

#define REWARD_EXP 5
#define REWARD_COINS 3

#define RADIUS  ([DeviceDetection isIPAD]?240:120)

#define ANIM_KEY_RECEIVE_TOMATO  @"ReceiveTomato"
#define ANIM_KEY_RECEIVE_FLOWER  @"ReceiveFlower"
#define ANIM_KEY_THROW_TOMATO   @"ThrowTomato"
#define ANIM_KEY_SEND_FLOWER    @"SendFlower"

#define POP_MESSAGE_HORIZON_OFFSET  ([DeviceDetection isIPAD]?-300:-150)

#define ANIM_GROUP @"AnimationGroup"

@implementation DrawGameAnimationManager

+ (CAAnimationGroup*)createThrowItemAnimation:(UIImageView*)ItemImageView inViewController:(UIViewController*)viewController
{
    [ItemImageView setFrame:CGRectMake(0, 0, ItemImageView.frame.size.width*2, ItemImageView.frame.size.height*2)];
    CGPoint startPoint = CGPointMake(viewController.view.frame.size.width/2, viewController.view.frame.size.height);
    CGPoint endPoint = CGPointMake(viewController.view.center.x-RADIUS+(rand()%(2*RADIUS)), viewController.view.center.y-(rand()%RADIUS));
    [ItemImageView setCenter:endPoint];
    
    CAAnimation* rolling = [AnimationManager rotationAnimationWithRoundCount:ROATE_RATE*THROWING_TIME duration:THROWING_TIME];
    CAAnimation* throw = [AnimationManager translationAnimationFrom:startPoint to:endPoint duration:THROWING_TIME];
    throw.removedOnCompletion = NO;
    CAAnimation* zoom = [AnimationManager scaleAnimationWithScale:0.01 duration:THROWING_TIME delegate:viewController removeCompeleted:NO];
    
    CAAnimation* enlarge = [AnimationManager scaleAnimationWithFromScale:0.01 toScale:1 duration:1 delegate:viewController removeCompeleted:NO];
    enlarge.beginTime = THROWING_TIME;
    CAAnimation* miss = [AnimationManager missingAnimationWithDuration:1];
    miss.beginTime = THROWING_TIME;
    
    //method2:放入动画数组，统一处理！
    CAAnimationGroup* animGroup    = [CAAnimationGroup animation];
    
    //设置动画代理
    animGroup.delegate = viewController;
    
    animGroup.removedOnCompletion = NO;
    animGroup.duration             = THROWING_TIME+1;
    animGroup.timingFunction      = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];    
    animGroup.repeatCount         = 1;//FLT_MAX;  //"forever";
    animGroup.fillMode             = kCAFillModeForwards;
    animGroup.animations             = [NSArray arrayWithObjects:rolling, throw, zoom, enlarge, miss,nil];
    return animGroup;
    //[animGroup setValue:key forKey:DRAW_ANIM];
    //对视图自身的层添加组动画
    [ItemImageView.layer addAnimation:animGroup forKey:ANIM_GROUP];
}


+ (void)showThrowTomato:(UIImageView*)tomatoImageView 
       animInController:(UIViewController*)superController
{
    CAAnimationGroup* animationGroup = [DrawGameAnimationManager createThrowItemAnimation:tomatoImageView inViewController:superController];
    [animationGroup setValue:ANIM_KEY_THROW_TOMATO forKey:DRAW_ANIM];
    [tomatoImageView.layer addAnimation:animationGroup forKey:ANIM_GROUP];
}
+ (void)showThrowFlower:(UIImageView*)flowerImageView 
       animInController:(UIViewController*)superController
{
    CAAnimationGroup* animationGroup = [DrawGameAnimationManager createThrowItemAnimation:flowerImageView inViewController:superController];
    [animationGroup setValue:ANIM_KEY_SEND_FLOWER forKey:DRAW_ANIM];
    [flowerImageView.layer addAnimation:animationGroup forKey:ANIM_GROUP];
}

+ (void)showReceiveFlower:(UIImageView*)flowerImageView 
    animationInController:(UIViewController*)viewController 
{
    CGPoint point = CGPointMake(viewController.view.center.x-RADIUS+(rand()%(2*RADIUS)), viewController.view.center.y-RADIUS+(rand()%(2*RADIUS)));
    [flowerImageView setCenter:point];

    
    CAAnimation* rolling = [AnimationManager rotationAnimationWithRoundCount:ROATE_RATE*THROWING_TIME duration:THROWING_TIME];
    CAAnimation* disMiss = [AnimationManager missingAnimationWithDuration:THROWING_TIME];
    CAAnimation* zoom = [AnimationManager scaleAnimationWithFromScale:0.1 toScale:3 duration:THROWING_TIME delegate:viewController removeCompeleted:NO];
    [zoom setValue:ANIM_KEY_RECEIVE_FLOWER forKey:DRAW_ANIM];
    
    [flowerImageView.layer addAnimation:rolling forKey:@"rolling"];
    [flowerImageView.layer addAnimation:disMiss forKey:@"disMiss"];
    [flowerImageView.layer addAnimation:zoom forKey:@"zoom"];
}
+ (void)showReceiveTomato:(UIImageView*)tomatoImageView  
    animaitonInController:(UIViewController*)viewController 
{
    
    CGPoint point = CGPointMake(viewController.view.center.x-RADIUS+(rand()%(2*RADIUS)), viewController.view.center.y-RADIUS+(rand()%(2*RADIUS)));
    [tomatoImageView setCenter:point];
    
    CAAnimation* rolling = [AnimationManager rotationAnimationWithRoundCount:ROATE_RATE*THROWING_TIME duration:THROWING_TIME];
    CAAnimation* disMiss = [AnimationManager missingAnimationWithDuration:THROWING_TIME];
    CAAnimation* zoom = [AnimationManager scaleAnimationWithFromScale:0.1 toScale:3 duration:THROWING_TIME delegate:viewController removeCompeleted:NO];
    [zoom setValue:ANIM_KEY_RECEIVE_TOMATO forKey:DRAW_ANIM];
    
    [tomatoImageView.layer addAnimation:rolling forKey:@"rolling"];
    [tomatoImageView.layer addAnimation:disMiss forKey:@"disMiss"];
    [tomatoImageView.layer addAnimation:zoom forKey:@"zoom"];
}
+ (void)showBuyItem:(UIImageView*)itemImageView  
   animInController:(UIViewController*)viewController
{
    
}

+ (void)animation:(CAAnimation *)anim didStopWithFlag:(BOOL)flag
{
    NSString* key = [anim valueForKey:DRAW_ANIM];
    if ([key isEqualToString:ANIM_KEY_RECEIVE_FLOWER]) {
        [[CommonMessageCenter defaultCenter] postMessageWithText:[NSString stringWithFormat:NSLS(@"kReceiveFlowerMessage"),REWARD_EXP, REWARD_COINS] delayTime:2 isHappy:YES atHorizon:POP_MESSAGE_HORIZON_OFFSET];
        //        [self popupMessage:[NSString stringWithFormat:NSLS(@"kReceiveFlowerMessage"),REWARD_EXP, REWARD_COINS] title:nil];
    }
    if ([key isEqualToString:ANIM_KEY_RECEIVE_TOMATO]) {
        [[CommonMessageCenter defaultCenter] postMessageWithText:[NSString stringWithFormat:NSLS(@"kReceiveTomatoMessage"),REWARD_EXP, REWARD_COINS] delayTime:2 isHappy:NO atHorizon:POP_MESSAGE_HORIZON_OFFSET];
        //        [self popupMessage:[NSString stringWithFormat:NSLS(@"kReceiveTomatoMessage"),REWARD_EXP, REWARD_COINS] title:nil];
        
    }
    if ([key isEqualToString:ANIM_KEY_SEND_FLOWER]) {
        [[CommonMessageCenter defaultCenter] postMessageWithText:[NSString stringWithFormat:NSLS(@"kSendFlowerMessage"),REWARD_EXP, REWARD_COINS] delayTime:2 isHappy:YES atHorizon:POP_MESSAGE_HORIZON_OFFSET];
        //        [self popupMessage:[NSString stringWithFormat:NSLS(@"kSendFlowerMessage"),REWARD_EXP, REWARD_COINS] title:nil];
    }
    if ([key isEqualToString:ANIM_KEY_THROW_TOMATO]) {
        [[CommonMessageCenter defaultCenter] postMessageWithText:[NSString stringWithFormat:NSLS(@"kThrowTomatoMessage"),REWARD_EXP, REWARD_COINS] delayTime:2 isHappy:YES atHorizon:POP_MESSAGE_HORIZON_OFFSET];
        //        [self popupMessage:[NSString stringWithFormat:NSLS(@"kThrowTomatoMessage"),REWARD_EXP, REWARD_COINS] title:nil];
        
    }

}

@end
