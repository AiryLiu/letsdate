//
//  FCacheManager.h
//  LiCaiShi
//
//  Created by Jason on 14-2-11.
//  Copyright (c) 2014年 LiCaiShi. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MProfile.h"

@interface CacheManager : NSObject
+ (CacheManager*)shareManager;

//- (void)cacheLatestCustomer:(NSArray*)customerArray;
//- (void)getCacheLatestCustomer:(void (^)(NSArray*))cacheBlock;
//
//- (void)cacheAllCustomer:(NSArray*)customerArray;
//- (void)getCacheAllCustomer:(void (^)(NSArray*))cacheBlock;
//
//- (void)cacheCommissionRecord:(NSArray*)recordArray;
//- (void)getCacheCommissionRecord:(void (^)(NSArray*))cacheBlock;

- (void)clearCache;
@end
