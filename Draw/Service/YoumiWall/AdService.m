//
//  AdService.m
//  Draw
//
//  Created by  on 12-6-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AdService.h"
#import "ConfigManager.h"
#import "CommonDialog.h"
#import "LocaleUtils.h"
#import "ShoppingManager.h"
#import "PPViewController.h"
#import "AccountService.h"
#import "ItemType.h"
#import "DeviceDetection.h"
#import "LmWallService.h"
#import "AdMoGoView.h"
#import "UserManager.h"
#import "HomeController.h"

#define ASK_REMOVE_AD_BY_WALL       101
#define ASK_REMOVE_AD_BY_IAP        102

#define AD_VIEW_TAG                 201206281

@interface AdService()

- (void)gotoWall;
- (void)buyCoins;

@end

@implementation AdService

@synthesize viewController = _viewController;
@synthesize adSuperViewController = _adSuperViewController;
//@synthesize adView = _adView;

static AdService* _defaultService;

- (void)dealloc
{
//    PPRelease(_adView);
    PPRelease(_adSuperViewController);
    PPRelease(_viewController);
    PPRelease(_allAdViews);
    [super dealloc];
}

- (id)init
{
    self = [super init];
    _allAdViews = [[NSMutableDictionary alloc] init];
    return self;
}

+ (AdService*)defaultService
{
    if (_defaultService == nil){
        _defaultService = [[AdService alloc] init];
    }
    
    return _defaultService;
}

- (NSInteger)getRemoveAdPrice
{
    return [MobClickUtils getIntValueByKey:@"REMOVE_AD_PRICE" defaultValue:1];
}

- (int)getLmAdPercentage
{
    return [MobClickUtils getIntValueByKey:@"LM_AD_PERCENTAGE" defaultValue:0];
//    return 0; // For DoMob Test
}

- (BOOL)isShowLmAd
{
    int percentage = [self getLmAdPercentage];
    if (percentage == 0)
        return NO;
    
    int randValue = rand() % 100;
    if (randValue <= percentage)
        return YES;
    else
        return NO;
}

- (void)setAdDisable
{
    PPDebug(@"<setAdDisable> Ad Is Disabled Now");
    
    [[AccountService defaultService] buyItem:ITEM_TYPE_REMOVE_AD 
                                   itemCount:1
                                   itemCoins:[self getRemoveAdPrice]];
    
}

- (void)askRemoveAdByWall
{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:NSLS(@"kRemoveAd") 
                                                        message:@"下载免费应用即可移除广告！记住下载完应用一定要打开才可以成功移除广告哦！" 
                                                       delegate:self 
                                              cancelButtonTitle:NSLS(@"Cancel") 
                                              otherButtonTitles:NSLS(@"OK"), nil];
    
    alertView.tag = ASK_REMOVE_AD_BY_WALL;
    [alertView show];
    [alertView release];
}

- (void)askRemoveAdByBuyCoins
{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:NSLS(@"kRemoveAd") 
                                                        message:NSLS(@"kRemoveAdByIAP") 
                                                       delegate:self 
                                              cancelButtonTitle:NSLS(@"Cancel") 
                                              otherButtonTitles:NSLS(@"OK"), nil];
    
    alertView.tag = ASK_REMOVE_AD_BY_IAP;
    [alertView show];
    [alertView release];    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0){
        return;
    }
    
    switch (alertView.tag) {
        case ASK_REMOVE_AD_BY_IAP:
            [self buyCoins];
            break;
            
        case ASK_REMOVE_AD_BY_WALL:
            [self gotoWall];
            break;
            
        default:
            break;
    }
}

#pragma mark - Buy Coins By IAP

- (void)buyCoins
{
    [MobClick event:@"BUY_COINS"];
    
    NSArray* coinPriceList = [[ShoppingManager defaultManager] findCoinPriceList];
    if ([coinPriceList count] > 0){
        PriceModel* model = [coinPriceList objectAtIndex:0];
        [_viewController showActivityWithText:NSLS(@"kBuying")];
        [[AccountService defaultService] setDelegate:self];
        [[AccountService defaultService] buyCoin:model];
        
    }    
}

#pragma mark - Show Ad Wall

- (void)gotoWall
{
    [[LmWallService defaultService] show:_viewController isForRemoveAd:YES];
}

#pragma mark - Account Service Delegate

- (void)didFinishBuyProduct:(int)resultCode
{
    [_viewController hideActivity];
    
    if (resultCode != 0 && resultCode != PAYMENT_CANCEL){
        [MobClick event:@"BUY_COINS_OK"];        
        [_viewController popupMessage:NSLS(@"kFailToConnectIAPServer") title:nil]; 

        // clear view controller after finishing IAP
        [self setViewController:nil]; 
        return;
    }
    else if (resultCode == PAYMENT_CANCEL){
        [MobClick event:@"BUY_COINS_CANCEL"];

        // clear view controller after finishing IAP
        [self setViewController:nil]; 
        return;
    }
    
    if (resultCode == 0){
        [_viewController popupMessage:NSLS(@"kBuyCoinsSucc") title:nil];
        
        // Remove Ad here
        [self setAdDisable];
    }

    // clear view controller after finishing IAP
    [self setViewController:nil];    
}

- (void)didProcessingBuyProduct
{
    [_viewController hideActivity];
    [_viewController showActivityWithText:NSLS(@"kProcessingIAP")];
}

#pragma mark - LM Ad View Delegate

- (void) lmmobAdBannerViewDidReceiveAd: (LmmobAdBannerView*) bannerView{
    
    PPDebug(@"<lmmobAdBannerViewDidReceiveAd> success");    
}

- (void) lmmobAdBannerViewWillPresentScreen: (LmmobAdBannerView*) bannerView{
    PPDebug(@"<lmmobAdBannerViewWillPresentScreen> success");        
}

- (void) lmmobAdBannerView: (LmmobAdBannerView*) bannerView didFailReceiveBannerADWithError: (NSError*) error{
    PPDebug(@"<didFailReceiveBannerADWithError>:%@", error);    
}

//#pragma mark - Ad View Dictionary Management
//
//- (void)addAdView:(UIView*)adView superView:(UIView*)superView
//{
//    if (superView == nil || adView == nil)
//        return;
//
//    NSString* key = [superView description];
//    [_allAdViews setObject:adView forKey:key];
//}
//
//- (UIView*)adViewBySuperView:(UIView*)superView
//{
//    if (superView == nil)
//        return nil;
//    
//    NSString* key = [superView description];
//    return [_allAdViews objectForKey:key];
//}

#pragma mark - Mango Ad View Delegate

- (NSString *)adMoGoApplicationKey
{
    return @"ad29f0cf8361452db392ffdef8057eff";
    
//    return @"d5d65eff49774712aa2aeef656b4c600"; // DoMob Test ID
}

- (UIViewController *)viewControllerForPresentingModalView
{
    return [HomeController defaultInstance].navigationController;
}

- (void)adMoGoDidReceiveAd:(AdMoGoView *)adMoGoView
{
    PPDebug(@"<adMoGoDidReceiveAd>");
}

- (void)adMoGoDeleteAd:(AdMoGoView *)adMoGoView
{
    PPDebug(@"<adMoGoDeleteAd>");    
}

- (void)adMoGoDidFailToReceiveAd:(AdMoGoView *)adMoGoView usingBackup:(BOOL)yesOrNo
{
    PPDebug(@"<adMoGoDidFailToReceiveAd> usingBackup=%d", yesOrNo);    
}

//- (void)adMoGoWillPresentFullScreenModal;
//- (void)adMoGoDidDismissFullScreenModal;
//- (void)adMoGoFullScreenAdReceivedRequest;
//- (void)adMoGoFullScreenAdFailed;
//- (void)adMoGoWillPresentFullScreenAdModal;
//- (void)adMoGoDidDismissFullScreenAdModal;

//- (NSString *)phoneNumber; // user's phone number
//- (CLLocation *)locationInfo; // user's current location
//- (NSString *)postalCode; // user's postal code, e.g. "94401"
//- (NSString *)areaCode; // user's area code, e.g. "415"
//- (NSDate *)dateOfBirth; // user's date of birth
- (NSString *)gender
{
    return [[UserManager defaultManager] gender];
}

#pragma mark - Methods For External

- (void)requestRemoveAd:(PPViewController*)viewController
{
    self.viewController = viewController;
    if ([ConfigManager wallEnabled]){
        [self askRemoveAdByWall];
    }
    else{
        [self askRemoveAdByBuyCoins];
    }    
}

- (BOOL)isShowAd
{
    if ([ConfigManager isProVersion])
        return NO;
    
    BOOL hasItemBought = [[AccountService defaultService] hasEnoughItemAmount:ITEM_TYPE_REMOVE_AD 
                                                                       amount:1];
    return (hasItemBought == NO); // item not bought, then show Ad
}

- (void)hideAdViewInView:(UIView*)superView;
{
//    UIView* adView = [self adViewBySuperView:superView];    
//    if ([adView superview] != nil){
//        [adView removeFromSuperview];
//    }
}

- (UIView*)createMangoAdInView:(UIViewController*)superViewContoller
                         frame:(CGRect)frame 
                     iPadFrame:(CGRect)iPadFrame
{
    if ([self isShowAd] == NO){
        return nil;
    }
        
    self.adSuperViewController = superViewContoller;        
    UIView* superView = superViewContoller.view;
    AdMoGoView* adView = nil;
    
    // create view
    adView = [AdMoGoView requestAdMoGoViewWithDelegate:self 
                                             AndAdType:AdViewTypeNormalBanner
                                           ExpressMode:YES];            
    
    // set view frame
    if ([DeviceDetection isIPAD]){
        [adView setFrame:iPadFrame];
    }
    else{
        [adView setFrame:frame];
    }
    
    // set view data
    adView.tag = AD_VIEW_TAG;
    adView.delegate = self;
    
    // add to super view
    [superView addSubview:adView];    
    return adView;
}


- (void)clearAdView:(UIView*)adView
{
    if ([adView isKindOfClass:[AdMoGoView class]]){
        ((AdMoGoView*)adView).delegate = nil;
    }
    else if ([adView isKindOfClass:[LmmobAdBannerView class]]){
        ((LmmobAdBannerView*)adView).delegate = nil;
    }
}

- (UIView*)createAdInView:(UIViewController*)superViewContoller
                    frame:(CGRect)frame 
                iPadFrame:(CGRect)iPadFrame
{        
    if ([self isShowAd] == NO){
        return nil;
    }

    if ([self isShowLmAd] == NO){
        return [self createMangoAdInView:superViewContoller frame:frame iPadFrame:iPadFrame];
    }
            
    // Create LM Ad View
    UIView* superView = superViewContoller.view;
    LmmobAdBannerView* adView = nil;
    if ([DeviceDetection isIPAD]){
        adView = [[[LmmobAdBannerView alloc] initWithFrame:iPadFrame] autorelease];
        adView.adPositionIdString = @"5a1da27e02e91c4bf169452cef159a6e";    
        adView.specId = 0;
    }
    else{
        adView = [[[LmmobAdBannerView alloc] initWithFrame:frame] autorelease];
        adView.adPositionIdString = @"eb4ce4f0a0f1f49b6b29bf4c838a5147";
        adView.specId = 0;
    }
    
    if ([DeviceDetection isIPAD]){
        [adView setFrame:iPadFrame];
    }
    else{
        [adView setFrame:frame];
    }
    
    adView.tag = AD_VIEW_TAG;
    adView.appVersionString = [UIUtils getAppVersion];
    adView.delegate = self;
    adView.autoRefreshAdTimeOfSeconds = 30;
    [superView addSubview:adView];    
    [adView requestBannerAd];        
    return adView;
}



@end
