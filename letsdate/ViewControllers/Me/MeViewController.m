//
//  MeViewController.m
//  letsdate
//
//  Created by LiuX on 15/4/15.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import "MeViewController.h"
#import "AppDelegate.h"
#import "LDUserModel.h"

@implementation MeViewController

- (IBAction)logoutButtonClicked:(UIButton *)sender
{
    [LDUserModel clearLocalProfile];
    [AppDelegate showRegister];
    
}

@end
