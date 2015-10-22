//
//  MemberViewController.m
//  letsdate
//
//  Created by LiuX on 15/4/15.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import "MemberViewController.h"
#import "StoreUtil.h"

@implementation MemberViewController

- (IBAction)buyBtnClicked:(UIButton *)sender
{
    [StoreUtil buyProduct:@"chat0001"];
}

@end
