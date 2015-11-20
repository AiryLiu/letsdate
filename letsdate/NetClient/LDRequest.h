//
//  LDRequest.h
//  letsdate
//
//  Created by LiuX on 15/4/15.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import "LDApiClient.h"

typedef void(^LDRequestCompletionBlock)(id results, NSError *error);

@interface LDRequest : NSObject

- (NSInteger)getFromPath:(NSString *)urlPath
                  params:(NSDictionary *)paramDic
              completion:(LDRequestCompletionBlock)completionBlock;

- (NSInteger)postToPath:(NSString *)urlPath
                 params:(NSDictionary *)paramDic
             completion:(LDRequestCompletionBlock)completionBlock;

@end
