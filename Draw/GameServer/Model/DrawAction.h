//
//  DrawAction.h
//  Draw
//
//  Created by  on 12-3-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Paint;
@class PBDrawAction;
@class DrawColor;

typedef enum {
    
    DRAW_ACTION_TYPE_DRAW,
    DRAW_ACTION_TYPE_CLEAN
} DRAW_ACTION_TYPE;

@interface DrawAction : NSObject <NSCoding>{
    Paint *_paint;
}

@property (nonatomic, assign) DRAW_ACTION_TYPE type;
@property (nonatomic, retain) Paint *paint;
- (NSInteger)pointCount;
- (id)initWithPBDrawAction:(PBDrawAction *)action;
- (id)initWithType:(DRAW_ACTION_TYPE)aType paint:(Paint*)aPaint;

+ (DrawAction *)actionWithType:(DRAW_ACTION_TYPE)aType paint:(Paint*)aPaint;
+ (DrawAction *)changeBackgroundActionWithColor:(DrawColor *)color;

+ (BOOL)isDrawActionListBlank:(NSArray *)actionList;
+ (NSMutableArray *)getTheLastActionListWithoutClean:(NSArray *)actionList;
+ (DrawAction *)scaleAction:(DrawAction *)action 
                      xScale:(CGFloat)xScale 
                     yScale:(CGFloat)yScale;

+ (NSMutableArray *)scaleActionList:(NSArray *)list 
                       xScale:(CGFloat)xScale 
                      yScale:(CGFloat)yScale;

- (NSArray *)intPointListWithXScale:(CGFloat)xScale 
                             yScale:(CGFloat)yScale;


+ (NSInteger)pointCountForActions:(NSArray *)actionList;
+ (double)calculateSpeed:(NSArray *)actionList;
+ (double)calculateSpeed:(NSArray *)actionList defaultSpeed:(double)defaultSpeed maxSecond:(NSInteger)second;


@end
