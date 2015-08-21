//
//  LDUserRequest.m
//  letsdate
//
//  Created by LiuX on 15/8/5.
//  Copyright © 2015年 Maitang. All rights reserved.
//

#import "LDUserRequest.h"

@implementation LDUserRequest

+ (NSURLSessionDataTask *)loginWithUserId:(NSString *)userId
               password:(NSString *)password
            deviceToken:(NSString *)deviceToken
                success:(void (^)(id results, NSError *error))successBlock
                failure:(void (^)(id results, NSError *error))failureBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userid":userId, @"pwd":password, @"token":deviceToken}];
    return [LDRequest getFromPath:ACCOUNT_LOGIN params:params success:successBlock failure:failureBlock];
}

+ (NSURLSessionDataTask *)registerWithPassword:(NSString *)password
                         sex:(NSString *)sex
                         age:(NSString *)age
                     success:(void (^)(id results, NSError *error))successBlock
                     failure:(void (^)(id results, NSError *error))failureBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"pwd":password, @"sex":sex, @"age":age}];
    return [LDRequest getFromPath:ACCOUNT_REGIST params:params success:successBlock failure:failureBlock];
}

@end
