//
//  LDChatModel.h
//  letsdate
//
//  Created by yd on 15/11/21.
//  Copyright © 2015年 Maitang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    LDNotReadTypeVisit,//4个
    
} LDNotReadType;

@interface LDChatModel : NSObject

@end

@interface LDMessageModel : NSObject

@property (nonatomic, strong) NSString *otherid;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *times;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)toDictionary;

@end

@interface LDChatListModel : LDMessageModel

@property (nonatomic, strong) NSString *alias;
@property (nonatomic, strong) NSString *count;

@end
