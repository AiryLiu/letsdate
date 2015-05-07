//
//  NSDictionary+Additions.h
//  LiCaiShi
//
//  Created by LCL on 4/21/13.
//  Copyright (c) 2013 FirstP2P. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Additions)

- (BOOL)boolValueForKey:(NSString *)key;
- (BOOL)boolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
- (int)intValueForKey:(NSString *)key;
- (int)intValueForKey:(NSString *)key defaultValue:(int)defaultValue;
- (time_t)timeValueForKey:(NSString *)key;
- (time_t)timeValueForKey:(NSString *)key defaultValue:(time_t)defaultValue;
- (long long)longLongValueForKey:(NSString *)key;
- (long long)longLongValueForKey:(NSString *)key defaultValue:(long long)defaultValue;
- (NSString *)stringValueForKey:(NSString *)key;
- (NSString *)stringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
- (NSDictionary *)dictionaryValueForKey:(NSString *)key;
- (NSArray *)arrayValueForKey:(NSString *)key;
- (double)doubleValueForKey:(NSString *)key;
- (double)doubleValueForKey:(NSString *)key defaultValue:(double)defaultValue;
- (float)floatValueForKey:(NSString *)key;
- (float)floatValueForKey:(NSString *)key defaultValue:(float)defaultValue;

//处理服务器端返回的float类型  注：仅精确到小数点后四位
- (NSString *)numberStringForKey:(NSString *)key;

@end
