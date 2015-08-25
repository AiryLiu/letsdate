//
//  MeViewController.m
//  letsdate
//
//  Created by LiuX on 15/4/15.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import "MeViewController.h"
#import "MyDetailViewController.h"

#import "AppDelegate.h"
#import "LDUserModel.h"

@implementation MeViewCell

- (void)prepareForReuse
{
    
}

@end


@interface MeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UITableView *meTableView;

@property (strong, nonatomic) LDUserModel *profile;
@property (strong, nonatomic) NSArray *itemArray;
@property (strong, nonatomic) NSArray *nextClassArray;

@end

static NSString *meCellIdentifier = @"MeViewCell";

@implementation MeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setProfileView:self.profile];
}

- (LDUserModel *)profile
{
    if (!_profile) {
        _profile = [LDUserModel getLocalProfile];
    }
    return _profile;
}

- (NSArray *)itemArray
{
    if (!_itemArray) {
        _itemArray = @[@"我关注的", @"最近浏览", @"设置"];
    }
    return _itemArray;
}

- (NSArray *)nextClassArray
{
    if (!_nextClassArray) {
        _nextClassArray = @[@"MyFollowViewController", @"MyVisitViewController", @"SettingViewController"];
    }
    return _nextClassArray;
}

- (Class)nextClassForRow:(NSInteger)row
{
    Class nextClass = NSClassFromString(self.nextClassArray[row]);
    return nextClass;
}

- (void)setProfileView:(LDUserModel *)profile
{
    NSString *name = profile.alias;
    NSString *userId = profile.userid;
    NSString *avatarUrl = profile.avatar;
    
    self.avatarImageView.image = [UIImage imageWithContentsOfFile:avatarUrl];
    self.nameLabel.text = name;
    self.idLabel.text = userId;
    
    NSLog(@"UserID:%@ Name:%@ AvatarURL:%@", userId, name, avatarUrl);
}

- (IBAction)logoutButtonClicked:(UIButton *)sender
{
    [LDUserModel clearLocalProfile];
    [AppDelegate showRegister];
    
}

- (IBAction)myProfileButtonClicked:(UIButton *)sender
{
    MyDetailViewController *viewController = [[MyDetailViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemArray.count;
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    MeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:meCellIdentifier];
    cell.titleLabel.text = self.itemArray[indexPath.row];
    return cell;
}

- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Class nextClass = [self nextClassForRow:indexPath.row];
    UIViewController *nextVC = [[nextClass alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

@end

