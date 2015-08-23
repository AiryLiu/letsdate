//
//  UIImage+Additions.m
//  letsdate
//
//  Created by AiryL on 15/8/22.
//  Copyright (c) 2015年 Maitang. All rights reserved.
//

#import "UIImage+Additions.h"

@implementation UIImage(Additions)

- (UIImage *)scaleToRatio:(CGFloat)ratio
{
    CGSize originalSize = self.size;
    CGSize targetSize = CGSizeMake(originalSize.width*ratio, originalSize.height*ratio);
    return [self scaleToSize:targetSize];
}

- (UIImage *)scaleToSize:(CGSize)size
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}

- (UIImage *)squredImage
{
    CGSize size = self.size;
    if (size.width > size.height) {
        return [self cropToSize:CGSizeMake(size.height, size.height)];
    } else {
        return [self cropToSize:CGSizeMake(size.width, size.width)];
    }
}

- (UIImage *)cropToSize:(CGSize)size
{
    CGImageRef croppedCGImage = CGImageCreateWithImageInRect(self.CGImage, CGRectMake(fabs(self.size.width-size.width)/2.0, fabs(self.size.height-size.height)/2.0, size.width, size.height));
    return [UIImage imageWithCGImage:croppedCGImage];
}

@end
