//
//  LDUserRequest.m
//  letsdate
//
//  Created by LiuX on 15/8/5.
//  Copyright © 2015年 Maitang. All rights reserved.
//

#import "LDUserRequest.h"

@implementation LDUserRequest

- (void)loginWithUserId:(NSString *)userId
               password:(NSString *)password
            deviceToken:(NSString *)deviceToken
                success:(void (^)(id results, NSError *error))successBlock
                failure:(void (^)(id results, NSError *error))failureBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userid":userId, @"pwd":password, @"token":deviceToken}];
    [LDRequest getFromPath:ACCOUNT_LOGIN params:params success:successBlock failure:failureBlock];
}

- (void)registerWithPassword:(NSString *)password
                         sex:(NSString *)sex
                         age:(NSString *)age
                     success:(void (^)(id results, NSError *error))successBlock
                     failure:(void (^)(id results, NSError *error))failureBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"pwd":password, @"sex":sex, @"age":age}];
    [LDRequest getFromPath:ACCOUNT_LOGIN params:params success:successBlock failure:failureBlock];
}

@end
