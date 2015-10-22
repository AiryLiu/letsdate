//
//  StoreUtil.h
//  letsdate
//
//  Created by AiryL on 15/10/17.
//  Copyright © 2015年 Maitang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

static NSString *const StoreVerifyURLTest = @"https://sandbox.itunes.apple.com/verifyReceipt";

@interface StoreUtil : NSObject

+ (void)buyProduct:(NSString *)productID;

@end
