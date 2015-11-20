//
//  LDFriendRequest.h
//  letsdate
//
//  Created by yd on 15/11/20.
//  Copyright © 2015年 Maitang. All rights reserved.
//

#import "LDRequest.h"
#import "LDUserModel.h"

@interface LDFriendRequest : LDRequest

- (NSInteger)getOtherProfile:(NSString *)userId otherId:(NSString *)otherId
                 completion:(LDRequestCompletionBlock)completionBlock;

- (NSInteger)followWithUserId:(NSString *)userId otherId:(NSString *)otherId
                  completion:(LDRequestCompletionBlock)completionBlock;

- (NSInteger)greetWithUserId:(NSString *)userId otherId:(NSString *)otherId
                  completion:(LDRequestCompletionBlock)completionBlock;

- (NSInteger)pullBlackWithUserId:(NSString *)userId otherId:(NSString *)otherId
                  completion:(LDRequestCompletionBlock)completionBlock;
@end
