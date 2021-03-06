//
//  DrawView.m
//  Draw
//
//  Created by  on 12-3-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ShowDrawView.h"
#import "Paint.h"
#import "DrawColor.h"
#import "DrawUtils.h"
#import "DrawAction.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageExt.h"
#import "UIImageUtil.h"
#import "PenView.h"
#import "PPDebug.h"

#define DEFAULT_PLAY_SPEED (1/30.0)
#define DEFAULT_SIMPLING_DISTANCE (5.0)
#define DEFAULT_LINE_WIDTH (4.0 * 1.414)

@implementation ShowDrawView
@synthesize playSpeed= _playSpeed;
@synthesize delegate = _delegate;
@synthesize drawActionList = _drawActionList;
@synthesize status = _status;
@synthesize playTimer = _playTimer;
#pragma mark Action Funtion


- (DrawAction *)playingAction
{
    if (playingActionIndex >= 0 && playingActionIndex < [self.drawActionList count]) {
        return [self.drawActionList objectAtIndex:playingActionIndex];
    }
    return nil;
}

- (void)cleanAllActions
{
    [self.drawActionList removeAllObjects];
    [self setStatus:Stop];
    
    // Add by Benson
    if ([_playTimer isValid]){
        [_playTimer invalidate];
    }
    
    self.playTimer = nil;
    playingActionIndex = 0;
    playingPointIndex = 0;
    startPlayIndex = 0;
    _showDraw = NO;
    [self setNeedsDisplay];    
}


- (void)playFromDrawActionIndex:(NSInteger)index
{
    playingActionIndex = index;
    playingPointIndex = 0;
    self.status = Playing;
    [self setNeedsDisplay];
}

- (void)play
{
    [self playFromDrawActionIndex:0];
}

- (void)show
{
    _showDraw = YES;
    [self setNeedsDisplay];
}
- (void)addDrawAction:(DrawAction *)action play:(BOOL)play
{
    if (play) {
        [self.drawActionList addObject:action];
        if (self.status == Playing) {
            return;
        }else{
            [self playFromDrawActionIndex:[self.drawActionList count] -1];
        }
    }else{
        [self.drawActionList addObject:action];
        [self setNeedsDisplay];
    }
}


#pragma mark function called by player

- (void)cleanFrame:(NSTimer *)theTimer
{
    PPDebug(@"<Debug> Show Draw View Clean Frame Timer");
    
    self.status = Stop;
    pen.hidden = YES;
    [self setNeedsDisplay];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didPlayDrawView:)]) {
        [self.delegate didPlayDrawView:self];
    }
}

- (void)nextFrame:(NSTimer *)theTimer;
{       
    PPDebug(@"<Debug> Show Draw View For Next Frame");
    DrawAction *currentAction = [self playingAction];
    if (!_showPenHidden) {
        if (currentAction.type == DRAW_ACTION_TYPE_CLEAN) {
            if (pen.hidden == NO) {
                pen.hidden = YES;                
            }
        }else{
            if (pen.hidden) {
                pen.hidden = NO;                
            }
            if (playingPointIndex == 0 && pen.penType != currentAction.paint.penType) {                
                [pen setPenType:currentAction.paint.penType];
                if ([pen isRightDownRotate]) {
                    [pen.layer setTransform:CATransform3DMakeRotation(-0.8, 0, 0, 1)];        
                }else{
                    [pen.layer setTransform:CATransform3DMakeRotation(0.8, 0, 0, 1)];        
                }
            }
            CGPoint point = [currentAction.paint pointAtIndex:playingPointIndex];
            if (![DrawUtils isIllegalPoint:point]) {
                if ([pen isRightDownRotate]) {
                    pen.center = CGPointMake(point.x + pen.frame.size.width / 3.1, point.y + pen.frame.size.height / 3.3);                    
                }else{
                    pen.center = CGPointMake(point.x + pen.frame.size.width / 2.5, point.y - pen.frame.size.height / 4.3);                                        
                }
            }
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didPlayDrawView:AtActionIndex:pointIndex:)]) {
        [self.delegate didPlayDrawView:self AtActionIndex:playingActionIndex 
                            pointIndex:playingPointIndex];
    }
    
    playingPointIndex ++;
    if (playingPointIndex < [currentAction pointCount]) {
        //can play this action
    }else{
        //play next action
        playingPointIndex = 0;
        playingActionIndex ++;
        if ([self.drawActionList count] > playingActionIndex) {
        }else{
            //illegal
            _status = Stop;
            if (self.delegate && [self.delegate respondsToSelector:@selector(didPlayDrawView:)]) {
                [self.delegate didPlayDrawView:self];
            }
            return;
        }
    }
    [self setNeedsDisplay];
    
    
    
}

- (void)performTapGuesture:(UITapGestureRecognizer *)tap
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didClickShowDrawView:)]){
        [self.delegate didClickShowDrawView:self];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (gestureRecognizer.view == self) {
        return YES;
    }
    return NO;
}


#pragma mark Constructor & Destructor

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.status = Stop;
        self.playSpeed = DEFAULT_PLAY_SPEED;
        _drawActionList = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor whiteColor];      
        //add tap guesture
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(performTapGuesture:)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        [tap release];
        
        //set pen
        pen = [[PenView alloc] initWithPenType:Pencil];
        [self setShowPenHidden:NO];
        pen.hidden = YES;
        pen.userInteractionEnabled = NO;
        pen.layer.transform = CATransform3DMakeRotation(-0.8, 0, 0, 1);
        [self addSubview:pen];
    }
    return self;
}

- (void)dealloc
{
    PPDebug(@"%@ dealloc", [self description]);
    
    // Add by Benson
    if ([_playTimer isValid]){
        PPDebug(@"<Debug> ShowDRawView Clear Play Timer");
        [_playTimer invalidate];
    }    

    PPRelease(_playTimer);
    PPRelease(_drawActionList);
    PPRelease(pen);
    [super dealloc];
}

- (NSInteger)lastCleanActionIndex
{
    int i = 0, ans = -1;
    for (DrawAction *action in self.drawActionList) {
        if (action.type == DRAW_ACTION_TYPE_CLEAN) {
            ans = i;
        }
        ++ i;
    }
    return  ans;
}




#pragma mark drawRect

- (void)drawShowRect:(CGRect)rect
{
    if ([self.drawActionList count ] == 0) {
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext(); 
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    int index = -1;
    int i = 0;
    for (DrawAction *drawAction in self.drawActionList) {
        if (drawAction.type == DRAW_ACTION_TYPE_CLEAN) {
            index = i;
        }
        ++ i;
    }
    index ++;
    
    for (int j = index; j < [self.drawActionList count]; ++ j) {
        DrawAction *drawAction = [self.drawActionList objectAtIndex:j];
        Paint *paint = drawAction.paint;
        CGContextSetStrokeColorWithColor(context, paint.color.CGColor);
        CGContextSetLineWidth(context, paint.width);
        for (i = 0; i < [paint pointCount]; ++ i) {
            CGPoint point = [paint pointAtIndex:i];
            if ([paint pointCount] == 1) {
                //if tap gesture, draw a circle
                CGContextSetFillColorWithColor(context, paint.color.CGColor);
                CGFloat r = paint.width / 2;
                CGFloat x = point.x - r;
                CGFloat y = point.y - r;
                CGFloat width = paint.width;
                CGRect rect = CGRectMake(x, y, width, width);
                CGContextFillEllipseInRect(context, rect);
            }else{
                //if is pan gesture, draw a line.
                if (i == 0) {
                    CGContextMoveToPoint(context, point.x, point.y);   
                }else{
                    CGContextAddLineToPoint(context, point.x, point.y);
                }
            }
        }
        CGContextStrokePath(context); 
    }
    
    _showDraw = NO;
    
}

- (void)drawRect:(CGRect)rect
{
    
    if (_showDraw) {
        [self drawShowRect:rect];
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext(); 
    CGContextSetLineCap(context, kCGLineCapRound);

    for (int j = startPlayIndex; j < self.drawActionList.count; ++ j) {
        
        DrawAction *drawAction = [self.drawActionList objectAtIndex:j];
        if (drawAction.type == DRAW_ACTION_TYPE_DRAW) { //if is draw action 
            Paint *paint = drawAction.paint;
            CGContextSetStrokeColorWithColor(context, paint.color.CGColor);
            CGContextSetLineWidth(context, paint.width);
            for (int i = 0; i < [paint pointCount]; ++ i) {
                CGPoint point = [paint pointAtIndex:i];
                if ([paint pointCount] == 1) {
                    //if tap gesture, draw a circle
                    CGContextSetFillColorWithColor(context, paint.color.CGColor);
                    CGFloat r = paint.width / 2;
                    CGFloat x = point.x - r;
                    CGFloat y = point.y - r;
                    CGFloat width = paint.width;
                    CGRect rect = CGRectMake(x, y, width, width);
                    CGContextFillEllipseInRect(context, rect);
                }else{
                    //if is pan gesture, draw a line.
                    if (i == 0) {
                        CGContextMoveToPoint(context, point.x, point.y);   
                    }else{
                        CGContextAddLineToPoint(context, point.x, point.y);
                        CGContextSetLineJoin(context, kCGLineJoinRound);
                    }
                }
                //if is playing then play the next frame
                if (self.status == Playing && j == playingActionIndex && i == playingPointIndex) {
                    CGContextStrokePath(context);            
                    self.playTimer = [NSTimer scheduledTimerWithTimeInterval:_playSpeed target:self selector:@selector(nextFrame:) userInfo:nil repeats:NO];
                    return;
                }
            }
        }else{ // if is clean action 
            //if is playing then play the next frame
            //is the last action
            startPlayIndex = j + 1;
            if (playingActionIndex == [self.drawActionList count] - 1) {
                self.playTimer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(cleanFrame:) userInfo:nil repeats:NO];
            }else{
                if (self.status == Playing && j == playingActionIndex) {
                    CGContextStrokePath(context);            
                    self.playTimer = [NSTimer scheduledTimerWithTimeInterval:_playSpeed target:self selector:@selector(nextFrame:) userInfo:nil repeats:NO];
                    return;
                }
            }
        }
        CGContextStrokePath(context); 
    }
}


- (UIImage*)createImage
{
    pen.hidden = YES;
    CGRect rect = self.frame;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (UIImage *)createImageWithScale:(CGFloat)scale
{
    UIImage *image = [self createImage];
    UIImage* frame = [[self createImage] imageByScalingAndCroppingForSize:CGSizeMake(image.size.width * scale, image.size.height * scale)];
    return frame;
}

- (BOOL)isViewBlank
{
    return [DrawAction isDrawActionListBlank:self.drawActionList];
}

- (void)setShowPenHidden:(BOOL)showPenHidden
{
    _showPenHidden = showPenHidden;
    pen.hidden = showPenHidden;
}
- (BOOL)isShowPenHidden
{
    return _showPenHidden;
}


@end
