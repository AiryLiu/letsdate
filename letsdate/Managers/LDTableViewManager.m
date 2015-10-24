//
//  LDTableViewManager.m
//  letsdate
//
//  Created by LiuX on 15/8/26.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import "LDTableViewManager.h"

@implementation LDTableViewManager

- (instancetype)initWithTableView:(UITableView *)tableView viewController:(UIViewController<LDTableViewManagerProtocol> *)viewController itemArray:(NSArray *)itemArray nextClassArray:(NSArray *)nextClassArray
{
    self = [self init];
    if (self) {
        self.tableView = tableView;
        self.viewController = viewController;
        self.itemArray = itemArray;
        self.nextClassArray = nextClassArray;
        [self initialSetUp];
    }
    return self;
}

- (void)initialSetUp
{
    [self.tableView registerClass:[self cellClass] forCellReuseIdentifier:[self cellIdentifier]];
    NSString *cellNibName = [self cellNibName];
    if (cellNibName) {
        UINib *cellNib = [UINib nibWithNibName:cellNibName bundle:[NSBundle mainBundle]];
        if (cellNib) {
            [self.tableView registerNib:cellNib forCellReuseIdentifier:[self cellIdentifier]];
        }
    }
    
    // set table header
    if ([self.viewController respondsToSelector:@selector(tableHeaderView)]) {
        self.tableView.tableHeaderView = [self.viewController tableHeaderView];
    }
}

- (Class)cellClass
{
    Class cellClass = [self.viewController respondsToSelector:@selector(cellClass)] ? [self.viewController cellClass] : [UITableViewCell class];
    return cellClass;
}

- (NSString *)cellNibName
{
    NSString *cellNibName = [self.viewController respondsToSelector:@selector(cellNibName)] ? [self.viewController cellNibName] : nil;
    return cellNibName;
}

- (NSString *)cellIdentifier
{
    NSString *cellIdentifier = [self.viewController respondsToSelector:@selector(cellIdentifier)] ? [self.viewController cellIdentifier] : @"defaultCellIdentifier";
    return cellIdentifier;
}

- (CGFloat)cellHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = [self.viewController respondsToSelector:@selector(cellHeightForRowAtIndexPath:)] ? [self.viewController cellHeightForRowAtIndexPath:indexPath] : 44;
    return cellHeight;
}

- (Class)nextClassForRow:(NSInteger)row
{
    Class nextClass = NSClassFromString(self.nextClassArray[row]);
    return nextClass;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.viewController respondsToSelector:@selector(cellHeightForRowAtIndexPath:)]) {
        return [self.viewController cellHeightForRowAtIndexPath:indexPath];
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [self cellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor whiteColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:17.0];
    }
    
    if ([self.viewController respondsToSelector:@selector(configurCell:forRowAtIndexPath:)]) {
        [self.viewController configurCell:cell forRowAtIndexPath:indexPath];
    }
    
    cell.textLabel.text = self.itemArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Class nextClass = [self nextClassForRow:indexPath.row];
    UIViewController *nextVC = [[nextClass alloc] init];
    
    if (nextVC) {
        if ([self.viewController respondsToSelector:@selector(configureNextViewController:atIndexPath:)]) {
            [self.viewController configureNextViewController:nextVC atIndexPath:indexPath];
        }
        if (self.viewController.navigationController) {
            nextVC.hidesBottomBarWhenPushed = YES;
            [self.viewController.navigationController pushViewController:nextVC animated:YES];
        } else if (self.viewController) {
            [self.viewController presentViewController:nextVC animated:YES completion:nil];
        }
    }
}

+ (UIView *)defaultTableHeaderView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
@end
