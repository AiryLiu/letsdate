//
//  LDListRequest.m
//  letsdate
//
//  Created by yd on 15/11/20.
//  Copyright © 2015年 Maitang. All rights reserved.
//

#import "LDListRequest.h"

@implementation LDListRequest

- (NSInteger)getMainList:(NSInteger)pageNo area:(NSString *)area
                 completion:(LDRequestCompletionBlock)completionBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"pagenum":[NSString stringWithFormat:@"%ld", pageNo], @"area":area}];
    return [self getFromPath:ACCOUNT_GET_MAIN_LIST params:params completion:^(id results, NSError *error) {
#if !NETWORK
        // mock result
#endif
        if (completionBlock) {
            completionBlock(results, error);
        }
    }];
}

- (NSInteger)getBlackList:(NSString *)userId completion:(LDRequestCompletionBlock)completionBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userid":userId}];
    return [self getFromPath:ACCOUNT_GET_BLACK params:params completion:^(id results, NSError *error) {
#if !NETWORK
        // mock result
#endif
        if (completionBlock) {
            completionBlock(results, error);
        }
    }];
}

- (NSInteger)latestVisitList:(NSString *)userId completion:(LDRequestCompletionBlock)completionBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userid":userId}];
    return [self getFromPath:ACCOUNT_GET_SEE_OTHER_LIST params:params completion:^(id results, NSError *error) {
#if !NETWORK
        // mock result
#endif
        // visit item
        if (completionBlock) {
            completionBlock(results, error);
        }
    }];
}

- (NSInteger)getComeList:(NSString *)userId completion:(LDRequestCompletionBlock)completionBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userid":userId}];
    return [self getFromPath:ACCOUNT_GET_COME_LIST params:params completion:^(id results, NSError *error) {
#if !NETWORK
        // mock result
#endif
        // come list item
        if (completionBlock) {
            completionBlock(results, error);
        }
    }];
}

- (NSInteger)getFollowMeList:(NSString *)userId completion:(LDRequestCompletionBlock)completionBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userid":userId}];
    return [self getFromPath:ACCOUNT_GET_AT_ME_LIST params:params completion:^(id results, NSError *error) {
#if !NETWORK
        // mock result
#endif
        // come list item
        if (completionBlock) {
            completionBlock(results, error);
        }
    }];
}

- (NSInteger)getMyFollowList:(NSString *)userId completion:(LDRequestCompletionBlock)completionBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userid":userId}];
    return [self getFromPath:ACCOUNT_GET_ME_AT_LIST params:params completion:^(id results, NSError *error) {
#if !NETWORK
        // mock result
#endif
        // visit list
        if (completionBlock) {
            completionBlock(results, error);
        }
    }];
}

@end
