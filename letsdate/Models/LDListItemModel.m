//
//  LDListItemModel.m
//  letsdate
//
//  Created by yd on 15/11/20.
//  Copyright © 2015年 Maitang. All rights reserved.
//

#import "LDListItemModel.h"

@implementation LDListItemModel

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        if(![dict[@"userid"] isKindOfClass:[NSNull class]]){
            self.userid = dict[@"userid"];
        }
        if(![dict[@"alias"] isKindOfClass:[NSNull class]]){
            self.alias = dict[@"alias"];
        }
        if(![dict[@"image"] isKindOfClass:[NSNull class]]){
            self.image = dict[@"image"];
        }
    }
    return self;
}

- (NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.userid != nil){
        dictionary[@"userid"] = self.userid;
    }
    if(self.alias != nil){
        dictionary[@"alias"] = self.alias;
    }
    if(self.image != nil){
        dictionary[@"image"] = self.image;
    }
    return dictionary;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", [self toDictionary]];
}

@end


@implementation LDMainListItemModel

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super initWithDictionary:dict];
    if (self) {
        if ([dict[@"age"] isKindOfClass:[NSNull class]]) {
            self.age = dict[@"age"];
        }
    }
    return self;
}

- (NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionaryWithDictionary:[super toDictionary]];
    if(self.age != nil){
        dictionary[@"age"] = self.age;
    }
    return dictionary;
}

@end
