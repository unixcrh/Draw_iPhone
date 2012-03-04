//
//  DrawViewController.h
//  Draw
//
//  Created by gamy on 12-3-4.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DrawView;
@interface DrawViewController : UIViewController {
    DrawView *drawView;
}
- (IBAction)pickColor:(id)sender;
- (IBAction)clickPlay:(id)sender;
- (IBAction)clickRedraw:(id)sender;
- (IBAction)changeSlider:(id)sender;
@property (retain, nonatomic) IBOutlet UISlider *widthSlider;

@end
