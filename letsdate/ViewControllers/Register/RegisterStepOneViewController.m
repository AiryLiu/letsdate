//
//  RegisterStepOneViewController.m
//  letsdate
//
//  Created by LiuX on 15/5/5.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import "RegisterStepOneViewController.h"
#import "AppDelegate.h"

#import "LDUserRequest.h"
#import "UIImage+Additions.h"


static NSString *const sRegisterJump = @"sRegisterJump";
static NSString *const sRegisterChoose = @"sRegisterChoose";

@interface RegisterStepOneViewController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@property (weak, nonatomic) UIButton *currentSelection;

@end

@implementation RegisterStepOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // update profile
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton *button = sender;
        if (button.tag > 10) {
            // jump
        } else {
            // update button state
            [self updateCurrentButton:button];
            // update profile
            [self updateProfile:[NSString stringWithFormat:@"%ld", button.tag]];
        }
    }
    // set up next view controller
    if ([segue.destinationViewController isKindOfClass:[RegisterStepOneViewController class]]) {
        RegisterStepOneViewController *nextVC = segue.destinationViewController;
        nextVC.registerProfile = self.registerProfile;
        nextVC.step = self.step + 1;
    }
}

#pragma mark - update
- (void)updateCurrentButton:(UIButton *)button
{// save current choose & update button state
    if (self.currentSelection && self.currentSelection != button) {
        self.currentSelection.selected = NO;
    }
    button.selected = YES;
    self.currentSelection = button;
}

- (void)updateProfile:(NSString *)value
{
    switch (self.step) {
        case RegisterStepOne:
            self.registerProfile.current = value;
            break;
        case RegisterStepTwo:
            self.registerProfile.sexatt = value;
            break;
        case RegisterStepThree:
            self.registerProfile.bodylarge = value;
            break;
        case RegisterStepFour:
            self.registerProfile.image = value;
            break;
        default:
            break;
    }
}

- (NSString *)saveAvatar:(UIImage *)image user:(LDUserModel *)userProfile
{
    // save avatar
    NSData *imageData = UIImagePNGRepresentation(image);
    NSString *avatarPath = [LDFileManager saveData:imageData atPath:[NSString stringWithFormat:@"%@-avatar", userProfile.userid]];
    return avatarPath;
}

- (void)queryRegister
{
    [self.view showHUDLoading:@"注册中"];
    __weak typeof(self) weakSelf = self;
    // make a temp password
    self.registerProfile.pwd = [self.registerProfile tempUserPassword];
    // query register
    LDUserRequest *registerRequest = [[LDUserRequest alloc] init];
    [registerRequest registerWithPassword:self.registerProfile.pwd sex:self.registerProfile.sex age:self.registerProfile.age completion:^(id results, NSError *error) {
        if (!error) {
            // success
            NSString *userId = nil;// debug
            if ([results isKindOfClass:[NSDictionary class]]) {
                userId = [results objectForKey:@"userid"];
            }
            if (!userId) {
                [weakSelf.view hideHUDLoading];
                [weakSelf.view showHUDMessage:@"注册失败" dismissAfter:2.0];
            } else {
                weakSelf.registerProfile.userid = userId;
                [weakSelf queryLogin:weakSelf.registerProfile];
            }
            // TODO: query update user profile
            // [weakSelf queryUpdateProfile:];
        } else {
            // failed
            [weakSelf.view hideHUDLoading];
            [weakSelf.view showHUDMessage:@"注册失败" dismissAfter:2.0];
        }
    }];
}

- (void)queryLogin:(LDUserModel *)profile
{
    NSString *userId = profile.userid;
    NSString *password = profile.pwd;
    __weak typeof(self) weakSelf = self;
    LDUserRequest *loginRequest = [[LDUserRequest alloc] init];
    [loginRequest loginWithUserId:userId password:password deviceToken:@"null" completion:^(id results, NSError *error) {
        if (!error) {
            // success
            [weakSelf.view hideHUDLoading];
            // save profile
            if ([results isKindOfClass:[NSDictionary class]]) {
                // save user profile to local
                LDUserModel *profile = [[LDUserModel alloc] initWithDictionary:results];
                profile.userid = userId;
                profile.pwd = password;
                [profile saveToLocal];
                
                // save avatar
                weakSelf.registerProfile.image = [weakSelf saveAvatar:weakSelf.avatarImageView.image user:weakSelf.registerProfile];
                
                // TODO: move to queryUpdateProfile
                [LDUserModel refreshLocalProfileWithDictionary:[weakSelf.registerProfile toDictionary]];
            }
            [weakSelf.view showHUDMessage:@"登陆成功" dismissAfter:2.0 completion:^{
                [AppDelegate swichToMainWindow];
            }];
        } else {
            // failure
            [weakSelf.view hideHUDLoading];
            [weakSelf.view showHUDMessage:@"登陆失败" dismissAfter:2.0];
        }
    }];
}

#pragma mark - actions
- (IBAction)chooseAvatar:(UIButton *)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"去拍照", @"从相册选择", nil];
    [actionSheet showInView:self.view];
}

- (IBAction)skipAvatar:(UIButton *)sender
{
    // register
    
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        // camera
        [self showImagePicker:UIImagePickerControllerSourceTypeCamera];
    } else if (buttonIndex == 1) {
        // libary
        [self showImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
    } else {
        // cancel
    }
}

#pragma mark - UIImagePicker
- (void)showImagePicker:(UIImagePickerControllerSourceType)sourceType
{
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = sourceType;
        imagePicker.delegate = self;
//        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:^{
            //
        }];
    } else {
        [self.view showHUDMessage:@"暂不支持拍照" dismissAfter:2.0];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"%@", info);
    id image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    if ([image isKindOfClass:[UIImage class]]) {
        UIImage *originImage = image;
        UIImage *squredImage = [originImage squredImage];
        UIImage *scaledImage = [squredImage scaleToRatio:200.0/squredImage.size.width];
        
        self.avatarImageView.image = scaledImage;
        [self queryRegister];
    }

    [self dismissViewControllerAnimated:picker completion:^{
        // do sth
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:picker completion:^{
        // do sth
    }];
}

@end
