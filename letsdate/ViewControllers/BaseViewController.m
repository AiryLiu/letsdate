//
//  BaseViewController.m
//  LiCaiShi
//
//  Created by LCL on 4/17/13.
//  Copyright (c) 2013 FirstP2P. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "Common.h"

@interface BaseViewController ()

@property (nonatomic, strong) MBProgressHUD *loadingView;

@end

@implementation BaseViewController

#pragma mark -
#pragma mark life circle

- (void)dealloc
{
    DLog(@"dealloc %@", [self class]);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#efefef"];
	// Do any additional setup after loading the view.
    if (self.navigationController.viewControllers.count > 1) {
        [self setBackBarItemTarget:nil action:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNavigationTitle:(NSString *)title
{
    self.navigationItem.title = title;
}

- (void)setBackBarItemTarget:(id)target action:(SEL)action
{
    //target＋action实现定制的返回，主要用于点击返回打开菜单栏，或者返回前需要做额外的动作
    target = target?target:self;
    action = action?action:@selector(goBack:);
    [self setLeftBarItemImage:[UIImage imageNamed:@"icon_back"] target:target action:action];
}

- (void)setLeftBarItemImage:(UIImage *)image target:(id)target action:(SEL)action
{
    UIButton *btnLeft = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [btnLeft setImage:image forState:UIControlStateNormal];
    [btnLeft addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    if (IOS7_OR_LATER) {
        [btnLeft setContentEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnLeft];
    self.navigationItem.hidesBackButton = YES;
}

- (void)setLeftBarItem:(UIButton *)button
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.hidesBackButton = YES;
}

- (void)setRightBarItem:(UIButton *)button
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)goBack:(id)sender
{
    if (self.navigationController.topViewController == self) {
        if (self.navigationController.viewControllers.count>1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

+ (UIStoryboard *)mainStoryBoard
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    return storyboard;
}

@end
