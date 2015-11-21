//
//  LDChatRequest.m
//  letsdate
//
//  Created by yd on 15/11/21.
//  Copyright © 2015年 Maitang. All rights reserved.
//

#import "LDChatRequest.h"

@implementation LDChatRequest

- (NSInteger)getChatDetail:(NSString *)userId friendId:(NSString *)friendId pageNo:(NSInteger)pageNo completion:(LDRequestCompletionBlock)completionBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userid":userId, @"friendid":friendId, @"pagenum":[NSString stringWithFormat:@"%ld",pageNo]}];
    return [self getFromPath:ACCOUNT_GET_CHAT_DETAILS params:params completion:^(id results, NSError *error) {
#if !NETWORK
        // mock result
#endif
        // come list item
        if (completionBlock) {
            completionBlock(results, error);
        }
    }];
}

- (NSInteger)getChatList:(NSString *)userId completion:(LDRequestCompletionBlock)completionBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userid":userId}];
    return [self getFromPath:ACCOUNT_GET_CHAT_LIST params:params completion:^(id results, NSError *error) {
#if !NETWORK
        // mock result
#endif
        // come list item
        if (completionBlock) {
            completionBlock(results, error);
        }
    }];
}

- (NSInteger)getNotReadCount:(NSString *)userId completion:(LDRequestCompletionBlock)completionBlock
{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"userid":userId}];
    return [self getFromPath:ACCOUNT_GET_NO_READ_COUNT params:params completion:^(id results, NSError *error) {
#if !NETWORK
        // mock result
#endif
        // come list item
        if (completionBlock) {
            completionBlock(results, error);
        }
    }];
}

- (NSInteger)changeInfoStatus:(NSArray *)infoIds completion:(LDRequestCompletionBlock)completionBlock
{
    NSString *idsString = [infoIds componentsJoinedByString:@","];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:@{@"ids":idsString}];
    return [self getFromPath:ACCOUNT_GET_NO_READ_COUNT params:params completion:^(id results, NSError *error) {
#if !NETWORK
        // mock result
#endif
        // come list item
        if (completionBlock) {
            completionBlock(results, error);
        }
    }];
}


@end
