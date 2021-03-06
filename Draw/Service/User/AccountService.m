//
//  AccountService.m
//  Draw
//
//  Created by  on 12-3-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AccountService.h"
#import "PPDebug.h"
#import "ShoppingManager.h"
#import "AccountManager.h"
#import "GameNetworkConstants.h"
#import "GameNetworkRequest.h"
#import "PPNetworkRequest.h"
#import "UserManager.h"
#import "GTMBase64.h"
#import "ItemManager.h"
#import "UserItem.h"
#import "TimeUtils.h"
#import "StoreKitUtils.h"
#import "TransactionReceiptManager.h"
#import "MobClick.h"
#import "UIDevice+IdentifierAddition.h"
#import "ConfigManager.h"
#import "UserService.h"
#import "LevelService.h"

#define DRAW_IAP_PRODUCT_ID_PREFIX @"com.orange."

@implementation AccountService

static AccountService* _defaultAccountService;

@synthesize delegate = _delegate;

- (void)dealloc
{
    [_delegate release];
    [super dealloc];
}

+ (AccountService*)defaultService
{
    if (_defaultAccountService == nil)
        _defaultAccountService = [[AccountService alloc] init];
    
    return _defaultAccountService;
}

- (id)init
{
    self = [super init];
    
    _itemManager = [ItemManager defaultManager];
    _accountManager = [AccountManager defaultManager];
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    return self;
}

#pragma mark - methods for buy coins and items

- (void)buyCoin:(PriceModel*)price
{
    // send request to Apple IAP Server and wait for result
    SKProduct *selectedProduct = [[ShoppingManager defaultManager] productWithId:price.productId];
//    if (selectedProduct == nil){
//        PPDebug(@"<buyCoin> but SKProduct of price is null");
//        if ([self.delegate respondsToSelector:@selector(didFinishBuyProduct:)]){
//            [self.delegate didFinishBuyProduct:ERROR_NO_PRODUCT];
//        }
//        return;
//    }
    PPDebug(@"<buyCoin> on product %@ price productId=%@", 
            selectedProduct == nil ? price.productId : [selectedProduct productIdentifier],
            price.productId);    
    
    SKPayment *payment = nil;
    if (selectedProduct == nil){
        payment = [SKPayment paymentWithProductIdentifier:price.productId];
    }
    else{
        payment = [SKPayment paymentWithProduct:selectedProduct];
    }
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}


#pragma mark - IAP transaction handling

- (void)makeBuyCoinsRequest:(PriceModel*)price transaction:(SKPaymentTransaction*)transaction
{
    int amount = [[price count] intValue];
    NSString *base64receipt = [GTMBase64 stringByEncodingData:transaction.transactionReceipt];
    [self chargeAccount:amount 
                 source:PurchaseType 
          transactionId:transaction.transactionIdentifier
     transactionRecepit:base64receipt];
}

- (void)recordTransaction:(SKPaymentTransaction*)transaction
{
    PPDebug(@"<recordTransaction> transaction = %@ [%@]", 
            transaction.transactionIdentifier,
            [transaction.transactionReceipt description]);
    
    // TODO Must Record transactionIdentifier & transactionReceipt in server
    
    NSString* productId  = transaction.payment.productIdentifier;
    PriceModel* price = [[ShoppingManager defaultManager] findCoinPriceByProductId:productId];
    if (price == nil){
        PPDebug(@"<recordTransaction> but coin price is nil");
        return;
    }
        
    [self makeBuyCoinsRequest:price transaction:transaction];
}

- (void)provideContent:(NSString*)productId
{
    PPDebug(@"<provideContent> productId = %@", productId);    
    
    // update UI here    
    int resultCode = PAYMENT_SUCCESS;
    if ([_delegate respondsToSelector:@selector(didFinishBuyProduct:)]){
        [_delegate didFinishBuyProduct:resultCode];
    }
}

- (void) completeTransaction: (SKPaymentTransaction *)transaction
{
    PPDebug(@"<completeTransaction> transaction = %@", transaction.transactionIdentifier);
    
    // Your application should implement these two methods.
    [self recordTransaction:transaction];
    [self provideContent:transaction.payment.productIdentifier];
    
    // Remove the transaction from the payment queue.
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void) restoreTransaction: (SKPaymentTransaction *)transaction
{
    PPDebug(@"<restoreTransaction> transaction = %@", transaction.transactionIdentifier);
    [self recordTransaction: transaction];
    [self provideContent: transaction.originalTransaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void) failedTransaction: (SKPaymentTransaction *)transaction
{
    PPDebug(@"<failedTransaction> error code = %d", transaction.error.code);
    if (transaction.error.code != SKErrorPaymentCancelled) {
        // TODO display an error here to UI
        int resultCode = PAYMENT_FAILURE;
        if ([_delegate respondsToSelector:@selector(didFinishBuyProduct:)]){
            [_delegate didFinishBuyProduct:resultCode];
        }        
    }
    else{
        int resultCode = PAYMENT_CANCEL;
        if ([_delegate respondsToSelector:@selector(didFinishBuyProduct:)]){
            [_delegate didFinishBuyProduct:resultCode];
        }                
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

#pragma mark - IAP delegate methods

// Sent when the transaction array has changed (additions or state changes).  Client should check state of transactions and finish as appropriate.
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions 
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        PPDebug(@"<updatedTransactions> productId=%@, transactionState=%d", 
                transaction.payment.productIdentifier, transaction.transactionState);
        
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
            case SKPaymentTransactionStatePurchasing:
                if ([_delegate respondsToSelector:@selector(didProcessingBuyProduct:)]){
                    [_delegate didProcessingBuyProduct];
                }
                break;
            default:
                break;
        }
    }
}

// Sent when transactions are removed from the queue (via finishTransaction:).
- (void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray *)transactions 
{
    PPDebug(@"<removedTransactions> %@", [transactions description]);
}

// Sent when an error is encountered while adding transactions from the user's purchase history back to the queue.
- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error
{
    PPDebug(@"<restoreCompletedTransactionsFailedWithError> %@", [error description]);    
}

- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    PPDebug(@"<paymentQueueRestoreCompletedTransactionsFinished>");        
}

#pragma mark - Charge/Deduct Service to Server

- (void)retryVerifyReceiptAtBackground
{
    NSArray* retryList = [[TransactionReceiptManager defaultManager] findAllUnverfiedReceipts];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    if (queue == NULL)
        return;
    
    
    for (TransactionReceipt* receipt in retryList){
        NSString* receiptString = [NSString stringWithFormat:@"%@",receipt.transactionReceipt];
        dispatch_async(queue, ^{
            TransactionVerifyResult result = [StoreKitUtils verifyReceipt:receiptString productIdPrefix:DRAW_IAP_PRODUCT_ID_PREFIX];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (result == VERIFY_UNKNOWN){
                    PPDebug(@"<verifyReceiptWithAmount> UNKNOWN, Maybe Network Failure");
                    [[TransactionReceiptManager defaultManager] verifyUnknown:receipt];                    
                }
                else if (result == VERIFY_OK){
                    PPDebug(@"<verifyReceiptWithAmount> OK");
                    [[TransactionReceiptManager defaultManager] verifySuccess:receipt];                    
                }
                else{
                    PPDebug(@"<verifyReceiptWithAmount> FAIL, code=%d", result);                                
                    [[TransactionReceiptManager defaultManager] verifyFailure:receipt errorCode:result];                    
                    
                    // reset account balance
                    [self deductAccount:[receipt.amount intValue] source:RefundForVerifyReceiptFailure];
                }
            });    
        });
    }
}



- (void)verifyReceiptWithAmount:(int)amount
                  transactionId:(NSString*)transactionId
             transactionRecepit:(NSString*)transactionRecepit
{
    dispatch_async(workingQueue, ^{
        
        TransactionVerifyResult result = VERIFY_UNKNOWN;
        if ([transactionId hasPrefix:@"com.urus.iap."]){
            result = VERIFY_FAKE_IAP;
        }
        else{
            result = [StoreKitUtils verifyReceipt:transactionRecepit
                                  productIdPrefix:DRAW_IAP_PRODUCT_ID_PREFIX];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (result == VERIFY_UNKNOWN){
                PPDebug(@"<verifyReceiptWithAmount> UNKNOWN, Maybe Network Failure");
                
                [[TransactionReceiptManager defaultManager] createReceipt:transactionId 
                                                                productId:nil 
                                                                   amount:amount 
                                                       transactionReceipt:transactionRecepit];
            }
            else if (result == VERIFY_OK){
                PPDebug(@"<verifyReceiptWithAmount> OK");

                // for test
//                [[TransactionReceiptManager defaultManager] createReceipt:transactionId 
//                                                                productId:nil 
//                                                                   amount:amount 
//                                                       transactionReceipt:transactionRecepit];
            }
            else{
                PPDebug(@"<verifyReceiptWithAmount> FAIL, code=%d", result);                                      
                // reset account balance
                [self deductAccount:amount source:RefundForVerifyReceiptFailure];

                [UIUtils alert:NSLS(@"kFakeIAPPurchase")];
            }
        });        
    });
    
}

- (void)chargeAccount:(int)amount 
               source:(BalanceSourceType)source 
        transactionId:(NSString*)transactionId
   transactionRecepit:(NSString*)transactionRecepit
{
    NSString* userId = [[UserManager defaultManager] userId];
    
    // update balance locally
    [[AccountManager defaultManager] increaseBalance:amount sourceType:source]; 
    
    dispatch_async(workingQueue, ^{
        CommonNetworkOutput* output = nil;        
        output = [GameNetworkRequest chargeAccount:SERVER_URL 
                                            userId:userId 
                                            amount:amount 
                                            source:source 
                                     transactionId:transactionId 
                                transactionReceipt:transactionRecepit];
                
        dispatch_async(dispatch_get_main_queue(), ^{
            if (output.resultCode == ERROR_SUCCESS) {
                // update balance from server
                int balance = [[output.jsonDataDict objectForKey:PARA_ACCOUNT_BALANCE] intValue];
                if (balance != [[AccountManager defaultManager] getBalance]){
                    PPDebug(@"<deductAccount> balance not the same, local=%d, remote=%d", 
                            [[AccountManager defaultManager] getBalance], balance);
                }

            }
            else{                
                PPDebug(@"<chargeAccount> failure, result=%d", output.resultCode);
                if (output.resultCode == 70003 || output.resultCode == 70004){
                    PPDebug(@"<chargeAccount> fake IAP, refund money");
                    [[AccountManager defaultManager] decreaseBalance:amount sourceType:source];                     
                }
            }
            
            if (source == PurchaseType){
                [self verifyReceiptWithAmount:amount 
                                transactionId:transactionId 
                           transactionRecepit:transactionRecepit];
            }
        });        
    });
}

- (void)awardAccount:(int)amount 
               source:(BalanceSourceType)source
{
    [self chargeAccount:amount source:source transactionId:nil transactionRecepit:nil];        
}

- (void)chargeAccount:(int)amount 
               source:(BalanceSourceType)source
{
    if (amount > 0) {
        [self chargeAccount:amount source:source transactionId:nil transactionRecepit:nil];        
    }

}

- (void)deductAccount:(int)amount 
               source:(BalanceSourceType)source
{
    if (amount <= 0) {
        return;
    }
    NSString* userId = [[UserManager defaultManager] userId];
    
    // update balance locally
    [[AccountManager defaultManager] decreaseBalance:amount sourceType:source]; 
    
    dispatch_async(workingQueue, ^{
        CommonNetworkOutput* output = nil;        
        output = [GameNetworkRequest deductAccount:SERVER_URL 
                                            userId:userId 
                                            amount:amount 
                                            source:source];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (output.resultCode == ERROR_SUCCESS) {
                // update balance from server
                int balance = [[output.jsonDataDict objectForKey:PARA_ACCOUNT_BALANCE] intValue];
                if (balance != [[AccountManager defaultManager] getBalance]){
                    PPDebug(@"<deductAccount> balance not the same, local=%d, remote=%d", 
                            [[AccountManager defaultManager] getBalance], balance);
                }
            }
            else{
                PPDebug(@"<deductAccount> failure, result=%d", output.resultCode);
            }
        });        
    });    
}

- (void)syncAccountBalanceToServer
{
    int balance = [_accountManager getBalance];
    PPDebug(@"<syncAccountBalanceToServer> balance=%d", balance);
    NSString* userId = [[UserManager defaultManager] userId];
    
    dispatch_async(workingQueue, ^{
        CommonNetworkOutput* output = nil;        
        output = [GameNetworkRequest updateBalance:SERVER_URL 
                                            userId:userId 
                                           balance:balance];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (output.resultCode == ERROR_SUCCESS) {
            }
            else{
            }
        });      
    });
}


- (void)syncItemRequest:(UserItem*)userItem
           targetUserId:(NSString*)targetUserId
            awardAmount:(int)awardAmount
               awardExp:(int)awardExp

{
    PPDebug(@"<syncItemRequest> item=%@ targetUserId=%@ awardAmount=%d awardExp=%d", 
            [userItem description], targetUserId, awardAmount, awardExp);
    NSString* userId = [[UserManager defaultManager] userId];
    
    dispatch_async(workingQueue, ^{
        CommonNetworkOutput* output = nil;        
        output = [GameNetworkRequest updateItemAmount:SERVER_URL 
                                               userId:userId 
                                             itemType:[[userItem itemType] intValue]
                                               amount:[[userItem amount] intValue]
                                         targetUserId:targetUserId
                                          awardAmount:awardAmount 
                                             awardExp:awardExp];
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (output.resultCode == ERROR_SUCCESS) {
//            }
//            else{
//            }
//        });      
    });
}

- (void)syncItemRequest:(UserItem*)userItem
{
    [self syncItemRequest:userItem targetUserId:nil awardAmount:0 awardExp:0];
}

- (int)buyItem:(int)itemType
      itemCount:(int)itemCount
      itemCoins:(int)itemCoins
{
    PPDebug(@"<buyItem> type=%d, count=%d, cost coins=%d", itemType, itemCount, itemCoins);
    
    if ([self hasEnoughCoins:itemCoins] == NO){
        PPDebug(@"<buyItem> but balance(%d) not enough, item cost(%d)", 
                [[AccountManager defaultManager] getBalance], itemCoins);
        return ERROR_COINS_NOT_ENOUGH;
    }
    
    // save item locally and synchronize remotely
    [[ItemManager defaultManager] increaseItem:itemType amount:itemCount];
    UserItem* userItem = [[ItemManager defaultManager] findUserItemByType:itemType];
    [self syncItemRequest:userItem];

    // deduct account
    [self deductAccount:itemCoins source:BuyItemType];    
    
    return 0;
}

- (int)consumeItem:(int)itemType
             amount:(int)amount
{
    if ([self hasEnoughItemAmount:itemType amount:amount] == NO){
        PPDebug(@"<consumeItem> but item amount(%d) not enough, consume count(%d)", 
                [[[[ItemManager defaultManager] findUserItemByType:itemType] amount] intValue], amount);
        return ERROR_ITEM_NOT_ENOUGH;
    }

    // save item locally and synchronize remotely
    [[ItemManager defaultManager] decreaseItem:itemType amount:amount];
    UserItem* userItem = [[ItemManager defaultManager] findUserItemByType:itemType];
    [self syncItemRequest:userItem];
    
    return 0;
}

- (int)consumeItem:(int)itemType
            amount:(int)amount
      targetUserId:(NSString*)targetUserId
       awardAmount:(int)awardAmount
          awardExp:(int)awardExp
{
    if ([self hasEnoughItemAmount:itemType amount:amount] == NO){
        PPDebug(@"<consumeItem> but item amount(%d) not enough, consume count(%d)", 
                [[[[ItemManager defaultManager] findUserItemByType:itemType] amount] intValue], amount);
        return ERROR_ITEM_NOT_ENOUGH;
    }
    
    // save item locally and synchronize remotely
    [[ItemManager defaultManager] decreaseItem:itemType amount:amount];
    
    UserItem* userItem = [[ItemManager defaultManager] findUserItemByType:itemType];
    [self syncItemRequest:userItem
             targetUserId:targetUserId
              awardAmount:awardAmount
                 awardExp:awardExp];
    
    return 0;    
}

- (BOOL)hasEnoughCoins:(int)amount
{
    return [[AccountManager defaultManager] hasEnoughBalance:amount];
}

- (BOOL)hasEnoughItemAmount:(int)itemType amount:(int)amount
{
    UserItem* userItem = [[ItemManager defaultManager] findUserItemByType:itemType];
    if (userItem == nil)
        return NO;
    
    return [[userItem amount] intValue] >= amount;
}

#define KEY_LAST_CHECKIN_DATE   @"KEY_LAST_CHECKIN_DATE"
#define MAX_CHECKIN_COINS       5

- (int)getCheckInMaxReward
{
    NSString* value = [MobClick getConfigParams:@"REWARD_CHECKIN"];
    int maxReward = 0;
    if ([value length] > 0){
        maxReward = [value intValue];
    }
    
    if (maxReward <= 0){
        maxReward = MAX_CHECKIN_COINS;
    }
    
    return maxReward;
}

- (int)checkIn
{
    
    int maxReward = [self getCheckInMaxReward];    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDate* lastCheckInDate = [userDefaults objectForKey:KEY_LAST_CHECKIN_DATE];
    if (lastCheckInDate != nil && isLocalToday(lastCheckInDate)){
        // already check in, return -1
        PPDebug(@"<checkIn> but already do it today... come tomorrow :-)");
        return -1;
    }

    // random get some coins
    int coins = rand() % maxReward + 1;
    PPDebug(@"<checkIn> got %d coins", coins);
    [self chargeAccount:coins source:CheckInType]; 
    
    // update check in today flag
    [userDefaults setObject:[NSDate date] forKey:KEY_LAST_CHECKIN_DATE];
    [userDefaults synchronize];    
    return coins;
}

#define DEFAULT_DEVIATION       (5000)

- (void)syncAccountAndItem
{    
    NSString* userId = [[UserManager defaultManager] userId];
    NSString* deviceId = [[UIDevice currentDevice] uniqueGlobalDeviceIdentifier];
    if (userId == nil){
        return;
    }
    
    dispatch_async(workingQueue, ^{
        CommonNetworkOutput* output = nil;        
        output = [GameNetworkRequest syncUserAccontAndItem:SERVER_URL 
                                                    userId:userId 
                                                  deviceId:deviceId]; 
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (output.resultCode == ERROR_SUCCESS) {                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
//                    int deviation = [[output.jsonDataDict objectForKey:PARA_DEVIATION] intValue];
//                    if (deviation == 0){
//                        deviation = DEFAULT_DEVIATION;
//                    }

                    int deviation = [ConfigManager getBalanceDeviation];
                    
                    int rescueDataTag = [[output.jsonDataDict objectForKey:PARA_RESCUE_DATA_TAG] intValue];
                    if (rescueDataTag) {
                        PPDebug(@"need data rescue");
                        [[UserService defaultService] updateAllUserInfo];
                    }
                    
                    int balance = [[output.jsonDataDict objectForKey:PARA_ACCOUNT_BALANCE] intValue];
                    int localBalance = [_accountManager getBalance];
                    if (localBalance < balance){
                        // use server balance
                        [_accountManager updateBalanceFromServer:balance];
                        PPDebug(@"<syncAccountAndItem> use server balance = %d", balance);                        
                    }
                    else if (localBalance > balance){
                        if ((localBalance - balance) <= deviation){
                            // valid range for using client balance
                            [self syncAccountBalanceToServer];                            
                            PPDebug(@"<syncAccountAndItem> use client balance = %d", localBalance);                        
                        }
                        else{
                            // maybe client is cheating, use server data
                            [_accountManager updateBalanceFromServer:balance];
                            PPDebug(@"<syncAccountAndItem> client cheating (%d)??? use server balance = %d",
                                    localBalance, balance);                        
                        }
                    }
                    else{
                        PPDebug(@"<syncAccountAndItem> no change for balance = %d", balance);                        
                    }
                    
                    NSArray* itemTypeBalanceArray = [output.jsonDataDict objectForKey:PARA_ITEMS];
                    for (NSDictionary* itemTypeBalance in itemTypeBalanceArray){
                        int itemType = [[itemTypeBalance objectForKey:PARA_ITEM_TYPE] intValue];
                        int itemAmount = [[itemTypeBalance objectForKey:PARA_ITEM_AMOUNT] intValue];                    
                        
                        // update DB
                        UserItem* item = [_itemManager findUserItemByType:itemType];
                        if (item == nil){
                            [_itemManager addNewItem:itemType amount:itemAmount];
                            PPDebug(@"<syncAccountAndItem> add client item type[%d], amount[%d]", itemType, itemAmount);
                        }
                        else{
                            if ([[item amount] intValue] < itemAmount){
                                // use server item amount
                                [item setAmount:[NSNumber numberWithInt:itemAmount]];
                                PPDebug(@"<syncAccountAndItem> update client item type[%d], amount[%d]", itemType, itemAmount);
                            }
                            else if ([[item amount] intValue] > itemAmount){
                                // use client item amount
                                [self syncItemRequest:item];
                                PPDebug(@"<syncAccountAndItem> update server item type[%d], amount[%d]", itemType, itemAmount);
                            }
                            else{
                                PPDebug(@"<syncAccountAndItem> no change for item type[%d], amount[%d]", itemType, itemAmount);
                                
                            }
                        }
                    }
                    //decrease the guess balance and add it to the account balance.
                    int awardBalance = [[output.jsonDataDict objectForKey:PARA_GUESS_BALANCE] intValue];
                    if (awardBalance != 0) {
                        PPDebug(@"<syncAccountAndItem> awardBalance=%d", awardBalance);
                        [self awardAccount:awardBalance source:AwardCoinType];
                    }
                    
                    int awardExp = [[output.jsonDataDict objectForKey:PARA_AWARD_EXP] intValue];
                    if (awardExp != 0) {
                        PPDebug(@"<syncAccountAndItem> award exp=%d", awardExp);
                        [[LevelService defaultService] awardExp:awardExp delegate:nil];
                    }
                    
                });                
            }
            else{
                PPDebug(@"<syncAccountAndItem> FAIL, resultCode = %d", output.resultCode);
            }
        });      
    });
}

- (int)rewardForShareWeibo
{
    [self chargeAccount:[ConfigManager getShareWeiboReward] source:ShareWeiboReward];
    return [ConfigManager getShareWeiboReward];
}

- (void)rewardForShareApp
{
    [self chargeAccount:[ConfigManager getShareFriendReward] source:ShareAppReward];
}

@end
