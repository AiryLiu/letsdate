//
//  AffairViewController.h
//  letsdate
//
//  Created by LiuX on 15/4/15.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import "BaseViewController.h"

@interface AffairCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *title;

- (void)setPhotoWithUrl:(NSString *)photoUrl title:(NSString *)title;

@end



@interface AffairViewController : BaseViewController

@end
