//
//  StoreUtil.m
//  letsdate
//
//  Created by AiryL on 15/10/17.
//  Copyright © 2015年 Maitang. All rights reserved.
//

#import "StoreUtil.h"
#import "LDRequest.h"

@interface StoreUtil()<SKProductsRequestDelegate>

@end

@implementation StoreUtil

+ (instancetype)defaultStoreKit
{
    static id defaultStoreKit = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultStoreKit = [[self alloc] init];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:defaultStoreKit];
    });
    return defaultStoreKit;
}

+ (void)buyProduct:(NSString *)productID
{
    StoreUtil *storeManager = [StoreUtil defaultStoreKit];
    if ([StoreUtil canMakePayment]) {
        [storeManager getProductInfo:productID];
    }
}

+ (BOOL)canMakePayment
{
    return [SKPaymentQueue canMakePayments];
}

- (void)getProductInfo:(NSString *)productID
{
    NSSet *set = [NSSet setWithArray:@[productID]];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
    request.delegate = self;
    [request start];
}

#pragma mark - SKProductsRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSArray *productArray = response.products;
    if (productArray.count > 0) {
        SKPayment *payment = [SKPayment paymentWithProduct:productArray[0]];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    } else {
        
    }
}

#pragma mark - SKPaymentTransactionObserver
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased://交易完成
                NSLog(@"transactionIdentifier = %@", transaction.transactionIdentifier);
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed://交易失败
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored://已经购买过该商品
//                [self restoreTransaction:transaction];
                break;
            case SKPaymentTransactionStatePurchasing:      //商品添加进列表
                NSLog(@"商品添加进列表");
                break;
            default:
                break;
        }
    }
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    // Your application should implement these two methods.
    NSString *productIdentifier = transaction.payment.productIdentifier;
    NSData *oriReceipt = transaction.transactionReceipt;
    NSData *receipt = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] appStoreReceiptURL]];
    NSString *receiptBase64 = [[NSData dataWithContentsOfURL:[[NSBundle mainBundle] appStoreReceiptURL]] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    if ([productIdentifier length] > 0) {
        // 向自己的服务器验证购买凭证
        
    }
    // Remove the transaction from the payment queue.
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
}
- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    if(transaction.error.code != SKErrorPaymentCancelled) {
        NSLog(@"购买失败");
    } else {
        NSLog(@"用户取消交易");
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void)verifyReceipt:(NSString *)receipt
{
    LDRequest *request = [[LDRequest alloc] init];
    [request postToPath:StoreVerifyURLTest params:@{@"receipt-data":receipt} completion:^(id results, NSError *error) {
        if (!error) {
            NSLog(@"Success%@", results);
        }
    }];
}

@end
