//
//  LDUserRequest.m
//  letsdate
//
//  Created by LiuX on 15/8/5.
//  Copyright © 2015年 Maitang. All rights reserved.
//

#import "LDUserRequest.h"

@implementation LDUserRequest

- (NSInteger)loginWithUserId:(NSString *)userId
                    password:(NSString *)password
                 deviceToken:(NSString *)deviceToken
                  completion:(LDRequestCompletionBlock)completionBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userid":userId, @"pwd":password, @"token":deviceToken}];
    return [self getFromPath:ACCOUNT_LOGIN params:params completion:^(id results, NSError *error) {
#if !NETWORK
        // mock result
#endif
        completionBlock(results, error);
    }];
}

- (NSInteger)registerWithPassword:(NSString *)password
                              sex:(NSString *)sex
                              age:(NSString *)age
                       completion:(LDRequestCompletionBlock)completionBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"pwd":password, @"sex":sex, @"age":age}];
    return [self getFromPath:ACCOUNT_REGIST params:params completion:completionBlock];
}


- (NSInteger)resetPassword:(NSString *)userId password:(NSString *)pwd
                completion:(LDRequestCompletionBlock)completionBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userid":userId, @"pwd":pwd}];
    return [self getFromPath:ACCOUNT_UPDATE_PWD params:params completion:completionBlock];
}

- (NSInteger)updateMyProfile:(LDUserModel *)profile
                    completion:(LDRequestCompletionBlock)completionBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[profile toDictionary]];
    return [self getFromPath:ACCOUNT_UPDATE_USER_MESSAGE params:params completion:completionBlock];
}

- (NSInteger)getMyProfile:(NSString *)userId
                 completion:(LDRequestCompletionBlock)completionBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userid":userId}];
    return [self getFromPath:ACCOUNT_GET_ME_MESSAGE params:params completion:^(id results, NSError *error) {
        // success
        if (!error) {
            if ([results isKindOfClass:[NSDictionary class]]) {
                LDUserModel *profile = [[LDUserModel alloc] initWithDictionary:results];
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

- (NSInteger)checkPay:(NSString *)userId payType:(NSString *)payType payCode:(NSString *)payCode
           completion:(LDRequestCompletionBlock)completionBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userid":userId, @"paytype":payType, @"paycode":payCode}];
    return [self getFromPath:ACCOUNT_GET_ME_MESSAGE params:params completion:completionBlock];
}

@end
