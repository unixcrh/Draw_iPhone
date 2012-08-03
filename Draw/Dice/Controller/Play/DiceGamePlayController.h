//
//  DiceGamePlayController.h
//  Draw
//
//  Created by 小涛 王 on 12-7-27.
//  Copyright (c) 2012年 甘橙软件. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPViewController.h"
#import "ToolSheetView.h"
#import "FontLabel.h"
#import "FontButton.h"
#import "DiceSelectedView.h"

@interface DiceGamePlayController : PPViewController <ToolSheetViewDelegate, DiceSelectedViewDelegate> {
    DiceSelectedView* _diceSelectedView;
}

@property (retain, nonatomic) FontLabel *myLevelLabel;
@property (retain, nonatomic) FontLabel *myCoinsLabel;
//@property (retain, nonatomic) UILabel *myLevelLabel;
//@property (retain, nonatomic) UILabel *myCoinsLabel;
@property (retain, nonatomic) IBOutlet UIButton *openDiceButton;

@property (retain, nonatomic) FontButton *fontButton;
@property (retain, nonatomic) IBOutlet UIView *diceCountSelectedHolderView;

@end
