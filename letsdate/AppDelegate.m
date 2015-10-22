//
//  AppDelegate.m
//  letsdate
//
//  Created by LiuX on 15/4/15.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "RegisterFirstViewController.h"

#import "LDUserModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // test commit
    
    if (IOS8_OR_LATER) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound categories:[NSSet set]]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound];
    }
    
    if ([launchOptions objectForKeyedSubscript:@"UIApplicationLaunchOptionsRemoteNotificationKey"]) {
        
    }
    
    // initialize
    UITabBarController *tabBarVC = [[BaseViewController mainStoryBoard] instantiateViewControllerWithIdentifier:@"MainTabBarController"];
    UIWindow *mainWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    mainWindow.rootViewController = tabBarVC;
    self.mainTabBar = tabBarVC;
    self.mainWindow = mainWindow;
    [self.mainWindow makeKeyAndVisible];
    
//    if (![LDUserModel isUserLogin]) {
//        // not login
//        [AppDelegate showRegister];
//    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - ios push
 - (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    NSLog(@"用户同意接受通知");
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"设备ID: %@", deviceToken);
    // 注册deviceToken
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"注册失败，无法获取设备ID, 具体错误: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    if (application.applicationState != UIApplicationStateActive ) {
        // 程序在后台运行中收到推送通知
        application.applicationIconBadgeNumber = 1;
    } else {
        // 程序在前台运行中收到推送通知
        application.applicationIconBadgeNumber = 0;
    }
}

+ (UITabBarController *)mainTabBar
{
    return ((AppDelegate *)[[UIApplication sharedApplication] delegate]).mainTabBar;
}

+ (void)swichToMainWindow
{
    [[self mainTabBar] dismissViewControllerAnimated:YES completion:nil];
}

+ (void)showRegister
{
    UINavigationController *registerVC = [[BaseViewController mainStoryBoard] instantiateViewControllerWithIdentifier:@"RegisterNavigationController"];
    UITabBarController *tabBar = [AppDelegate mainTabBar];
    [tabBar presentViewController:registerVC animated:YES completion:nil];
}

@end
