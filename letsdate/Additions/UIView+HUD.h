//
//  UIView+HUD.h
//  letsdate
//
//  Created by LiuX on 15/5/15.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(HUD)

- (void)showHUDLoading:(NSString *)message;

- (void)showHUDMessage:(NSString *)message;

- (void)showHUDMessage:(NSString *)message dismissAfter:(NSInteger)after;

- (void)showHUDMessage:(NSString *)message dismissAfter:(NSInteger)after completion:(void(^)(void))completion;

- (void)hideHUDLoading;

- (void)hideHUDMessage;

@end
