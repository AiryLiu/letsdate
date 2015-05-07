//
//  LDApiClient.m
//  letsdate
//
//  Created by LiuX on 15/4/15.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import "LDApiClient.h"

@implementation LDApiClient

+ (instancetype)sharedClient {
    static LDApiClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[LDApiClient alloc] initWithBaseURL:[NSURL URLWithString:kAPIBaseUrl]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}

@end
