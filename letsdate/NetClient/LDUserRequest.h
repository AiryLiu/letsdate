//
//  LDUserRequest.h
//  letsdate
//
//  Created by LiuX on 15/8/5.
//  Copyright © 2015年 Maitang. All rights reserved.
//

#import "LDRequest.h"
#import "LDUserModel.h"

@interface LDUserRequest : LDRequest

- (NSInteger)loginWithUserId:(NSString *)userId
                    password:(NSString *)password
                 deviceToken:(NSString *)deviceToken
                  completion:(LDRequestCompletionBlock)completionBlock;

- (NSInteger)registerWithPassword:(NSString *)password
                              sex:(NSString *)sex
                              age:(NSString *)age
                       completion:(LDRequestCompletionBlock)completionBlock;

- (NSInteger)resetPassword:(NSString *)userId password:(NSString *)pwd
                completion:(LDRequestCompletionBlock)completionBlock;

- (NSInteger)updateMyProfile:(LDUserModel *)profile
                    completion:(LDRequestCompletionBlock)completionBlock;

- (NSInteger)getMyProfile:(NSString *)userId
                 completion:(LDRequestCompletionBlock)completionBlock;
@end
