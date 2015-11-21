//
//  LDChatModel.m
//  letsdate
//
//  Created by yd on 15/11/21.
//  Copyright © 2015年 Maitang. All rights reserved.
//

#import "LDChatModel.h"

@implementation LDChatModel

@end

@implementation LDMessageModel

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        if(![dict[@"otherid"] isKindOfClass:[NSNull class]]){
            self.otherid = dict[@"otherid"];
        }
        if(![dict[@"message"] isKindOfClass:[NSNull class]]){
            self.message = dict[@"message"];
        }
        if(![dict[@"image"] isKindOfClass:[NSNull class]]){
            self.image = dict[@"image"];
        }
        if(![dict[@"times"] isKindOfClass:[NSNull class]]){
            self.times = dict[@"times"];
        }
    }
    return self;
}

- (NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.otherid != nil){
        dictionary[@"otherid"] = self.otherid;
    }
    if(self.message != nil){
        dictionary[@"message"] = self.message;
    }
    if(self.image != nil){
        dictionary[@"image"] = self.image;
    }
    if(self.times != nil){
        dictionary[@"times"] = self.times;
    }
    return dictionary;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", [self toDictionary]];
}

@end


@implementation LDChatListModel

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super initWithDictionary:dict];
    if (self) {
        if(![dict[@"alias"] isKindOfClass:[NSNull class]]){
            self.alias = dict[@"alias"];
        }
        if(![dict[@"count"] isKindOfClass:[NSNull class]]){
            self.count = dict[@"count"];
        }
    }
    return self;
}

- (NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.alias != nil){
        dictionary[@"alias"] = self.alias;
    }
    if(self.count != nil){
        dictionary[@"count"] = self.count;
    }
    return dictionary;
}

@end