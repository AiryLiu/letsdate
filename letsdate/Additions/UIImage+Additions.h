//
//  UIImage+Additions.h
//  letsdate
//
//  Created by AiryL on 15/8/22.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(Additions)

- (UIImage *)scaleToRatio:(CGFloat)ratio;

- (UIImage *)scaleToSize:(CGSize)size;

- (UIImage *)squredImage;

- (UIImage *)cropToSize:(CGSize)size;

@end
