//
//  VendingController.m
//  Draw
//
//  Created by Orange on 12-7-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "VendingController.h"
#import "ShareImageManager.h"
#import "Item.h"
#import "AccountManager.h"
#import "ItemType.h"
#import "StableView.h"
#import "ItemManager.h"
#import "AnimationManager.h"
#import "CoinShopController.h"
#import "DeviceDetection.h"
#import "CommonMessageCenter.h"

#define ITEM_COUNT_PER_LINE 3
#define LINE_PER_PAGE       3

#define PRICE_TAG_OFFSET 20120710
#define ITEM_BUTTON_OFFSET  120120710
#define PAGE_TAG_OFFSET      220120710

#define FIRST_SHELF_FRAME   ([DeviceDetection isIPAD]?CGRectMake(12, 150, 712, 117):CGRectMake(5, 69, 297, 54))
#define SHELF_SEPERATOR     ([DeviceDetection isIPAD]?240:110)
#define FIRST_ITEM_FRAME    ([DeviceDetection isIPAD]?CGRectMake(70, 56, 122, 122):CGRectMake(24, 23, 61, 61))
#define FIRST_PRICE_COIN_FRAME  ([DeviceDetection isIPAD]?CGRectMake(96, 196, 34, 34):CGRectMake(37, 89, 17, 17))
#define FIRST_PRICE_LABEL_FRAME ([DeviceDetection isIPAD]?CGRectMake(138, 196, 100, 34):CGRectMake(57, 89, 42, 17))
#define ITEM_SEPERATOR  ([DeviceDetection isIPAD]?235:98)
#define OUT_ITEM_CENTER ([DeviceDetection isIPAD]?CGPointMake(153,951):CGPointMake(64,436))
#define OUT_ITEM_AMPLITUDE  ([DeviceDetection isIPAD]?100:35)

#define PRICE_LABEL_FONT_SIZE   ([DeviceDetection isIPAD]?26:13)

#define ANIM_GROUP        @"animationFallingRotate"
#define FALLING_GROUP       @"fallingGroup"

@interface VendingController () <ColorShopViewDelegate>

@end

@implementation VendingController
@synthesize itemListScrollView;
@synthesize coinsButton;
@synthesize buyCoinButton;
@synthesize outItem;

- (void)dealloc {
    [itemListScrollView release];
    [coinsButton release];
    [buyCoinButton release];
    [_itemList release];
    [outItem release];
    [super dealloc];
    
}

- (void)initButtons
{
    [self.buyCoinButton setBackgroundImage:[ShareImageManager defaultManager].orangeImage forState:UIControlStateNormal];
    [self.buyCoinButton setTitle:NSLS(@"kCoinShopTitle") forState:UIControlStateNormal];
}

- (void)initTitles
{
    [self.coinsButton setTitle:[NSString stringWithFormat:@"x %d",[AccountManager defaultManager].getBalance] forState:UIControlStateNormal];
}

- (void)addPageViewBackground:(UIView*)view
{
    ShareImageManager* manager = [ShareImageManager defaultManager];
    //add background
    UIImageView* bg = [[[UIImageView alloc] initWithImage:manager.shoppingBackground] autorelease];
    [bg setFrame:CGRectMake(0, 
                            0, 
                            self.itemListScrollView.frame.size.width, 
                            self.itemListScrollView.frame.size.height)];
    [view addSubview:bg];
    
    //add shelf
    for (int i = 0; i < LINE_PER_PAGE; i ++) {
        UIImageView* shelf = [[[UIImageView alloc] initWithImage:manager.shopShelf] autorelease];
        CGRect rect = FIRST_SHELF_FRAME;
        [shelf setFrame:CGRectMake(rect.origin.x, 
                                   rect.origin.y + i*SHELF_SEPERATOR, 
                                   rect.size.width, 
                                   rect.size.height)];
        [view addSubview:shelf];
    }
}

- (void)addItem:(Item*)item 
     toPageView:(UIView*)view 
      withIndex:(int)index
{
    ToolView* toolView = [[ToolView alloc] initWithItemType:item.type number:item.amount];
    [toolView setFrame:CGRectMake(FIRST_ITEM_FRAME.origin.x + ITEM_SEPERATOR*(index%ITEM_COUNT_PER_LINE), 
                                 FIRST_ITEM_FRAME.origin.y + SHELF_SEPERATOR*(index/ITEM_COUNT_PER_LINE), 
                                 FIRST_ITEM_FRAME.size.width, 
                                  FIRST_ITEM_FRAME.size.height)];
//    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(FIRST_ITEM_FRAME.origin.x + ITEM_SEPERATOR*(index%ITEM_COUNT_PER_LINE), 
//                                                                  FIRST_ITEM_FRAME.origin.y + SHELF_SEPERATOR*(index/ITEM_COUNT_PER_LINE), 
//                                                                  FIRST_ITEM_FRAME.size.width, 
//                                                                  FIRST_ITEM_FRAME.size.height)];
    UIImageView* coin = [[UIImageView alloc] initWithFrame:CGRectMake(FIRST_PRICE_COIN_FRAME.origin.x + ITEM_SEPERATOR*(index%ITEM_COUNT_PER_LINE), 
                                                                  FIRST_PRICE_COIN_FRAME.origin.y + SHELF_SEPERATOR*(index/ITEM_COUNT_PER_LINE), 
                                                                  FIRST_PRICE_COIN_FRAME.size.width, 
                                                                  FIRST_PRICE_COIN_FRAME.size.height)];
    UILabel* priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(FIRST_PRICE_LABEL_FRAME.origin.x + ITEM_SEPERATOR*(index%ITEM_COUNT_PER_LINE), 
                                                                  FIRST_PRICE_LABEL_FRAME.origin.y + SHELF_SEPERATOR*(index/ITEM_COUNT_PER_LINE), 
                                                                  FIRST_PRICE_LABEL_FRAME.size.width, 
                                                                  FIRST_PRICE_LABEL_FRAME.size.height)];
    
    [coin setImage:[ShareImageManager defaultManager].smallCoin];
    
    [priceLabel setText:[NSString stringWithFormat:@"%d",item.price]];
    [priceLabel setBackgroundColor:[UIColor clearColor]];
    
    [priceLabel setFont:[UIFont systemFontOfSize:PRICE_LABEL_FONT_SIZE]];
    
    int pageIndex = view.tag-PAGE_TAG_OFFSET;
    toolView.tag = pageIndex*LINE_PER_PAGE*ITEM_COUNT_PER_LINE+index+ITEM_BUTTON_OFFSET;
    [toolView addTarget:self action:@selector(clickItemButton:)];
    
    [view addSubview:toolView];
    [view addSubview:coin];
    [view addSubview:priceLabel];
    [toolView release];
    [coin release];
    [priceLabel release];
    
    
}

- (void)addItemsToPageView:(UIView*)view 
            withPageIndex:(int)pageIndex
{
    for (int i = 0; i < LINE_PER_PAGE*ITEM_COUNT_PER_LINE; i ++) {
        int itemIndex = pageIndex*LINE_PER_PAGE*ITEM_COUNT_PER_LINE+i;
        if (itemIndex >= _itemList.count) {
            return;
        }
        Item* item = [_itemList objectAtIndex:itemIndex];
        view.tag = pageIndex+PAGE_TAG_OFFSET;
        [self addItem:item 
           toPageView:view 
            withIndex:i];
    }
}

- (UIView*)viewWithPageIndex:(int)pageIndex
{
    UIView* view = [[[UIView alloc] initWithFrame:CGRectMake(self.itemListScrollView.frame.size.width*pageIndex, 
                                                            0, 
                                                            self.itemListScrollView.frame.size.width, 
                                                            self.itemListScrollView.frame.size.height)] autorelease];
    [self addPageViewBackground:view];
    [self addItemsToPageView:view withPageIndex:pageIndex];
    return view;
}

- (void)createItemList
{
    int pageCount = (_itemList.count-1)/(LINE_PER_PAGE*ITEM_COUNT_PER_LINE) + 1;
    [self.itemListScrollView setContentSize:CGSizeMake(self.itemListScrollView.frame.size.width*pageCount, self.itemListScrollView.frame.size.height)];
    for (int i = 0; i < pageCount; i ++) {
        UIView* view = [self viewWithPageIndex:i];
        [self.itemListScrollView addSubview:view];
    }
}

- (void)refleshToolViewForItem:(Item*)anItem
{
    int pageCount = _itemList.count/(LINE_PER_PAGE*ITEM_COUNT_PER_LINE) + 1;
    for (int i = 0; i < pageCount; i ++) {
        UIView* view = [self.itemListScrollView viewWithTag:PAGE_TAG_OFFSET+i];
        int firstItemTag = i*LINE_PER_PAGE*ITEM_COUNT_PER_LINE;
        for (int j = firstItemTag; j < firstItemTag+LINE_PER_PAGE*ITEM_COUNT_PER_LINE; j ++) {
            ToolView* tool = (ToolView*)[view viewWithTag:(ITEM_BUTTON_OFFSET+j)];
            if (tool && tool.itemType == anItem.type) {
                if ([Item isItemCountable:anItem.type]) {
                    [tool setNumber:[[ItemManager defaultManager] amountForItem:anItem.type]];
                    
                } else {
                    [tool setAlreadyHas:YES];
                }
            }
        }
    }

}

- (IBAction)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)buyCoin:(id)sender
{
    CoinShopController* controller = [[[CoinShopController alloc] init] autorelease];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)clickItemButton:(id)sender
{
    [self.outItem.layer removeAllAnimations];
    ToolView* button = (ToolView*)sender;
    if (![Item isItemCountable:button.itemType] && button.alreadyHas) {
        return;
    }
    int itemIndex = button.tag-ITEM_BUTTON_OFFSET;
    if (itemIndex < _itemList.count) {
        Item* item = [_itemList objectAtIndex:itemIndex];
        if (item.type == ItemTypeColor) {
            ColorShopView *colorShop = [ColorShopView colorShopViewWithFrame:self.view.bounds];
            colorShop.delegate = self;
            [colorShop showInView:self.view animated:YES];
        } else {
            [CommonItemInfoView showItem:item infoInView:self];
        }
    }
    
}

#define FALLING_TIME    0.05
#define TIME_FROME_CENTER_TO_SIDE   1
#define ENLARGE_DURATION    2
#define ENLARGE_RATE    20
- (void)showBuyItemAnimation:(Item*)anItem
{
    [self.outItem setImage:anItem.itemImage];
    
    CAAnimation* falling = [AnimationManager translationAnimationFrom:self.outItem.center 
                                                                   to:OUT_ITEM_CENTER 
                                                             duration:FALLING_TIME 
                                                             delegate:self 
                                                     removeCompeleted:NO];
    
    CAAnimation* rolling = [AnimationManager rotationAnimationWithRoundCount:1 
                                                                    duration:TIME_FROME_CENTER_TO_SIDE];
    rolling.delegate = self;
    rolling.beginTime =FALLING_TIME;
    rolling.autoreverses = YES;
    rolling.removedOnCompletion = NO;
    
    CAAnimation* rRolling = [AnimationManager rotationAnimationWithRoundCount:-1 
                                                                     duration:TIME_FROME_CENTER_TO_SIDE];
    rRolling.delegate = self;
    rRolling.beginTime =FALLING_TIME + 2*TIME_FROME_CENTER_TO_SIDE;
    rRolling.autoreverses = YES;
    rRolling.removedOnCompletion = NO;
    
    CAAnimation* moveToRight = [AnimationManager translationAnimationTo:CGPointMake(OUT_ITEM_CENTER.x+OUT_ITEM_AMPLITUDE, OUT_ITEM_CENTER.y) 
                                                               duration:TIME_FROME_CENTER_TO_SIDE];
    moveToRight.beginTime = FALLING_TIME;
    moveToRight.removedOnCompletion = NO;
    
    CAAnimation* moveToLeft = [AnimationManager translationAnimationFrom:CGPointMake(OUT_ITEM_CENTER.x+OUT_ITEM_AMPLITUDE, OUT_ITEM_CENTER.y) 
                                                                      to:CGPointMake(OUT_ITEM_CENTER.x-OUT_ITEM_AMPLITUDE, OUT_ITEM_CENTER.y) 
                                                                duration:2*TIME_FROME_CENTER_TO_SIDE];
    moveToLeft.beginTime = moveToRight.beginTime+moveToRight.duration;
    moveToLeft.removedOnCompletion = NO;
    
    CAAnimation* moveToCenter = [AnimationManager translationAnimationFrom:CGPointMake(OUT_ITEM_CENTER.x-OUT_ITEM_AMPLITUDE, OUT_ITEM_CENTER.y) 
                                                                        to:OUT_ITEM_CENTER 
                                                                  duration:TIME_FROME_CENTER_TO_SIDE];
    moveToCenter.beginTime = moveToLeft.beginTime+moveToLeft.duration;
    moveToCenter.removedOnCompletion = NO;
    
    CAAnimation* toScreenCenter = [AnimationManager translationAnimationFrom:OUT_ITEM_CENTER 
                                                                          to:self.view.center 
                                                                    duration:ENLARGE_DURATION 
                                                                    delegate:self 
                                                            removeCompeleted:NO];
    toScreenCenter.beginTime = moveToCenter.beginTime + moveToCenter.duration;
    
    
    CAAnimation* enLarge = [AnimationManager scaleAnimationWithScale:ENLARGE_RATE 
                                                            duration:ENLARGE_DURATION 
                                                            delegate:self 
                                                    removeCompeleted:NO];
    enLarge.beginTime = moveToCenter.beginTime + moveToCenter.duration;
    //enLarge.removedOnCompletion = NO;
    
    CAAnimation* disappear = [AnimationManager missingAnimationWithDuration:ENLARGE_DURATION];
    disappear.beginTime = moveToCenter.beginTime + moveToCenter.duration;
    disappear.removedOnCompletion = NO;
    
    //method2:放入动画数组，统一处理！
    CAAnimationGroup* animGroup    = [CAAnimationGroup animation];
    
    //设置动画代理
    animGroup.delegate = self;
    
    animGroup.removedOnCompletion = NO;
    
    animGroup.duration             = disappear.beginTime+disappear.duration;
    animGroup.timingFunction      = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];    
    animGroup.repeatCount         = 1;//FLT_MAX;  //"forever";
    animGroup.fillMode             = kCAFillModeForwards;
    animGroup.animations             = [NSArray arrayWithObjects:falling, rolling, moveToRight, moveToLeft, moveToCenter, rRolling, enLarge, disappear, toScreenCenter,nil];
    [animGroup setValue:FALLING_GROUP  forKey:ANIM_GROUP];
    //对视图自身的层添加组动画
    [self.outItem.layer addAnimation:animGroup forKey:ANIM_GROUP];
    
    

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _itemList = [[NSMutableArray alloc] initWithObjects:[Item removeAd], [Item tips], [Item colors], [Item tomato], [Item flower], [Item iceCreamPen], [Item brushPen], [Item featherPen], [Item waterPen], nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTitles];
    [self initButtons];
    [self createItemList];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setItemListScrollView:nil];
    [self setCoinsButton:nil];
    [self setBuyCoinButton:nil];
    [self setOutItem:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma animation delegate
- (void)animationDidStart:(CAAnimation *)anim
{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSString* animValue = [anim valueForKey:ANIM_GROUP];
    if ([animValue isEqualToString:FALLING_GROUP]) {
        [self.outItem setImage:nil];
    }
}

#pragma mark - colorShopView delegate
- (void)didPickedColorView:(ColorView *)colorView
{
    
}

#pragma mark - commonItemInfoViewDelegate
- (void)didBuyItem:(Item *)anItem 
            result:(int)result
{ 
    if (result == ERROR_COINS_NOT_ENOUGH) {
        [[CommonMessageCenter defaultCenter] postMessageWithText:NSLS(@"kCoinsNotEnough") delayTime:1 isHappy:NO];
    } else {
        [self.coinsButton setTitle:[NSString stringWithFormat:@"x %d",[AccountManager defaultManager].getBalance] forState:UIControlStateNormal];
        [self showBuyItemAnimation:anItem];
        [self refleshToolViewForItem:anItem];
    }
    
}



@end
