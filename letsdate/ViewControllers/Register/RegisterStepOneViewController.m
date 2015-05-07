//
//  RegisterStepOneViewController.m
//  letsdate
//
//  Created by LiuX on 15/5/5.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import "RegisterStepOneViewController.h"

@interface RegisterStepOneViewController ()

@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdBtn;
@property (weak, nonatomic) IBOutlet UIButton *fourthBtn;

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

- (void)setSelectChoice:(NSInteger)choice
{
    switch (choice) {
        case 0:
            self.firstBtn.selected = YES;
            self.secondBtn.selected = NO;
            self.thirdBtn.selected = NO;
            self.fourthBtn.selected = NO;
            break;
        case 1:
            self.firstBtn.selected = NO;
            self.secondBtn.selected = YES;
            self.thirdBtn.selected = NO;
            self.fourthBtn.selected = NO;
            break;
        case 2:
            self.firstBtn.selected = NO;
            self.secondBtn.selected = NO;
            self.thirdBtn.selected = YES;
            self.fourthBtn.selected = NO;
            break;
        case 3:
            self.firstBtn.selected = NO;
            self.secondBtn.selected = NO;
            self.thirdBtn.selected = NO;
            self.fourthBtn.selected = YES;
            break;
        default:
            break;
    }
}

- (IBAction)didSelectChoice:(UIButton *)sender
{
    if (sender == self.firstBtn) {
        [self setSelectChoice:0];
    } else if (sender == self.secondBtn) {
        [self setSelectChoice:1];
    } else if (sender == self.thirdBtn) {
        [self setSelectChoice:2];
    } else if (sender == self.fourthBtn) {
        [self setSelectChoice:3];
    }
}


@end
