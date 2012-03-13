//
//  DrawUtils.m
//  Draw
//
//  Created by  on 12-3-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DrawUtils.h"


@implementation DrawUtils

+ (CGPoint)illegalPoint
{
    return ILLEGAL_POINT;
}

+ (BOOL)isIllegalPoint:(CGPoint)point
{
    if (point.x == ILLEGAL_POINT.x && point.y == ILLEGAL_POINT.y) {
        return YES;
    }
    return NO;
}

+ (CGRect)constructWithPoint1:(CGPoint)point1 point2:(CGPoint)point2
{
    CGFloat x = MIN(point1.x, point2.x);
    CGFloat y = MIN(point1.y, point2.y);
    CGFloat width = ABS(point1.x - point2.x);
    CGFloat height = ABS(point1.y - point2.y);
    return CGRectMake(x , y , width, height);
}

+ (CGRect)constructWithPoint1:(CGPoint)point1 point2:(CGPoint)point2 edgeWidth:(CGFloat)edgeWidth
{
    CGFloat x = MIN(point1.x, point2.x);
    CGFloat y = MIN(point1.y, point2.y);
    CGFloat width = ABS(point1.x - point2.x);
    CGFloat height = ABS(point1.y - point2.y);
    return CGRectMake(x - edgeWidth / 2.0, y - edgeWidth / 2.0, width + edgeWidth, height + edgeWidth);
}

+ (CGPoint)zipPoint:(CGPoint)point size:(NSInteger)size
{
    
    if (size <= 1) {
        return point;
    }
    NSInteger x = point.x;
    NSInteger y = point.y;
    x -= (x % (size / 2));
    y -= (y % (size / 2));
    return CGPointMake(x, y);
}

+ (CGFloat)distanceBetweenPoint:(CGPoint)point1 point2:(CGPoint)point2
{
    CGFloat left = powf(point1.x - point2.x, 2);
    CGFloat right = powf(point1.y - point2.y, 2);
    return sqrtf(left + right);
}

@end
