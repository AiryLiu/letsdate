//
//  LDApiClient.h
//  letsdate
//
//  Created by LiuX on 15/4/15.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "ClientConfigure.h"

@interface LDApiClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
