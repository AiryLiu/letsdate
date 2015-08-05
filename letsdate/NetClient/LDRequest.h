//
//  LDRequest.h
//  letsdate
//
//  Created by LiuX on 15/4/15.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import "LDApiClient.h"

@interface LDRequest : NSObject

+ (NSURLSessionDataTask *)getFromPath:(NSString *)urlPath
                               params:(NSDictionary *)paramDic
                              success:(void (^)(id results, NSError *error))successBlock
                              failure:(void (^)(id results, NSError *error))failureBlock;

+ (NSURLSessionDataTask *)postToPath:(NSString *)urlPath
                              params:(NSDictionary *)paramDic
                             success:(void (^)(id results, NSError *error))successBlock
                             failure:(void (^)(id results, NSError *error))failureBlock;

@end
