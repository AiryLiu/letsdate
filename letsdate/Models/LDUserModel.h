//
//  LDUserModel.h
//  letsdate
//
//  Created by LiuX on 15/8/21.
//  Copyright © 2015年 Maitang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDUserModel : NSObject

@property (nonatomic, strong) NSString * userid;
@property (nonatomic, strong) NSString * pwd;
@property (nonatomic, strong) NSString * age;
@property (nonatomic, strong) NSString * alias;
@property (nonatomic, strong) NSString * bodylarge;
@property (nonatomic, strong) NSString * datingrequir;
@property (nonatomic, strong) NSString * feeling;
@property (nonatomic, strong) NSString * interest;
@property (nonatomic, strong) NSString * liketype;
@property (nonatomic, strong) NSString * sexatt;
@property (nonatomic, strong) NSString * vip;
@property (nonatomic, strong) NSString * fivestart;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;

@end

@interface LDUserModel (Archive)

+ (instancetype)getLocalProfile;

+ (BOOL)isUserLogin;

+ (void)refreshLocalProfileWithDictionary:(NSDictionary *)dictionary;

- (void)saveToLocal;

- (void)refreshWithDictionary:(NSDictionary *)dictionary;

@end
