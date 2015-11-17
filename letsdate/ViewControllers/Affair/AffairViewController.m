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

@property (nonatomic, strong) NSMutableArray *personArray;
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation AffairViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpData];
    
    __weak typeof(self) weakSelf = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.currentPage = 0;
        [weakSelf requestAffairData:0 pageSize:12];
    }];
    
    [self.collectionView.mj_header beginRefreshing];
    
    // 上拉刷新
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.currentPage++;
        [weakSelf requestAffairData:weakSelf.currentPage pageSize:12];
    }];
    // 默认先隐藏footer
    self.collectionView.mj_footer.hidden = YES;
}

- (void)setUpData
{
    self.personArray = [@[] mutableCopy];
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
    
    NSError *error;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:person[@"img"]] options:NSDataReadingUncached error:&error];
    UIImage *image = [UIImage imageWithData:data];
    
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
- (void)requestAffairData:(NSInteger)pageNo pageSize:(NSInteger)pageSize
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
