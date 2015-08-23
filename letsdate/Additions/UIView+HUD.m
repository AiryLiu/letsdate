//
//  UIView+HUD.m
//  letsdate
//
//  Created by LiuX on 15/5/15.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import "UIView+HUD.h"
#import "MBProgressHUD.h"

typedef enum {
    LDHUDTypeLoading = 100,
    LDHUDTypeMessage = 101
} LDHUDType;

@implementation UIView(HUD)

- (void)showHUDLoading:(NSString *)message
{
    if ([self viewWithTag:LDHUDTypeLoading]) {
        return;
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.tag = LDHUDTypeLoading;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeIndeterminate;
    if (message.length > 0) {
        hud.labelText = message;
    }
    [self addSubview:hud];
    [hud show:YES];
}

- (void)showHUDMessage:(NSString *)message
{
    [self showHUDMessage:message dismissAfter:0];
}

- (void)showHUDMessage:(NSString *)message dismissAfter:(NSInteger)after
{
    [self showHUDMessage:message dismissAfter:after completion:nil];
}

- (void)showHUDMessage:(NSString *)message dismissAfter:(NSInteger)after completion:(void(^)(void))completion
{
    if ([self viewWithTag:LDHUDTypeMessage]) {
        return;
    }
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.tag = LDHUDTypeMessage;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    if (message.length > 0) {
        hud.labelText = message;
    }
    [self addSubview:hud];
    [hud show:YES];
    
    if (after > 0) {
        [hud hide:YES afterDelay:after];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(after * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (completion) {
                completion();
            }
        });
    }
}

- (void)hideHUDLoading
{
    UIView *hud = [self viewWithTag:LDHUDTypeLoading];
    if (hud && [hud isKindOfClass:[MBProgressHUD class]]) {
        [(MBProgressHUD *)hud hide:YES];
    }
}

- (void)hideHUDMessage
{
    UIView *hud = [self viewWithTag:LDHUDTypeMessage];
    if (hud && [hud isKindOfClass:[MBProgressHUD class]]) {
        [(MBProgressHUD *)hud hide:YES];
    }
}

@end
