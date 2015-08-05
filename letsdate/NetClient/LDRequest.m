//
//  LDRequest.m
//  letsdate
//
//  Created by LiuX on 15/4/15.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import "LDRequest.h"

@implementation LDRequest

+ (NSURLSessionDataTask *)getFromPath:(NSString *)urlPath params:(NSDictionary *)paramDic success:(void (^)(id results, NSError *error))successBlock failure:(void (^)(id results, NSError *error))failureBlock
{
    return [[LDApiClient sharedClient] GET:urlPath parameters:paramDic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSArray *postsFromResponse = [JSON valueForKeyPath:@"data"];
        if (successBlock) {
            successBlock([NSArray arrayWithArray:postsFromResponse], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (failureBlock) {
            failureBlock([NSArray array], error);
        }
    }];
}

+ (NSURLSessionDataTask *)postToPath:(NSString *)urlPath params:(NSDictionary *)paramDic success:(void (^)(id results, NSError *error))successBlock failure:(void (^)(id results, NSError *error))failureBlock
{
    return [[LDApiClient sharedClient] POST:urlPath parameters:paramDic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSArray *postsFromResponse = [JSON valueForKeyPath:@"data"];
        if (successBlock) {
            successBlock([NSArray arrayWithArray:postsFromResponse], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (failureBlock) {
            failureBlock([NSArray array], error);
        }
    }];
}

@end
