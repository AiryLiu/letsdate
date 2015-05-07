//
//  AppDelegate.h
//  letsdate
//
//  Created by LiuX on 15/4/15.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *mainWindow;

@property (strong, nonatomic) UIWindow *currentWindow;

+ (void)setCurrentWindow:(UIWindow *)currentWindow;

+ (void)swichToMainWindow;

@end

