//
//  RegisterFirstViewController.m
//  letsdate
//
//  Created by LiuX on 15/5/5.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import "RegisterFirstViewController.h"

const static NSString *ages = @"16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36";

@interface RegisterFirstViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UIButton *manBtn;
@property (weak, nonatomic) IBOutlet UIButton *womanBtn;

@property (strong, nonatomic) NSArray *ageArray;
@property (strong, nonatomic) NSString *selectedAge;

@end

@implementation RegisterFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *nameLeftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_user"]];
    nameLeftImage.frame = CGRectMake(0, 0, 44, 44);
    nameLeftImage.contentMode = UIViewContentModeCenter;
    self.ageTextField.leftView = nameLeftImage;
    self.ageTextField.leftViewMode = UITextFieldViewModeAlways;
    
    __weak RegisterFirstViewController *weakSelf = self;
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.ageTextField.bottom, self.view.width, 150)];
    picker.delegate = weakSelf;
    picker.dataSource = weakSelf;
    self.ageTextField.inputView = picker;
    
    UIView *toolBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
    toolBarView.backgroundColor = [UIColor colorWithHexString:@"#000066"];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(toolBarView.width-76, 0, 60, toolBarView.height);
    doneButton.backgroundColor = [UIColor clearColor];
    doneButton.contentMode = UIViewContentModeRight;
    doneButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(doneButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [toolBarView addSubview:doneButton];
    
    self.ageTextField.inputAccessoryView = toolBarView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)ageArray
{
    if (!_ageArray) {
        _ageArray = [ages componentsSeparatedByString:@","];
    }
    return _ageArray;
}

- (void)doneButtonClicked:(UIButton *)sender
{
    // restore choice
    self.ageTextField.text = self.selectedAge;
    NSLog(@"选择年龄：%@", self.selectedAge);
    // dismiss picker
    [self.ageTextField resignFirstResponder];
}

- (IBAction)agreeBtnClicked:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    if (sender.isSelected) {
        // enable btns
    } else {
        // disable btns
    }
}

- (IBAction)didSelectSex:(UIButton *)sender
{
    if (sender == self.manBtn) {
        // 男人
    } else {
        // 女人
    }
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.ageArray.count;
}

#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 20;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.ageArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedAge = [self.ageArray objectAtIndex:row];
}
@end
