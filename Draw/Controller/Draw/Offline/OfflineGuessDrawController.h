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
#import "PPViewController.h"

@class Word;
@class ShowDrawView;
@class ShareImageManager;
@class ToolView;
@class ItemShopController;
@interface OfflineGuessDrawController : PPViewController<CommonDialogDelegate,UIScrollViewDelegate>
{
    ShowDrawView *showView;
    NSString *_candidateString;
    ItemShopController *_shopController;
    ToolView *toolView;
    UIButton *moveButton;
    UIButton *lastScaleTarget;
    
    NSInteger numberPerPage;
    NSInteger pageCount;
    ShareImageManager *shareImageManager;

    Word *_word;
    LanguageType languageType;

}
@property (retain, nonatomic) NSString *candidateString;
@property (retain, nonatomic) ShowDrawView *showView;

@property (retain, nonatomic) IBOutlet UIImageView *drawBackground;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIPageControl *pageControl;
@property (retain, nonatomic) IBOutlet UIButton *leftPageButton;
@property (retain, nonatomic) IBOutlet UIButton *rightPageButton;
@property (retain, nonatomic) Word *word;
- (IBAction)clickRunAway:(id)sender;
- (void)bomb:(id)sender;
- (void)commitAnswer:(NSString *)answer;
- (IBAction)clickLeftPage:(id)sender;
- (IBAction)clickRightPage:(id)sender;

- (void)setButton:(UIButton *)button title:(NSString *)title enabled:(BOOL)enabled;
- (NSString *)realValueForButton:(UIButton *)button;
- (void)initShowView;
- (void)initBomb;

- (void)initTargetViews;
- (void)updateCandidateViews:(Word *)word lang:(LanguageType)lang;
- (void)updateTargetViews:(Word *)word;

- (void)scrollToPage:(NSInteger)pageIndex;

- (id)initWithWord:(Word *)word 
          language:(LanguageType)lang   
        actionList:(NSArray *)actions;

+ (void)startGuessWord:(Word *)word 
                  lang:(LanguageType)lang 
            actionList:(NSArray *)actions
                  from:(UIViewController *)fromController;
@end

