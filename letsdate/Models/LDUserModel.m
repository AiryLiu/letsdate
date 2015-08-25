//
//  LDUserModel.m
//  letsdate
//
//  Created by LiuX on 15/8/21.
//  Copyright © 2015年 Maitang. All rights reserved.
//

#import "LDUserModel.h"

static NSString *const LDProfilePath = @"ld-profile.plist";

@interface LDUserModel ()

@end

@implementation LDUserModel
/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        [self refreshWithDictionary:dictionary];
    }
    return self;
}
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.userid != nil){
        dictionary[@"userid"] = self.userid;
    }
    if(self.pwd != nil){
        dictionary[@"pwd"] = self.pwd;
    }
    if(self.sex != nil){
        dictionary[@"sex"] = self.sex;
    }
    if(self.age != nil){
        dictionary[@"age"] = self.age;
    }
    if(self.current != nil){
        dictionary[@"current"] = self.current;
    }
    if(self.alias != nil){
        dictionary[@"alias"] = self.alias;
    }
    if(self.bodylarge != nil){
        dictionary[@"bodylarge"] = self.bodylarge;
    }
    if(self.datingrequir != nil){
        dictionary[@"datingrequir"] = self.datingrequir;
    }
    if(self.feeling != nil){
        dictionary[@"feeling"] = self.feeling;
    }
    if(self.interest != nil){
        dictionary[@"interest"] = self.interest;
    }
    if(self.liketype != nil){
        dictionary[@"liketype"] = self.liketype;
    }
    if(self.sexatt != nil){
        dictionary[@"sexatt"] = self.sexatt;
    }
    if(self.memessage != nil){
        dictionary[@"memessage"] = self.memessage;
    }
    if(self.city != nil){
        dictionary[@"city"] = self.city;
    }
    if(self.avatar != nil){
        dictionary[@"avatar"] = self.avatar;
    }
    if(self.vip != nil){
        dictionary[@"vip"] = self.vip;
    }
    if(self.fivestart != nil){
        dictionary[@"fivestart"] = self.fivestart;
    }
    return dictionary;
    
}

- (NSString *)tempUserPassword
{
    // 随机数
    return @"000000";
}

@end

@implementation LDUserModel (Archive)

+ (instancetype)getLocalProfile
{
    NSMutableDictionary *profileDic = [LDFileManager dictionaryFromPath:LDProfilePath];
    id profile = nil;
    if (profileDic) {
        profile = [[self alloc] initWithDictionary:profileDic];
    }
    return profile;
}

+ (BOOL)isUserLogin
{
    id profile = [self getLocalProfile];
    if (profile) {
        return YES;
    }
    return NO;
}

+ (void)refreshLocalProfileWithDictionary:(NSDictionary *)dictionary
{
    id profile = [self getLocalProfile];
    [profile refreshWithDictionary:dictionary];
    [profile saveToLocal];
}

- (void)saveToLocal
{
    NSDictionary *profileDic = [self toDictionary];
    [LDFileManager saveDictionary:profileDic atPath:LDProfilePath];
}

+ (void)clearLocalProfile
{
    [LDFileManager deleteFileAtPath:LDProfilePath];
}

- (void)refreshWithDictionary:(NSDictionary *)dictionary
{
    if(![dictionary[@"userid"] isKindOfClass:[NSNull class]]){
        self.userid = dictionary[@"userid"];
    }
    if(![dictionary[@"pwd"] isKindOfClass:[NSNull class]]){
        self.pwd = dictionary[@"pwd"];
    }
    if(![dictionary[@"sex"] isKindOfClass:[NSNull class]]){
        self.sex = dictionary[@"sex"];
    }
    if(![dictionary[@"age"] isKindOfClass:[NSNull class]]){
        self.age = dictionary[@"age"];
    }
    if(![dictionary[@"current"] isKindOfClass:[NSNull class]]){
        self.current = dictionary[@"current"];
    }
    if(![dictionary[@"alias"] isKindOfClass:[NSNull class]]){
        self.alias = dictionary[@"alias"];
    }
    if(![dictionary[@"bodylarge"] isKindOfClass:[NSNull class]]){
        self.bodylarge = dictionary[@"bodylarge"];
    }
    if(![dictionary[@"datingrequir"] isKindOfClass:[NSNull class]]){
        self.datingrequir = dictionary[@"datingrequir"];
    }
    if(![dictionary[@"feeling"] isKindOfClass:[NSNull class]]){
        self.feeling = dictionary[@"feeling"];
    }
    if(![dictionary[@"interest"] isKindOfClass:[NSNull class]]){
        self.interest = dictionary[@"interest"];
    }
    if(![dictionary[@"liketype"] isKindOfClass:[NSNull class]]){
        self.liketype = dictionary[@"liketype"];
    }
    if(![dictionary[@"sexatt"] isKindOfClass:[NSNull class]]){
        self.sexatt = dictionary[@"sexatt"];
    }
    if(![dictionary[@"memessage"] isKindOfClass:[NSNull class]]){
        self.memessage = dictionary[@"memessage"];
    }
    if(![dictionary[@"city"] isKindOfClass:[NSNull class]]){
        self.city = dictionary[@"city"];
    }
    if(![dictionary[@"avatar"] isKindOfClass:[NSNull class]]){
        self.avatar = dictionary[@"avatar"];
    }
    if(![dictionary[@"vip"] isKindOfClass:[NSNull class]]){
        self.vip = dictionary[@"vip"];
    }
    if(![dictionary[@"fivestart"] isKindOfClass:[NSNull class]]){
        self.fivestart = dictionary[@"fivestart"];
    }
}

@end
