//
//  ResetPasswordViewController.m
//  letsdate
//
//  Created by LiuX on 15/8/27.
//  Copyright © 2015年 Maitang. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "LDUserModel.h"

@interface ResetPasswordViewController ()

@property (weak, nonatomic) IBOutlet UILabel *idLabel;

@property (weak, nonatomic) IBOutlet UITextField *oriPwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *curPwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *rePwdTextField;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@property (strong, nonatomic) LDUserModel *profile;

@end

@implementation ResetPasswordViewController

- (instancetype)init
{
    self = [self initWithNibName:@"ResetPasswordViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        self.profile = [LDUserModel getLocalProfile];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.idLabel.text = [NSString stringWithFormat:@"ID:%@", self.profile.userid];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)didInputAll
{
    BOOL didInputAll = (self.oriPwdTextField.text.length > 0 && self.curPwdTextField.text.length > 0 && self.rePwdTextField.text > 0);
    return didInputAll;
}

- (void)resetButtonState:(UIButton *)button enable:(BOOL)enable
{
    if (enable) {
        button.enabled = YES;
        [button setBackgroundColor:[UIColor orangeColor]];
    } else {
        button.enabled = NO;
        [button setBackgroundColor:[UIColor lightGrayColor]];
    }
}

- (void)updateSaveButton
{
    
}

- (IBAction)savePassword:(UIButton *)sender
{
    
}

@end
