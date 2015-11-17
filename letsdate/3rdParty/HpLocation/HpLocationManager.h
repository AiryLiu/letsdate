//
//  HpLocationManager.h
//  HipuEnd
//
//  Created by qiyu on 2/28/13.
//  Copyright (c) 2013 Hipu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const HpLocationDidChangedNotifation = @"HpLocationDidChanged";

@interface HpLocationManager : NSObject

+ (id)sharedInstance;
- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;

@end
