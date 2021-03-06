//
//  ReplayController.m
//  Draw
//
//  Created by  on 12-4-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ReplayController.h"
#import "MyPaint.h"
#import "ShowDrawView.h"
#import "UINavigationController+UINavigationControllerAdditions.h"
#import "LocaleUtils.h"
#import "ShareImageManager.h"
#import "GifManager.h"
#import "StringUtil.h"
#import "GifView.h"
#import "DeviceDetection.h"
#import <QuartzCore/QuartzCore.h>
#import "DrawAction.h"
#import "UIImageExt.h"

#define REPLAY_TAG 1234
#define COMPRESS_SCALE 0.6
#define POINT_COUNT_PER_FRAME 30
#define IPAD_SHOW_DRAW_VIEW_FRAME CGRectMake(0, 0, 280*2.4, 295*2.13)
#define IPHONE_SHOW_DRAW_VIEW_FRAME CGRectMake(0, 0, 280, 295)
#define SHOW_DRAW_VIEW_FRAME ([DeviceDetection isIPAD] ? IPAD_SHOW_DRAW_VIEW_FRAME : IPHONE_SHOW_DRAW_VIEW_FRAME)

@implementation ReplayController

@synthesize paint = _paint;
@synthesize titleLabel = _titleLabel;
@synthesize shareButton = _shareButton;
@synthesize backButton = _backButton;
@synthesize showHolderView = _showHolderView;
@synthesize wordLabel = _wordLabel;
@synthesize replayForCreateGif = _replayForCreateGif;
@synthesize shareAction = _shareAction;
@synthesize tempGIFFilePath = _tempGIFFilePath;
@synthesize gifImages = _gifImages;

- (id)initWithPaint:(MyPaint*)paint
{
    self = [super init];
    self.paint = paint;
    _gifImages = [[NSMutableArray alloc] init];
    return self;
}

- (IBAction)clickShareButton:(id)sender {
    
    [self.view endEditing:YES];
    
    NSString* path = nil;
    if (_replayForCreateGif)
        path = _tempGIFFilePath;
    else
        path = _paint.image;
    
    self.shareAction = [[[ShareAction alloc] initWithDrawImageFile:path
                                                             isGIF:_replayForCreateGif
                                                         drawWord:_paint.drawWord
                                                             drawUserId:_paint.drawUserId] autorelease];
    [_shareAction displayWithViewController:self];
}

- (IBAction)clickBackButton:(id)sender {
    [self.navigationController popViewControllerAnimatedWithTransition:UIViewAnimationTransitionCurlUp];
}

- (void)dealloc
{
    [_gifImages release];
    [_tempGIFFilePath release];
    [_paint release];
    [_titleLabel release];
    [_shareButton release];
    [_backButton release];
    [_showHolderView release];
    [_wordLabel release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    MyPaint* currentPaint = self.paint;
    NSData* currentData = [NSKeyedUnarchiver unarchiveObjectWithData:currentPaint.data ];
    NSArray* drawActionList = (NSArray*)currentData;
    
    CGFloat xScale = self.showHolderView.frame.size.width/DRAW_VIEW_FRAME.size.width;
    CGFloat yScale = self.showHolderView.frame.size.height/DRAW_VIEW_FRAME.size.height;
    
    ShowDrawView* replayView = [[ShowDrawView alloc]initWithFrame:
                                self.showHolderView.frame];
    if (self.replayForCreateGif) {
        [replayView setShowPenHidden:YES];
    }
    
    NSMutableArray *actionList = [DrawAction scaleActionList:drawActionList 
                                                      xScale:xScale 
                                                      yScale:yScale];
    [replayView setDrawActionList:actionList];
    replayView.backgroundColor = [UIColor whiteColor];
    replayView.tag = REPLAY_TAG;
    if (_replayForCreateGif){
        replayView.delegate = self;
        replayView.playSpeed = 0.01;
        [self.shareButton setHidden:YES];
        [self.backButton setHidden:YES];
    }

    [self.view addSubview:replayView];
    [replayView release];       

    [replayView play];
    
    
    self.titleLabel.text = NSLS(@"kReplayTitle");
    [self.shareButton setTitle:NSLS(@"kReplayShare") forState:UIControlStateNormal];
    [self.shareButton setBackgroundImage:[[ShareImageManager defaultManager] orangeImage] 
                                forState:UIControlStateNormal];

    if (_paint.drawWord == nil){
        self.wordLabel.text = @"";
    }
    else{
        self.wordLabel.text = [_paint drawWord];
    }
    
    if (_replayForCreateGif){
        [self showActivityWithText:NSLS(@"kCreating_gif")];
    }

}



- (void)viewDidUnload
{   
    [self setTitleLabel:nil];
    [self setShareButton:nil];
    [self setBackButton:nil];
    [self setShowHolderView:nil];
    [self setWordLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



- (void)didPlayDrawView:(ShowDrawView *)showDrawView
{
    UIImage *image = [showDrawView createImage];
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, NULL);
    [self hideActivity];
    [self.backButton setHidden:NO];
    [self.shareButton setHidden:NO];
    // create gif files here
    if (_gifImages == nil || [_gifImages count] == 0){
        [self popupMessage:NSLS(@"kFailCreateGIF") title:nil];
    }
    else{
        self.tempGIFFilePath = [NSString stringWithFormat:@"%@/%@.gif", NSTemporaryDirectory(), [NSString GetUUID]];
        [GifManager createGifToPath:self.tempGIFFilePath byImages:_gifImages];
        if ([[NSFileManager defaultManager] fileExistsAtPath:self.tempGIFFilePath] == NO){
            [self popupMessage:NSLS(@"kFailCreateGIF") title:nil];
        }
        else{
            [self clickShareButton:nil];
        }
    }
}

- (void)createImageAndSave:(ShowDrawView *)showView
{
    UIImage *image = [showView createImage];
    if ([DeviceDetection isIPAD]) {
        image = [image imageByScalingAndCroppingForSize:CGSizeMake(image.size.width/2, image.size.height/2)];
    }
    [_gifImages addObject:image];
    
}

- (void)didPlayDrawView:(ShowDrawView *)showDrawView AtActionIndex:(NSInteger)actionIndex pointIndex:(NSInteger)pointIndex
{
    NSInteger actionCount = [showDrawView.drawActionList count];
    
    if (showDrawView.tag == REPLAY_TAG) {
        if (actionIndex < actionCount && actionIndex >= 0) {
            DrawAction *action = [showDrawView.drawActionList objectAtIndex:actionIndex];
            NSInteger pointCount = [action pointCount];
            if (pointCount < 1) {
                return;
            }
            
            if (pointCount < POINT_COUNT_PER_FRAME) {
                if (pointIndex == pointCount - 1) {
                    [self createImageAndSave:showDrawView];
                    NSLog(@"action Index: %d; point index: %d",actionIndex,pointIndex);
                }
                return;
            }
            
            if (pointIndex == pointCount - 1) 
            {
                NSLog(@"action Index: %d; point index: %d",actionIndex,pointIndex);
                [self createImageAndSave:showDrawView];
            }else if((pointIndex % POINT_COUNT_PER_FRAME) == (POINT_COUNT_PER_FRAME - 1 ) && (pointIndex + POINT_COUNT_PER_FRAME / 2) < pointCount)
            {
                NSLog(@"action Index: %d; point index: %d",actionIndex,pointIndex);
                [self createImageAndSave:showDrawView];
            }
        }
        
    }
}


@end
