//
//  LDChatRequest.h
//  letsdate
//
//  Created by yd on 15/11/21.
//  Copyright © 2015年 Maitang. All rights reserved.
//

#import "LDRequest.h"

@interface LDChatRequest : LDRequest

- (NSInteger)getChatDetail:(NSString *)userId friendId:(NSString *)friendId pageNo:(NSInteger)pageNo completion:(LDRequestCompletionBlock)completionBlock;

- (NSInteger)getChatList:(NSString *)userId completion:(LDRequestCompletionBlock)completionBlock;

- (NSInteger)getNotReadCount:(NSString *)userId completion:(LDRequestCompletionBlock)completionBlock;

- (NSInteger)changeInfoStatus:(NSArray *)infoIds completion:(LDRequestCompletionBlock)completionBlock;

@end
