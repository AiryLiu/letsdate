//
//  SettingViewController.m
//  letsdate
//
//  Created by LiuX on 15/8/25.
//  Copyright © 2015年 Maitang. All rights reserved.
//

#import "SettingViewController.h"

#import "LDTableViewManager.h"
#import "LDUserModel.h"
#import "AppDelegate.h"

@interface SettingViewController ()<LDTableViewManagerProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *itemArray;
@property (strong, nonatomic) NSArray *nextClassArray;
@property (strong, nonatomic) LDTableViewManager *tableManager;

@end

@implementation SettingViewController

- (instancetype)init
{
    self = [self initWithNibName:NSStringFromClass(self.class) bundle:[NSBundle bundleForClass:self.class]];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavigationTitle:@"设置"];
    
    self.tableView.dataSource = self.tableManager;
    self.tableView.delegate = self.tableManager;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (LDTableViewManager *)tableManager
{
    if (!_tableManager) {
        _tableManager = [[LDTableViewManager alloc] initWithTableView:self.tableView viewController:self itemArray:self.itemArray nextClassArray:self.nextClassArray];
    }
    return _tableManager;
}

- (NSArray *)itemArray
{
    if (!_itemArray) {
        _itemArray = @[@"修改密码", @"黑名单", @"去评价", @"使用协议"];
    }
    return _itemArray;
}

- (NSArray *)nextClassArray
{
    if (!_nextClassArray) {
        _nextClassArray = @[@"MyVisitViewController", @"MyVisitViewController", @"WebViewController", @"WebViewController"];
    }
    return _nextClassArray;
}

- (NSString *)cellIdentifier
{
    return @"SettingCellIdentifier";
}

- (CGFloat)cellHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)configureNextViewController:(UIViewController *)viewController
{
    // set up
}

- (IBAction)logoutButtonClicked:(UIButton *)sender
{
    [LDUserModel clearLocalProfile];
    [AppDelegate showRegister];
}

@end
