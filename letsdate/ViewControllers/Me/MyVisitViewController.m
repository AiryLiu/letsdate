//
//  MyVisitViewController.m
//  letsdate
//
//  Created by LiuX on 15/8/25.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import "MyVisitViewController.h"

#import "LDTableViewManager.h"

#import "LDRecordCell.h"

@interface MyVisitViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MyVisitViewController

- (instancetype)init
{
    self = [self initWithNibName:@"MyVisitViewController" bundle:[NSBundle mainBundle]];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavigationTitle:[self navigationBarTitle]];
    [self.tableView registerNib:[UINib nibWithNibName:[LDRecordCell nibName] bundle:[NSBundle bundleForClass:[LDRecordCell class]]] forCellReuseIdentifier:[LDRecordCell reuseIdentifier]];
    
    [self.tableView setTableHeaderView:[self tableHeaderView]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)navigationBarTitle
{
    return @"最近浏览";
}

- (UIView *)tableHeaderView
{
    return [LDTableViewManager defaultTableHeaderView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LDRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LDRecordCell class])];
    cell.nameLabel.text = [NSString stringWithFormat:@"name-%ld", indexPath.row];
    cell.detailLabel.text = [NSString stringWithFormat:@"detail-%ld", indexPath.row];
    cell.avatarImageView.image = [UIImage imageNamed:@"avatar"];
    return cell;
}

@end
