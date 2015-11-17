//
//  BaseViewController.h
//  LiCaiShi
//
//  Created by LCL on 13-12-5.
//  Copyright (c) 2013年 LiCaiShi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+HUD.h"

@interface BaseViewController : UIViewController<MBProgressHUDDelegate,UIGestureRecognizerDelegate>

- (void)setNavigationTitle:(NSString *)title;
- (void)setLeftBarItem:(UIButton *)button;
- (void)setRightBarItem:(UIButton *)button;

+ (UIStoryboard *)mainStoryBoard;

@end
