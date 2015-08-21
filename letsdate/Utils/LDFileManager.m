//
//  LDFileManager.m
//  letsdate
//
//  Created by LiuX on 15/8/21.
//  Copyright © 2015年 Maitang. All rights reserved.
//

#import "LDFileManager.h"

@implementation LDFileManager

+ (NSString *)rootPath
{
    static NSString *rootPath = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        rootPath = [documentsDirectory stringByAppendingPathComponent:@"letsdate"];
    });
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:NSFileProtectionComplete forKey:NSFileProtectionKey];
    if (![[NSFileManager defaultManager] fileExistsAtPath:rootPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:rootPath
                                  withIntermediateDirectories:YES
                                                   attributes:attributes
                                                        error:NULL];
    }
    return rootPath;
}

+ (NSMutableDictionary *)dictionaryFromPath:(NSString *)path
{
    NSString *filePath = [[self rootPath] stringByAppendingPathComponent:path];//@"Profile-Set.plist"
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath] ) {
        return [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    }
    return nil;
}

+ (void)saveDictionary:(NSDictionary *)dictionary atPath:(NSString *)path
{
    NSString *filePath = [[self rootPath] stringByAppendingPathComponent:path];
    [dictionary writeToFile:filePath atomically:YES];
}

@end
