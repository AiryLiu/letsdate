//
//  Common.m
//  LiCaiShi
//
//  Created by LCL on 13-10-22.
//  Copyright (c) 2013年 LiCaiShi. All rights reserved.
//

#import "Common.h"

NSUInteger DeviceSystemMajorVersion() {
    static NSUInteger _deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion]
                                       componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    });
    return _deviceSystemMajorVersion;
}