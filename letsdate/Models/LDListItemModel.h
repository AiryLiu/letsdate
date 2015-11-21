//
//  LDListItemModel.h
//  letsdate
//
//  Created by yd on 15/11/20.
//  Copyright © 2015年 Maitang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDListItemModel : NSObject

@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *alias;
@property (nonatomic, strong) NSString *image;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)toDictionary;

@end

@interface LDMainListItemModel : LDListItemModel

@property (nonatomic, strong) NSString *age;

@end

@interface LDVisitListItemModel : LDListItemModel

@property (nonatomic, strong) NSString *memessage;

@end

@interface LDComeListItemModel : LDListItemModel

@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *times;

@end