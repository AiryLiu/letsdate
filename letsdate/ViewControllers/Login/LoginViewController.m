//
//  LoginViewController.m
//  letsdate
//
//  Created by LiuX on 15/5/5.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *nameLeftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_user"]];
    nameLeftImage.frame = CGRectMake(0, 0, 44, 44);
    nameLeftImage.contentMode = UIViewContentModeCenter;
    self.nameTextField.leftView = nameLeftImage;
    self.nameTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *pwLeftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_password"]];
    pwLeftImage.frame = CGRectMake(0, 0, 44, 44);
    pwLeftImage.contentMode = UIViewContentModeCenter;
    self.passwordTextField.leftView = pwLeftImage;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    
//    [self enableLoginButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backButtonClicked:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        // back to register
    }];
}

- (IBAction)loginButtonClicked:(UIButton *)sender
{
    if ([self checkInput]) {
        [self queryLogin];
    } else {
        
    }
}

- (void)enableLoginButton
{
    if (self.nameTextField.text.length > 0 && self.passwordTextField.text.length > 0) {
        self.loginButton.enabled = YES;
    } else {
        self.loginButton.enabled = NO;
    }
}

- (BOOL)checkInput
{
    return YES;
}

- (void)queryLogin
{
    __weak LoginViewController *weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // success
        
        [AppDelegate swichToMainWindow];
        
    });
}

@end
