//
//  LDFileManager.h
//  letsdate
//
//  Created by LiuX on 15/8/21.
//  Copyright © 2015年 Maitang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDFileManager : NSObject

+ (NSMutableDictionary *)dictionaryFromPath:(NSString *)path;

+ (void)saveDictionary:(NSDictionary *)dictionary atPath:(NSString *)path;

+ (NSData *)dataFromPath:(NSString *)path;

+ (NSString *)saveData:(NSData *)data atPath:(NSString *)path;

+ (void)deleteFileAtPath:(NSString *)path;

@end
