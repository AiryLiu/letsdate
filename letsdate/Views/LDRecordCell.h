//
//  LDRecordCell.h
//  letsdate
//
//  Created by LiuX on 15/8/25.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDRecordCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

+ (NSString *)reuseIdentifier;
+ (NSString *)nibName;

@end
