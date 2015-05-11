//
//  FCacheManager.m
//  LiCaiShi
//
//  Created by Jason on 14-2-11.
//  Copyright (c) 2014年 LiCaiShi. All rights reserved.
//

#import "CacheManager.h"

#define kLATEST_CUSTOMER_PATH_NAME                      (@"latestcustomer.plist")
#define kALL_CUSTOMER_PATH_NAME                         (@"allcustomer.plist")
#define kCOMMISSION_RECORD_PATH_NAME                    (@"commissionrecord.plist")

@interface CacheManager()
{
    NSMutableDictionary                 *_recordDic;
}
@property (nonatomic , copy)NSString *rootPath;

@property (nonatomic , copy)NSString *latestCustomerPath;

@property (nonatomic , copy)NSString *allCustomerPath;

@property (nonatomic , copy)NSString *uid;
@end

@implementation CacheManager

@synthesize rootPath;
@synthesize latestCustomerPath;
@synthesize allCustomerPath;
@synthesize uid;

static CacheManager *_instance = nil;
+ (CacheManager*)shareManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        if (!_instance) {
            _instance = [[CacheManager alloc] init];
        }
    });
    return _instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Init the disk cache
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *_path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"FPCache"];
        self.rootPath = _path;
        
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:NSFileProtectionComplete forKey:NSFileProtectionKey];
        if (![[NSFileManager defaultManager] fileExistsAtPath:_path]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:_path
                                      withIntermediateDirectories:YES
                                                       attributes:attributes
                                                            error:NULL];
        }
    }
    return self;
}

- (NSString*)uid
{
    NSString *userId = @"";//[ProfileUtil getUserInfo].userId;
    if (!userId) {
        userId = @"none";
    }
    return userId;
}

- (NSString*)latestCustomerPath
{
    return [self.rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"alluser-%@" ,  kLATEST_CUSTOMER_PATH_NAME]];
}

- (NSString*)allCustomerPath
{
    return [self.rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"alluser-%@" ,  kALL_CUSTOMER_PATH_NAME]];
}

- (NSString*)commissionRecordPath
{
    return [self.rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"alluser-%@" ,  kCOMMISSION_RECORD_PATH_NAME]];
}

/*
#pragma mark - Deals
- (void)cacheLatestCustomer:(NSArray*)customerArray;
{
    if (customerArray && customerArray.count > 0) {
        dispatch_queue_t cache = dispatch_queue_create(NULL, NULL);
        dispatch_async(cache, ^{
            [customerArray writeToFile:self.latestCustomerPath atomically:YES];
        });
#if !OS_OBJECT_USE_OBJC
        dispatch_release(cache);
#endif
    }
}

- (void)getCacheLatestCustomer:(void (^)(NSArray*))cacheBlock;
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.latestCustomerPath]){
        NSArray *customers = [NSArray arrayWithContentsOfFile:self.latestCustomerPath];
        NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:1];
        dispatch_queue_t cache = dispatch_queue_create(NULL, NULL);
        dispatch_async(cache, ^{
            for (NSDictionary *dict in customers) {
                MLatestCustomer *customer = [[MLatestCustomer alloc] initWithDictionary:dict];
                [results addObject:customer];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (cacheBlock) {
                    cacheBlock(results);
                }
            });
#if !OS_OBJECT_USE_OBJC
            dispatch_release(cache);
#endif
        });
    }else{
        if (cacheBlock) {
            cacheBlock(nil);
        }
    }
}

#pragma mark - AllCustomer
- (void)cacheAllCustomer:(NSArray*)customerArray;
{
    if (customerArray && customerArray.count > 0) {
        dispatch_queue_t cache = dispatch_queue_create(NULL, NULL);
        dispatch_async(cache, ^{
            [customerArray writeToFile:self.allCustomerPath atomically:YES];
        });
#if !OS_OBJECT_USE_OBJC
        dispatch_release(cache);
#endif
    }
}

- (void)getCacheAllCustomer:(void (^)(NSArray*))cacheBlock;
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.allCustomerPath]){
        NSArray *customers = [NSArray arrayWithContentsOfFile:self.allCustomerPath];
        NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:1];
        dispatch_queue_t cache = dispatch_queue_create(NULL, NULL);
        dispatch_async(cache, ^{
            for (NSDictionary *dict in customers) {
                MCustomerAll *customer = [[MCustomerAll alloc] initWithDictionary:dict];
                [results addObject:customer];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (cacheBlock) {
                    cacheBlock(results);
                }
            });
#if !OS_OBJECT_USE_OBJC
            dispatch_release(cache);
#endif
        });
    }else{
        if (cacheBlock) {
            cacheBlock(nil);
        }
    }
}

#pragma mark - CommissionRecord
- (void)cacheCommissionRecord:(NSArray*)recordArray
{
    if (recordArray && recordArray.count > 0) {
        dispatch_queue_t cache = dispatch_queue_create(NULL, NULL);
        dispatch_async(cache, ^{
            [recordArray writeToFile:self.commissionRecordPath atomically:YES];
        });
#if !OS_OBJECT_USE_OBJC
        dispatch_release(cache);
#endif
    }
}

- (void)getCacheCommissionRecord:(void (^)(NSArray*))cacheBlock
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.commissionRecordPath]){
        NSArray *records = [NSArray arrayWithContentsOfFile:self.commissionRecordPath];
        NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:1];
        dispatch_queue_t cache = dispatch_queue_create(NULL, NULL);
        dispatch_async(cache, ^{
            for (NSDictionary *dict in records) {
                MCommission *record = [[MCommission alloc] initWithDictionary:dict];
                [results addObject:record];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (cacheBlock) {
                    cacheBlock(results);
                }
            });
#if !OS_OBJECT_USE_OBJC
            dispatch_release(cache);
#endif
        });
    }else{
        if (cacheBlock) {
            cacheBlock(nil);
        }
    }
}
*/
#pragma mark - clear
- (void)clearCache
{
    //Caches根目录 可以清楚包括浏览器缓存在内的缓存文件
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:cachesPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:cachesPath error:NULL];
    }
    if (![[NSFileManager defaultManager] fileExistsAtPath:cachesPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:cachesPath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:NULL];
    }
}

@end
