//
//  LDTableViewManager.h
//  letsdate
//
//  Created by LiuX on 15/8/26.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LDTableViewManagerProtocol <NSObject>

@optional
- (Class)cellClass;
- (NSString *)cellNibName;
- (NSString *)cellIdentifier;
- (CGFloat)cellHeightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)configurCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

- (UIView *)tableHeaderView;

- (void)configureNextViewController:(UIViewController *)viewController atIndexPath:(NSIndexPath *)indexPath;

@end

@interface LDTableViewManager : NSObject<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) UIViewController<LDTableViewManagerProtocol> *viewController;
@property (weak, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSArray *itemArray;
@property (strong, nonatomic) NSArray *nextClassArray;

- (instancetype)initWithTableView:(UITableView *)tableView viewController:(UIViewController<LDTableViewManagerProtocol> *)viewController itemArray:(NSArray *)itemArray nextClassArray:(NSArray *)nextClassArray;

+ (UIView *)defaultTableHeaderView;

@end
