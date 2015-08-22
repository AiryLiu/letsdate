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
#if NETWORK
    return [[LDApiClient sharedClient] GET:urlPath parameters:paramDic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSError *error = nil;
        if ([JSON isKindOfClass:[NSDictionary class]]) {
            NSString *status = [JSON objectForKey:@"status"];
            id results = [JSON objectForKey:@"result"];
            if ([status isEqualToString:LD_QUERY_STATUS_SUCCESS]) {
                if (successBlock) {
                    successBlock(results, nil);
                }
            } else {
                error = [NSError errorWithDomain:LD_QUERY_ERROR_DOMAIN code:-1 userInfo:JSON];
            }
        } else {
            error = [NSError errorWithDomain:LD_QUERY_ERROR_DOMAIN code:-1 userInfo:JSON];
        }
        
        if (error&&failureBlock) {
            failureBlock(nil, error);
        }
        
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (failureBlock) {
            failureBlock(nil, error);
        }
    }];
#else
    if (successBlock) {
        successBlock(@{}, nil);
    }
    return nil;
#endif
}

+ (NSURLSessionDataTask *)postToPath:(NSString *)urlPath params:(NSDictionary *)paramDic success:(void (^)(id results, NSError *error))successBlock failure:(void (^)(id results, NSError *error))failureBlock
{
#if NETWORK
    return [[LDApiClient sharedClient] POST:urlPath parameters:paramDic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSError *error = nil;
        if ([JSON isKindOfClass:[NSDictionary class]]) {
            NSString *status = [JSON objectForKey:@"status"];
            id results = [JSON objectForKey:@"result"];
            if ([status isEqualToString:LD_QUERY_STATUS_SUCCESS]) {
                if (successBlock) {
                    successBlock(results, nil);
                }
            } else {
                error = [NSError errorWithDomain:LD_QUERY_ERROR_DOMAIN code:-1 userInfo:JSON];
            }
        } else {
            error = [NSError errorWithDomain:LD_QUERY_ERROR_DOMAIN code:-1 userInfo:JSON];
        }
        
        if (error&&failureBlock) {
            failureBlock(nil, error);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (failureBlock) {
            failureBlock(nil, error);
        }
    }];
#else
    if (successBlock) {
        successBlock(@{}, nil);
    }
    return nil;
#endif
}

@end
