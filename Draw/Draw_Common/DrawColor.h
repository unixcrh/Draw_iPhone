//
//  DrawColor.h
//  Draw
//
//  Created by  on 12-3-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrawColor : NSObject <NSCoding>
{
    CGFloat _red;
    CGFloat _green;
    CGFloat _blue;
    CGFloat _alpha;
    UIColor *_color;
}

@property(nonatomic, readonly)CGFloat red;
@property(nonatomic, readonly)CGFloat green;
@property(nonatomic, readonly)CGFloat blue;
@property(nonatomic, readonly)CGFloat alpha;
//@property(nonatomic, retain)UIColor color;

- (id)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

- (BOOL)isEqual:(id)object;
- (UIColor *)color;
- (CGColorRef)CGColor;
- (NSString *)toString;

+ (DrawColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+ (DrawColor *)blackColor;      // 0.0 white 
+ (DrawColor *)whiteColor;      // 1.0 white 
+ (DrawColor *)redColor;        // 1.0, 0.0, 0.0 RGB 
+ (DrawColor *)greenColor;      // 0.0, 1.0, 0.0 RGB 
+ (DrawColor *)blueColor;       // 0.0, 0.0, 1.0 RGB 
+ (DrawColor *)cyanColor;       // 0.0, 1.0, 1.0 RGB 
+ (DrawColor *)yellowColor;     // 1.0, 1.0, 0.0 RGB 
+ (DrawColor *)magentaColor;    // 1.0, 0.0, 1.0 RGB 

+ (DrawColor *)pinkColor;       // 1.0, 0.0, 1.0 RGB 
+ (DrawColor *)skyColor;       // 1.0, 0.0, 1.0 RGB 

+ (DrawColor *)orangeColor;     // 1.0, 0.5, 0.0 RGB 
+ (DrawColor *)purpleColor;     // 0.5, 0.0, 0.5 RGB 
+ (DrawColor *)brownColor;      // 0.6, 0.4, 0.2 RGB 
+ (DrawColor *)clearColor;      // 0.0 white, 0.0 alpha 


//- (id)initWithRed:(CGFloat)red 

+ (NSArray *)getRecentColorList;
+ (void)setRecentColorList:(NSArray *)list;

@end
