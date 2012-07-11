//
//  ShowDrawController.h
//  Draw
//
//  Created by  on 12-3-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawGameService.h"
#import "UserManager.h"
#import "CommonDialog.h"
#import "SuperGameViewController.h"
#import "LevelService.h"


@class Word;
@class ShowDrawView;
@class ShareImageManager;
@class ToolView;
@class ItemShopController;
@interface OnlineGuessDrawController : SuperGameViewController<CommonDialogDelegate,UIScrollViewDelegate,LevelServiceDelegate>
{
    ShowDrawView *showView;
    NSString *_candidateString;
    ItemShopController *_shopController;
    ToolView *toolView;
    BOOL _guessCorrect;
    UIButton *moveButton;
    UIButton *lastScaleTarget;
    
    NSInteger numberPerPage;
    NSInteger pageCount;
}
@property (retain, nonatomic) NSString *candidateString;
@property (retain, nonatomic) ShowDrawView *showView;

@property (retain, nonatomic) IBOutlet UIImageView *drawBackground;

- (IBAction)clickRunAway:(id)sender;
- (void)bomb:(id)sender;
- (void)commitAnswer:(NSString *)answer;

- (void)setButton:(UIButton *)button title:(NSString *)title enabled:(BOOL)enabled;
- (NSString *)realValueForButton:(UIButton *)button;
- (void)initShowView;


- (void)initTargetViews;
- (void)updateCandidateViews:(Word *)word lang:(LanguageType)lang;
- (void)updateTargetViews:(Word *)word;
- (void)initWithCachData;



@end


