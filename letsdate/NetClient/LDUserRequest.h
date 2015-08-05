//
//  LDUserRequest.h
//  letsdate
//
//  Created by LiuX on 15/8/5.
//  Copyright © 2015年 Maitang. All rights reserved.
//

#import "LDRequest.h"

@interface LDUserRequest : LDRequest

- (void)loginWithUserId:(NSString *)userId
               password:(NSString *)password
            deviceToken:(NSString *)deviceToken
                success:(void (^)(id results, NSError *error))successBlock
                failure:(void (^)(id results, NSError *error))failureBlock;

- (void)registerWithPassword:(NSString *)password
                         sex:(NSString *)sex
                         age:(NSString *)age
                     success:(void (^)(id results, NSError *error))successBlock
                     failure:(void (^)(id results, NSError *error))failureBlock;

@end
