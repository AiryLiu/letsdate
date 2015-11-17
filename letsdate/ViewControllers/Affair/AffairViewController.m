//
//  AffairViewController.m
//  letsdate
//
//  Created by LiuX on 15/4/15.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import "AffairViewController.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "HpLocationManager.h"

@implementation AffairCollectionCell

- (void)setPhotoWithUrl:(NSString *)photoUrl title:(NSString *)title
{
    [self.photo sd_setImageWithURL:[NSURL URLWithString:photoUrl] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    self.title.text = title;
}

@end

static CGFloat const AffairColumn = 4.0;



@interface AffairViewController()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) UIButton *rightBarButton;

@property (nonatomic, strong) NSMutableArray *personArray;
@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSString *currentLocation;

@end

@implementation AffairViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpData];
    [self setUpViews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationDidChanged:) name:HpLocationDidChangedNotifation object:nil];
    
    [self startLocation];
    
    __weak typeof(self) weakSelf = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.currentPage = 0;
        [weakSelf requestAffairDataWithLocation:weakSelf.currentLocation pageNo:0 pageSize:12];
    }];
    
    [self.collectionView.mj_header beginRefreshing];
    
    // 上拉刷新
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.currentPage++;
        [weakSelf requestAffairDataWithLocation:weakSelf.currentLocation pageNo:weakSelf.currentPage pageSize:12];
    }];
    // 默认先隐藏footer
    self.collectionView.mj_footer.hidden = YES;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setUpData
{
    self.personArray = [@[] mutableCopy];
    self.currentLocation = @"";
    self.currentPage = 0;
}

- (void)setUpViews
{
    UIButton *rightBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBarBtn.frame = CGRectMake(0, 0, 60, 44);
    rightBarBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [rightBarBtn setTitle:@"北京" forState:UIControlStateNormal];
    [rightBarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBarBtn addTarget:self action:@selector(rightBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self setRightBarItem:rightBarBtn];
    _rightBarButton = rightBarBtn;
}

- (void)rightBarButtonClicked:(UIButton *)sender
{
    /* select location */
    [self startLocation];
}

- (void)startLocation
{
    [[HpLocationManager sharedInstance] startUpdatingLocation];
}

- (void)locationDidChanged:(NSNotification *)notification
{
    // HpLocationNotification
    if ([notification.userInfo objectForKey:@"location"]) {
        NSString *location = notification.userInfo[@"location"];
        [_rightBarButton setTitle:location forState:UIControlStateNormal];
        
        // reload data
        [self.collectionView.mj_header beginRefreshing];
    }
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.personArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"AffairCollectionCell";
    AffairCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSDictionary *person = self.personArray[indexPath.item];
    
    [cell setPhotoWithUrl:person[@"img"] title:person[@"title"]];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = floor((self.view.width-(10.0*(AffairColumn+1)))/AffairColumn);
    return CGSizeMake(width, width/3.0*4.0);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    /* selection */
    NSDictionary *person = self.personArray[indexPath.item];
    
    UIAlertView *alt = [[UIAlertView alloc] initWithTitle:@"选中" message:[NSString stringWithFormat:@"已选择%@", person[@"title"]] delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alt show];
}

#pragma mark - network
- (void)requestAffairDataWithLocation:(NSString *)location pageNo:(NSInteger)pageNo pageSize:(NSInteger)pageSize
{
    __weak typeof(self) weakSelf = self;
    
    // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 结束刷新
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
        
        NSMutableArray *resultArray = [NSMutableArray array];
        // 增加5条假数据
        for (int i = 0; i<12; i++) {
            [resultArray addObject:@{@"img":@"http://img0.tuicool.com/iyER7n6.png", @"title":@"001"}];
        }
        
        if (pageNo <= 0) {
            // refresh
            [weakSelf.personArray removeAllObjects];
            [weakSelf.personArray addObjectsFromArray:resultArray];
        } else {
            // load more
            [weakSelf.personArray addObjectsFromArray:resultArray];
        }
        
        [weakSelf.collectionView reloadData];
    });
}

@end
