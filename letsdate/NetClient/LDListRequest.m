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
    return [self getFromPath:ACCOUNT_GET_MAIN_LIST params:params completion:^(id results, NSError *error) {
#if !NETWORK
        // mock result
#endif
        if (completionBlock) {
            completionBlock(results, error);
        }
    }];
}
@end
