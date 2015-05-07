//
//  Common.h
//  LiCaiShi
//
//  Created by LCL on 13-10-22.
//  Copyright (c) 2013年 LiCaiShi. All rights reserved.
//

#ifndef LiCaiShi_Common_h
#define LiCaiShi_Common_h

#define ONLINE  0

#if ONLINE

#define kAPIBaseUrl @"https://api.firstp2p.com"

#else

#define kAPIBaseUrl @"http://lcstest.firstp2p.com"

#define FP_DEBUG                        1

#endif

//友盟key
#if ONLINE
//正式环境key
#define UmengAppKey @""
#else
//测试环境key
#define UmengAppKey @""
#endif

NSUInteger DeviceSystemMajorVersion();

#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//判断ios版本是否高于等于8.0
#define IOS8_OR_LATER (DeviceSystemMajorVersion() >= 8)

//判断ios版本是否高于等于7.0
#define IOS7_OR_LATER (DeviceSystemMajorVersion() >= 7)

//判断ios版本是否高于等于6.0
#define IOS6_OR_LATER (DeviceSystemMajorVersion() >= 6)

//判断ios版本低于6.0
#define IOS6_EARLIER (DeviceSystemMajorVersion() < 6)

//判断终端是否是iphone5式的长屏
#define IPHONE5_OR_LATER ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//屏幕宽
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

//屏幕高
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//状态栏高
#define STATUSBAR_HEIGHT 20

//导航栏高
#define NAVIGATIONBAR_HEIGHT 44

//tabBar高
#define TABBAR_HEIGHT 49

//每次拉取个数
#define PULL_COUNT                              10

#define LARGE_PULL_COUNT                        20

//notification name
#define LCSAccountDidLoginNotification          @"LCSAccountLoginNotification"
#define LCSAccountDidLogoutNotification         @"LCSAccountSignOutNotification"

#define LCSPasswordDidVerifyNotification        @"LCSPasswordDidVerifyNotification"
#define LCSGesturePasswordDidSetNotification    @"LCSGesturePasswordDidSetNotification"

#define LCSBecameActiveNotification             @"LCSBecameActiveNotification"
#define LCSResignActiveNotification             @"LCSResignActiveNotification"

#define LCSRAirMenuDidCloseNotification         @"LCSRAirMenuDidCloseNotification"
#define LCSP2PAccountRefreshNotification        @"LCSP2PAccountRefreshNotification"

#define APPID   @""

#define WXAppId @""

#define WXAppSecret @""

//客服电话
#define kServiceTelephone @""

#endif
