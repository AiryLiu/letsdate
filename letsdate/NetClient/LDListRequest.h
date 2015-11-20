//
//  LDListRequest.h
//  letsdate
//
//  Created by yd on 15/11/20.
//  Copyright © 2015年 Maitang. All rights reserved.
//

#import "LDRequest.h"
#import "LDListItemModel.h"

@interface LDListRequest : LDRequest

- (NSInteger)getMainList:(NSInteger)pageNo area:(NSString *)area completion:(LDRequestCompletionBlock)completionBlock;

- (NSInteger)getBlackList:(NSString *)userId completion:(LDRequestCompletionBlock)completionBlock;

@end
