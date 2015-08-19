//
//  CommonButton.m
//  FirstP2P
//
//  Created by James Zhao on 7/23/15.
//  Copyright (c) 2015 9888. All rights reserved.
//

#import "CommonButton.h"

@interface CommonButtonStateConfig : NSObject

@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat buttonScale;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, assign) CGFloat cornerRadius;

@end

@implementation CommonButtonStateConfig

- (instancetype)init
{
    self = [super init];

    if (self) {
        self.cornerRadius = -1;
        self.borderWidth = -1;
        self.buttonScale = -1;
    }

    return self;
}

@end

@interface CommonButton ()

@property (nonatomic, strong) NSMutableDictionary *stateConfigMap;

@end

@implementation CommonButton

- (NSMutableDictionary *)stateConfigMap
{
    if (!_stateConfigMap) {
        _stateConfigMap = [@{ } mutableCopy];
    }

    return _stateConfigMap;
}

- (CommonButtonStateConfig *)configForState:(UIControlState)state createIfNeeded:(BOOL)createIfNeeded
{
    CommonButtonStateConfig *config = self.stateConfigMap[@(state)];

    if (!config && createIfNeeded) {
        config = [[CommonButtonStateConfig alloc]init];
        self.stateConfigMap[@(state)] = config;
    }

    return config;
}

- (CommonButtonStateConfig *)configForState:(UIControlState)state
{
    return [self configForState:state createIfNeeded:YES];
}

#pragma mark - Setters
- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    [self updateForStateChange:self.animateStateChange];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self updateForStateChange:self.animateStateChange];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self updateForStateChange:self.animateStateChange];
}

- (void)updateForStateChange:(BOOL)animated
{
    [self changeBackgroundColorForStateChange:animated];
    [self changeBorderColorForStateChange:animated];
    [self changeScaleForStateChange:animated];
    [self changeBorderWidthForStateChange:animated];
    [self changeCornerRadiusForStateChange:animated];
}

- (void)changeScaleForStateChange:(BOOL)animated
{
    CGFloat scale = [self configForState:self.state].buttonScale;

    scale = scale < 0 ?[self configForState:UIControlStateNormal].buttonScale : scale;

    if ((scale >= 0) && ((self.transform.a != scale) && (self.transform.b != scale))) {
        if (animated) {
            [UIView animateWithDuration:self.animationDuration animations:^{
                self.transform = CGAffineTransformMakeScale(scale, scale);
            }];
        }
    }
}

- (void)changeCornerRadiusForStateChange:(BOOL)animated
{
    CGFloat radius = [self configForState:self.state].cornerRadius;

    radius = radius < 0 ?[self configForState:UIControlStateNormal].cornerRadius : radius;

    if ((radius >= 0) && (radius != self.layer.cornerRadius)) {
        if (animated) {
            [self animateLayer:self.layer from:@(self.layer.cornerRadius) to:@(radius) forKey:@"cornerRadius"];
        }

        self.layer.masksToBounds = radius > 0;
        self.layer.cornerRadius = radius;
    }
}

- (void)changeBackgroundColorForStateChange:(BOOL)animated
{
    UIColor *color = [self configForState:self.state].backgroundColor;

    color = color == nil ?[self configForState:UIControlStateNormal].backgroundColor : color;

    if ((self.layer.backgroundColor == nil) || !CGColorEqualToColor(self.layer.backgroundColor, color.CGColor)) {
        if (animated) {
            [self animateLayer:self.layer from:(id)self.layer.backgroundColor to:(id)color.CGColor forKey:@"backgroundColor"];
        }

        self.layer.backgroundColor = color.CGColor;
    }
}

- (void)changeBorderColorForStateChange:(BOOL)animated
{
    UIColor *color = [self configForState:self.state].borderColor;

    color = color == nil ?[self configForState:UIControlStateNormal].borderColor : color;

    if ((self.layer.borderColor == nil) || !CGColorEqualToColor(self.layer.borderColor, color.CGColor)) {
        if (animated) {
            [self animateLayer:self.layer from:(id)self.layer.borderColor to:(id)color.CGColor forKey:@"borderColor"];
        }

        self.layer.borderColor = color.CGColor;
    }
}

- (void)changeBorderWidthForStateChange:(BOOL)animated
{
    CGFloat width = [self configForState:self.state].borderWidth;

    width = width < 0 ?[self configForState:UIControlStateNormal].borderWidth : width;

    if ((width >= 0) && (width != self.layer.borderWidth)) {
        if (animated) {
            [self animateLayer:self.layer from:@(self.layer.borderWidth) to:@(width) forKey:@"borderWidth"];
        }

        self.layer.borderWidth = width;
    }
}

- (void)animateLayer:(CALayer *)layer from:(id)from to:(id)to forKey:(NSString *)key
{
    CABasicAnimation *animation = [CABasicAnimation animation];

    animation.fromValue = from;
    animation.toValue = to;
    animation.duration = self.animationDuration;
    [self.layer addAnimation:animation forKey:key];
}

// MARK: Configuration

- (void)loadDefaultStyles
{
    self.animationDuration = 0.1;
    self.animateStateChange = YES;
    CommonButtonStateConfig *config = [self configForState:self.state];
    config.buttonScale = 1.0;
}

- (void)overrideNibSettings
{
}

- (void)setScale:(CGFloat)scale forState:(UIControlState)state animated:(BOOL)animated
{
    CommonButtonStateConfig *config = [self configForState:state];

    config.buttonScale = scale;
    [self changeScaleForStateChange:animated];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [self setBackgroundColor:backgroundColor forState:UIControlStateNormal];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    [self setBackgroundColor:backgroundColor forState:state animated:NO];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state animated:(BOOL)animated
{
    CommonButtonStateConfig *config = [self configForState:state];

    config.backgroundColor = backgroundColor;
    [self changeBackgroundColorForStateChange:animated];
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    [self setBorderWidth:borderWidth forState:UIControlStateNormal animated:NO];
}

- (void)setBorderWidth:(CGFloat)width forState:(UIControlState)state animated:(BOOL)animated
{
    CommonButtonStateConfig *config = [self configForState:state];

    config.borderWidth = width;
    [self changeBorderWidthForStateChange:animated];
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    [self setBorderColor:borderColor forState:UIControlStateNormal animated:NO];
}

- (void)setBorderColor:(UIColor *)color forState:(UIControlState)state animated:(BOOL)animated
{
    CommonButtonStateConfig *config = [self configForState:state];

    config.borderColor = color;
    [self changeBorderColorForStateChange:animated];
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    _cornerRadius = cornerRadius;
    [self setCornerRadius:cornerRadius forState:UIControlStateNormal animated:NO];
}

- (void)setCornerRadius:(CGFloat)radius forState:(UIControlState)state animated:(BOOL)animated
{
    CommonButtonStateConfig *config = [self configForState:state];

    config.cornerRadius = radius;
    [self changeCornerRadiusForStateChange:animated];
}

// MARK: Helper

- (void)setTitleImageSpacing:(CGFloat)spacing
{
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
}

// MARK: Initializer

// Before starting debugging IBDesignables
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self) {
        [self loadDefaultStyles];
    }

    return self;
}

// Right after the object has been initialzed for IBDesignable debugging
- (void)prepareForInterfaceBuilder
{
    [super prepareForInterfaceBuilder];
    [self overrideNibSettings];
}

// Before loading from Nib
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self loadDefaultStyles];
    }

    return self;
}

// Right after the object has been loaded from Nib

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self overrideNibSettings];
}

@end