//
//  ShareEditController.h
//  Draw
//
//  Created by Orange on 12-3-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareEditController : UIViewController
@property (retain, nonatomic) UIImage* myImage;
@property (retain, nonatomic) IBOutlet UIScrollView *patternsGallery;
@property (retain, nonatomic) NSMutableArray* patternsArray;

- (id)initWithImage:(UIImage*)anImage;
@end
