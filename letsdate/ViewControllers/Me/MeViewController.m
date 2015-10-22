//
//  MeViewController.m
//  letsdate
//
//  Created by LiuX on 15/4/15.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import "MeViewController.h"
#import "MyDetailViewController.h"

#import "LDTableViewManager.h"
#import "AppDelegate.h"
#import "LDUserModel.h"


@interface MeViewController ()<LDTableViewManagerProtocol>

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UITableView *meTableView;

@property (strong, nonatomic) LDUserModel *profile;
@property (strong, nonatomic) NSArray *itemArray;
@property (strong, nonatomic) NSArray *nextClassArray;
@property (strong, nonatomic) LDTableViewManager *tableManager;

@end

static NSString *meCellIdentifier = @"MeViewCell";

@implementation MeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.meTableView.delegate = self.tableManager;
    self.meTableView.dataSource = self.tableManager;
    
    [self setProfileView:self.profile];
}

- (LDTableViewManager *)tableManager
{
    if (!_tableManager) {
        _tableManager = [[LDTableViewManager alloc] initWithTableView:self.meTableView viewController:self itemArray:self.itemArray nextClassArray:self.nextClassArray];
    }
    return _tableManager;
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

- (NSString *)cellIdentifier
{
    return meCellIdentifier;
}

- (CGFloat)cellHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)setProfileView:(LDUserModel *)profile
{
    NSString *name = profile.alias;
    NSString *userId = profile.userid;
    NSString *avatarUrl = profile.avatar;
    
    self.avatarImageView.image = [UIImage imageWithData:[LDFileManager dataFromPath:avatarUrl]];
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
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}
/*
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemArray.count;
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:meCellIdentifier];
    cell.textLabel.text = self.itemArray[indexPath.row];
    return cell;
}

- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Class nextClass = self.nextClassArray[indexPath.row];
    UIViewController *nextVC = [[nextClass alloc] init];
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}
*/

@end

