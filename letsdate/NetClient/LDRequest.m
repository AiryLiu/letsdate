//
//  LDRequest.m
//  letsdate
//
//  Created by LiuX on 15/4/15.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import "LDRequest.h"

@interface LDRequest()

@property (strong, nonatomic) NSString *path;

@end

@implementation LDRequest

- (NSInteger)getFromPath:(NSString *)urlPath params:(NSDictionary *)paramDic completion:(LDRequestCompletionBlock)completionBlock
{
    self.path = urlPath;
    NSLog(@"REQUEST:%@, %@", urlPath, paramDic);
    
#if NETWORK
    NSURLSessionDataTask *dataTask = [[LDApiClient sharedClient] GET:urlPath parameters:paramDic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSError *error = nil;
        if ([JSON isKindOfClass:[NSDictionary class]]) {
            NSString *status = [JSON objectForKey:@"status"];
            id results = [JSON objectForKey:@"result"];
            if ([status isEqualToString:LD_QUERY_STATUS_SUCCESS]) {
                if (completionBlock) {
                    completionBlock(results, nil);
                }
            } else {
                error = [NSError errorWithDomain:LD_QUERY_ERROR_DOMAIN code:-1 userInfo:JSON];
            }
        } else {
            error = [NSError errorWithDomain:LD_QUERY_ERROR_DOMAIN code:-1 userInfo:JSON];
        }
        
        if (error&&completionBlock) {
            completionBlock(nil, error);
        }
        
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (completionBlock) {
            completionBlock(nil, error);
        }
    }];
    return dataTask.taskIdentifier;
#else
    if (completionBlock) {
        completionBlock(@{}, nil);
    }
    return 0;
#endif
}

- (NSInteger)postToPath:(NSString *)urlPath params:(NSDictionary *)paramDic completion:(LDRequestCompletionBlock)completionBlock
{
    self.path = urlPath;
    
#if NETWORK
    NSURLSessionDataTask *dataTask = [[LDApiClient sharedClient] POST:urlPath parameters:paramDic success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSError *error = nil;
        if ([JSON isKindOfClass:[NSDictionary class]]) {
            NSString *status = [JSON objectForKey:@"status"];
            id results = [JSON objectForKey:@"result"];
            if ([status isEqualToString:LD_QUERY_STATUS_SUCCESS]) {
                if (completionBlock) {
                    completionBlock(results, nil);
                }
            } else {
                error = [NSError errorWithDomain:LD_QUERY_ERROR_DOMAIN code:-1 userInfo:JSON];
            }
        } else {
            error = [NSError errorWithDomain:LD_QUERY_ERROR_DOMAIN code:-1 userInfo:JSON];
        }
        
        if (error&&completionBlock) {
            completionBlock(nil, error);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (completionBlock) {
            completionBlock(nil, error);
        }
    }];
    return dataTask.taskIdentifier;
#else
    if (completionBlock) {
        completionBlock(@{}, nil);
    }
    return 0;
#endif
}

@end
