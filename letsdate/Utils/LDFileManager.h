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

@end
