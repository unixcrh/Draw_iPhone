//
//  MessageView.m
//  Draw
//
//  Created by 小涛 王 on 12-8-4.
//  Copyright (c) 2012年 甘橙软件. All rights reserved.
//

#import "MessageView.h"
#import "CMPopTipView.h"

#define DEFAULT_BG_COLOR [UIColor colorWithRed:255./255. green:234./255. blue:80./255. alpha:0.4]


@interface MessageView ()

@property (retain, nonatomic) CMPopTipView *popTipView;

@end

@implementation MessageView

@synthesize popTipView = _popTipView;

- (void)dealloc
{
    [_popTipView release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
            message:(NSString *)message
           fontName:(NSString *)fontName 
          pointSize:(CGFloat)pointSize 
{
    CGSize withSize = CGSizeMake(200, MAXFLOAT);
    CGSize size = [message sizeWithFont:[UIFont systemFontOfSize:pointSize] constrainedToSize:withSize lineBreakMode:UILineBreakModeTailTruncation];
    CGRect rect = CGRectMake(frame.origin.x, frame.origin.y, size.width, size.height);
    if (self = [self initWithFrame:rect fontName:fontName pointSize:pointSize]) {
        self.text = message;
        self.numberOfLines = 0;
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)popupAtView:(UIView *)atView
             inView:(UIView *)inView
           duration:(int)duration
    backgroundColor:(UIColor *)backgroundColor
           animated:(BOOL)animated;
{
    self.popTipView = [[[CMPopTipView alloc] initWithCustomView:self] autorelease];
    _popTipView.backgroundColor = backgroundColor;
    _popTipView.disableTapToDismiss = YES;
    
    [_popTipView presentPointingAtView:atView inView:inView animated:animated];
    
    if (duration) {
        [_popTipView performSelector:@selector(dismissAnimated:) withObject:[NSNumber numberWithBool:animated] afterDelay:duration];
    }
}

- (void)popupAtView:(UIView *)atView
             inView:(UIView *)inView
    backgroundColor:(UIColor *)backgroundColor
           animated:(BOOL)animated
{
    [self popupAtView:atView 
               inView:inView 
             duration:0 
      backgroundColor:backgroundColor 
             animated:animated];
}


- (void)dismissAnimated:(BOOL)animated
{
    [_popTipView dismissAnimated:animated];
}

@end
