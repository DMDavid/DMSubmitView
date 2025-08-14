//
//  DMSubmitButton.m
//  SubmitView
//
//  Created by David on 16/2/22.
//  Copyright © 2016年 com.david. All rights reserved.
//

#import "DMSubmitButton.h"

@interface DMSubmitButton()

@property (nonatomic, strong) UIColor *originalBackgroundColor;
@property (nonatomic, strong) UIColor *originalBorderColor;
@property (nonatomic, assign) CGFloat originalBorderWidth;

@end

@implementation DMSubmitButton

#pragma mark - 初始化方法

+ (instancetype)createSubmitButtonWithFrame:(CGRect)frame {
    return [self createSubmitButtonWithFrame:frame configuration:nil];
}

+ (instancetype)createSubmitButtonWithFrame:(CGRect)frame 
                              configuration:(void(^)(DMSubmitButton *button))configuration {
    DMSubmitButton *button = [[DMSubmitButton alloc] initWithFrame:frame];
    if (configuration) {
        configuration(button);
    }
    return button;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
        [self setupDefaultAppearance];
    }
    return self;
}

- (void)commonInit {
    // 默认值设置
    _buttonColor = [UIColor colorWithRed:33.0/255.0 green:197.0/255.0 blue:131.0/255.0 alpha:1.0];
    _borderColor = [UIColor colorWithRed:172.0/255.0 green:172.0/255.0 blue:172.0/255.0 alpha:1.0];
    _borderWidth = 0.0;
    _cornerRadius = 0.0;
    _shadowColor = [UIColor blackColor];
    _shadowOffset = CGSizeMake(0, 2);
    _shadowRadius = 4.0;
    _shadowOpacity = 0.3;
    
    _normalBackgroundColor = _buttonColor;
    _highlightedBackgroundColor = [_buttonColor colorWithAlphaComponent:0.8];
    _disabledBackgroundColor = [UIColor lightGrayColor];
    
    _touchAnimationDuration = 0.15;
    _touchAnimationScale = 0.95;
    _touchAnimationEnabled = YES;
    
    // 保存原始值
    _originalBackgroundColor = _buttonColor;
    _originalBorderColor = _borderColor;
    _originalBorderWidth = _borderWidth;
}

- (void)setupDefaultAppearance {
    self.backgroundColor = self.buttonColor;
    self.layer.cornerRadius = self.bounds.size.height / 2;
    self.layer.masksToBounds = NO;
    
    // 设置阴影
    [self updateShadow];
    
    // 添加点击事件
    [self addTarget:self action:@selector(touchDownAction:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(touchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(touchUpOutsideAction:) forControlEvents:UIControlEventTouchUpOutside];
    [self addTarget:self action:@selector(touchCancelAction:) forControlEvents:UIControlEventTouchCancel];
}

#pragma mark - 外观设置

- (void)setupSubmitButtonColor:(UIColor *)buttonColor {
    self.buttonColor = buttonColor;
    self.normalBackgroundColor = buttonColor;
    self.highlightedBackgroundColor = [buttonColor colorWithAlphaComponent:0.8];
    self.backgroundColor = buttonColor;
}

- (void)setupSubmitButtonBorderColor:(UIColor *)borderColor {
    self.borderColor = borderColor;
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setupButtonStyleWithBackgroundColor:(UIColor *)backgroundColor
                                borderColor:(UIColor *)borderColor
                                borderWidth:(CGFloat)borderWidth {
    self.buttonColor = backgroundColor;
    self.borderColor = borderColor;
    self.borderWidth = borderWidth;
    
    self.backgroundColor = backgroundColor;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
}

- (void)updateShadow {
    self.layer.shadowColor = self.shadowColor.CGColor;
    self.layer.shadowOffset = self.shadowOffset;
    self.layer.shadowRadius = self.shadowRadius;
    self.layer.shadowOpacity = self.shadowOpacity;
}

#pragma mark - 状态控制

- (void)setHiddenSubmitButton {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderWidth = self.borderWidth > 0 ? self.borderWidth : 2.0;
    self.layer.borderColor = self.borderColor.CGColor;
}

- (void)setShowSubmitButton {
    self.hidden = NO;
    self.backgroundColor = self.buttonColor;
    self.layer.borderWidth = 0;
}

- (void)setButtonHidden:(BOOL)hidden animated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            self.alpha = hidden ? 0.0 : 1.0;
        } completion:^(BOOL finished) {
            self.hidden = hidden;
        }];
    } else {
        self.hidden = hidden;
        self.alpha = hidden ? 0.0 : 1.0;
    }
}

#pragma mark - 动画控制

- (void)performTouchAnimation {
    if (!self.touchAnimationEnabled) return;
    
    [UIView animateWithDuration:self.touchAnimationDuration / 2.0 animations:^{
        self.transform = CGAffineTransformMakeScale(self.touchAnimationScale, self.touchAnimationScale);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:self.touchAnimationDuration / 2.0 animations:^{
            self.transform = CGAffineTransformIdentity;
        }];
    }];
}

- (void)performScaleAnimation:(CGFloat)scale 
                     duration:(NSTimeInterval)duration 
                   completion:(void(^)(void))completion {
    [UIView animateWithDuration:duration 
                          delay:0 
         usingSpringWithDamping:0.7 
          initialSpringVelocity:0.3 
                        options:UIViewAnimationOptionCurveEaseInOut 
                     animations:^{
        self.transform = CGAffineTransformMakeScale(scale, scale);
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

- (void)stopAllAnimations {
    // 停止所有层动画
    [self.layer removeAllAnimations];
    
    // 重置transform
    self.transform = CGAffineTransformIdentity;
    
    // 重置bounds到原始状态
    self.layer.bounds = self.bounds;
    self.layer.frame = self.frame;
    
    // 确保按钮可见
    self.hidden = NO;
    self.alpha = 1.0;
}

#pragma mark - 事件处理

- (void)touchDownAction:(UIButton *)sender {
    if (self.touchAnimationEnabled) {
        [self performTouchAnimation];
    }
    
    if (self.highlightedBackgroundColor) {
        self.backgroundColor = self.highlightedBackgroundColor;
    }
}

- (void)touchUpInsideAction:(UIButton *)sender {
    if (self.normalBackgroundColor) {
        self.backgroundColor = self.normalBackgroundColor;
    }
}

- (void)touchUpOutsideAction:(UIButton *)sender {
    if (self.normalBackgroundColor) {
        self.backgroundColor = self.normalBackgroundColor;
    }
}

- (void)touchCancelAction:(UIButton *)sender {
    if (self.normalBackgroundColor) {
        self.backgroundColor = self.normalBackgroundColor;
    }
}

#pragma mark - 属性设置

- (void)setButtonColor:(UIColor *)buttonColor {
    _buttonColor = buttonColor;
    if (self.state == UIControlStateNormal) {
        self.backgroundColor = buttonColor;
    }
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    if (cornerRadius > 0) {
        self.layer.cornerRadius = cornerRadius;
    } else {
        self.layer.cornerRadius = self.bounds.size.height / 2;
    }
}

- (void)setShadowColor:(UIColor *)shadowColor {
    _shadowColor = shadowColor;
    [self updateShadow];
}

- (void)setShadowOffset:(CGSize)shadowOffset {
    _shadowOffset = shadowOffset;
    [self updateShadow];
}

- (void)setShadowRadius:(CGFloat)shadowRadius {
    _shadowRadius = shadowRadius;
    [self updateShadow];
}

- (void)setShadowOpacity:(CGFloat)shadowOpacity {
    _shadowOpacity = shadowOpacity;
    [self updateShadow];
}

- (void)setNormalBackgroundColor:(UIColor *)normalBackgroundColor {
    _normalBackgroundColor = normalBackgroundColor;
    if (self.state == UIControlStateNormal) {
        self.backgroundColor = normalBackgroundColor;
    }
}

- (void)setHighlightedBackgroundColor:(UIColor *)highlightedBackgroundColor {
    _highlightedBackgroundColor = highlightedBackgroundColor;
}

- (void)setDisabledBackgroundColor:(UIColor *)disabledBackgroundColor {
    _disabledBackgroundColor = disabledBackgroundColor;
    if (self.state == UIControlStateDisabled) {
        self.backgroundColor = disabledBackgroundColor;
    }
}

#pragma mark - 状态处理

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    if (enabled) {
        self.backgroundColor = self.normalBackgroundColor;
    } else {
        self.backgroundColor = self.disabledBackgroundColor;
    }
}

#pragma mark - 布局

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 更新圆角
    if (self.cornerRadius <= 0) {
        self.layer.cornerRadius = self.bounds.size.height / 2;
    }
}

@end

