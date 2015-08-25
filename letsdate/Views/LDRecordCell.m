//
//  LDRecordCell.m
//  letsdate
//
//  Created by LiuX on 15/8/25.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import "LDRecordCell.h"

@implementation LDRecordCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass(self);
}

+ (NSString *)nibName
{
    return NSStringFromClass(self);
}

@end
