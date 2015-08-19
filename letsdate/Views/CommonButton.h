//
//  CommonButton.h
//  FirstP2P
//
//  Created by James Zhao on 7/23/15.
//  Copyright (c) 2015 9888. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface CommonButton : UIButton

@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, assign) BOOL animateStateChange;

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

- (void)loadDefaultStyles;
- (void)overrideNibSettings;

- (void)setScale:(CGFloat)scale forState:(UIControlState)state animated:(BOOL)animated;
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state animated:(BOOL)animated;
- (void)setBorderWidth:(CGFloat)width forState:(UIControlState)state animated:(BOOL)animated;
- (void)setBorderColor:(UIColor *)color forState:(UIControlState)state animated:(BOOL)animated;
- (void)setCornerRadius:(CGFloat)radius forState:(UIControlState)state animated:(BOOL)animated;

@end
