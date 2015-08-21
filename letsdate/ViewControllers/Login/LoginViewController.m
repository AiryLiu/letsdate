//
//  LoginViewController.m
//  letsdate
//
//  Created by LiuX on 15/5/5.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"

#import "LDUserRequest.h"
#import "LDUserModel.h"

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
    NSString *userId = self.nameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    __weak LoginViewController *weakSelf = self;
    [self.view showHUDLoading:@"加载中"];
    [LDUserRequest loginWithUserId:userId password:password deviceToken:@"null" success:^(id results, NSError *error) {
        // success
        [weakSelf.view hideHUDLoading];
        // save profile
        if ([results isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *profileDic = [results mutableCopy];
            [profileDic setObject:userId forKey:@"userid"];
            [profileDic setObject:password forKey:@"pwd"];
            [LDUserModel refreshLocalProfileWithDictionary:profileDic];
        }
        [AppDelegate swichToMainWindow];
    } failure:^(id results, NSError *error) {
        // failure
        [weakSelf.view hideHUDLoading];
    }];
}

@end
