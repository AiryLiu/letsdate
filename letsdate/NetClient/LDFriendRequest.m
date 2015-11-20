//
//  LDFriendRequest.m
//  letsdate
//
//  Created by yd on 15/11/20.
//  Copyright © 2015年 Maitang. All rights reserved.
//

#import "LDFriendRequest.h"

@implementation LDFriendRequest

- (NSInteger)getOtherProfile:(NSString *)userId otherId:(NSString *)otherId completion:(LDRequestCompletionBlock)completionBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userid":userId, @"otherid":otherId}];
    return [self getFromPath:ACCOUNT_IT_MESSAGE params:params completion:^(id results, NSError *error) {
        // success
        if (!error) {
            if ([results isKindOfClass:[NSDictionary class]]) {
                LDOtherModel *profile = [[LDOtherModel alloc] initWithDictionary:results];
                completionBlock(profile, nil);
            } else {
                NSError *error = [NSError errorWithDomain:@"LD_NET_ERROR_DATA" code:2001 userInfo:nil];
                completionBlock(nil, error);
            }
        } else {
            completionBlock(nil, error);
        }
    }];
}

- (NSInteger)followWithUserId:(NSString *)userId otherId:(NSString *)otherId
                   completion:(LDRequestCompletionBlock)completionBlock;
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userid":userId, @"peoid":otherId}];
    return [self getFromPath:ACCOUNT_AT_PEO params:params completion:completionBlock];
}

- (NSInteger)greetWithUserId:(NSString *)userId otherId:(NSString *)otherId
                  completion:(LDRequestCompletionBlock)completionBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userid":userId, @"saypeoid":otherId}];
    return [self getFromPath:ACCOUNT_SAY_HELLO params:params completion:completionBlock];
}

- (NSInteger)pullBlackWithUserId:(NSString *)userId otherId:(NSString *)otherId
                      completion:(LDRequestCompletionBlock)completionBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userid":userId, @"blackid":otherId}];
    return [self getFromPath:ACCOUNT_GET_BLACK params:params completion:completionBlock];
}



@end
