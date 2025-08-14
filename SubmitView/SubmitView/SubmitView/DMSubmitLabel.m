//
//  DMSubmitLabel.m
//  SubmitView
//
//  Created by David on 16/2/22.
//  Copyright © 2016年 com.david. All rights reserved.
//

#import "DMSubmitLabel.h"

@interface DMSubmitLabel()

@property (nonatomic, strong) CAShapeLayer *completionIconLayer;
@property (nonatomic, assign) BOOL isInCompletionState;

@end

@implementation DMSubmitLabel

#pragma mark - 初始化方法

+ (instancetype)createSubmitLabelWithFrame:(CGRect)frame {
    return [self createSubmitLabelWithFrame:frame configuration:nil];
}

+ (instancetype)createSubmitLabelWithFrame:(CGRect)frame 
                             configuration:(void(^)(DMSubmitLabel *label))configuration {
    DMSubmitLabel *label = [[DMSubmitLabel alloc] initWithFrame:frame];
    if (configuration) {
        configuration(label);
    }
    return label;
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
    _defaultText = @"Submit";
    _defaultTextColor = [UIColor whiteColor];
    _defaultFont = [UIFont systemFontOfSize:17];
    _completionText = @"";
    _completionTextColor = [UIColor whiteColor];
    
    _touchAnimationDuration = 0.2;
    _touchAnimationScale = 0.7;
    _touchAnimationEnabled = YES;
    _completionAnimationDuration = 1.0;
    _completionTimingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    _showsCompletionIcon = YES;
    _completionIconColor = [UIColor whiteColor];
    _completionIconLineWidth = 4.0;
    _completionIconSize = CGSizeMake(20, 20);
    
    _isInCompletionState = NO;
}

- (void)setupDefaultAppearance {
    self.text = self.defaultText;
    self.textColor = self.defaultTextColor;
    self.backgroundColor = [UIColor clearColor];
    self.font = self.defaultFont;
    self.textAlignment = NSTextAlignmentCenter;
}

#pragma mark - 动画控制

- (void)touchDownAnimation {
    if (!self.touchAnimationEnabled) return;
    
    CABasicAnimation *fontAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    fontAnimation.duration = self.touchAnimationDuration;
    fontAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    fontAnimation.fromValue = @(1.0);
    fontAnimation.toValue = @(self.touchAnimationScale);
    fontAnimation.autoreverses = YES;
    [self.layer addAnimation:fontAnimation forKey:@"textScaleAnimation"];
}

- (void)showLabelAnimation {
    // 根据completionText是否有值来决定显示方式
    if (self.completionText.length > 0) {
        // 如果有完成文本，显示文本，不显示对号图标
        self.text = self.completionText;
        self.textColor = self.completionTextColor;
        
        // 确保移除对号图标
        if (self.completionIconLayer) {
            [self.completionIconLayer removeFromSuperlayer];
            self.completionIconLayer = nil;
        }
    } else {
        // 如果没有完成文本，显示对号图标
        self.text = @"";
        if (self.showsCompletionIcon) {
            [self createCompleteAnimation];
        }
    }
    
    [self performFadeInAnimation:1.0 completion:nil];
}

- (void)showCompletionAnimation:(void(^)(void))completion {
    // 根据completionText是否有值来决定显示方式
    if (self.completionText.length > 0) {
        // 如果有完成文本，显示文本，不显示对号图标
        self.text = self.completionText;
        self.textColor = self.completionTextColor;
        
        // 确保移除对号图标
        if (self.completionIconLayer) {
            [self.completionIconLayer removeFromSuperlayer];
            self.completionIconLayer = nil;
        }
    } else {
        // 如果没有完成文本，显示对号图标
        if (self.showsCompletionIcon) {
            [self createCompleteAnimation];
        }
        
        // 清空文本
        self.text = @"";
    }
    
    [self performFadeInAnimation:self.completionAnimationDuration completion:completion];
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

- (void)performFadeInAnimation:(NSTimeInterval)duration 
                    completion:(void(^)(void))completion {
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 1.0;
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
    
    // 重置alpha
    self.alpha = 1.0;
    
    // 停止完成图标的动画
    if (self.completionIconLayer) {
        [self.completionIconLayer removeAllAnimations];
    }
}

#pragma mark - 状态控制

- (void)resetToDefaultState:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            self.text = self.defaultText;
            self.textColor = self.defaultTextColor;
            self.alpha = 1.0;
        }];
    } else {
        self.text = self.defaultText;
        self.textColor = self.defaultTextColor;
        self.alpha = 1.0;
    }
    
    // 移除完成图标
    [self.completionIconLayer removeFromSuperlayer];
    self.completionIconLayer = nil;
    self.isInCompletionState = NO;
}

- (void)setCompletionState:(BOOL)animated {
    self.isInCompletionState = YES;
    [self showCompletionAnimation:nil];
}

#pragma mark - 私有方法

- (void)createCompleteAnimation {
    if (self.completionIconLayer) {
        [self.completionIconLayer removeFromSuperlayer];
    }
    
    CGPoint centerPoint = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2 + 5);
    CGFloat margin = self.completionIconSize.width / 2;
    
    self.completionIconLayer = [CAShapeLayer layer];
    self.completionIconLayer.fillColor = [UIColor clearColor].CGColor;
    self.completionIconLayer.strokeColor = self.completionIconColor.CGColor;
    self.completionIconLayer.lineCap = kCALineCapRound;
    self.completionIconLayer.lineJoin = kCALineJoinRound;
    self.completionIconLayer.lineWidth = self.completionIconLineWidth;
    
    UIBezierPath *completePath = [UIBezierPath bezierPath];
    [completePath moveToPoint:CGPointMake(centerPoint.x - margin, centerPoint.y)];
    [completePath addLineToPoint:CGPointMake(centerPoint.x - 5, centerPoint.y + margin - 5)];
    [completePath addLineToPoint:CGPointMake(centerPoint.x + margin, centerPoint.y - margin)];
    self.completionIconLayer.path = completePath.CGPath;
    
    [self.layer addSublayer:self.completionIconLayer];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = self.completionAnimationDuration;
    pathAnimation.timingFunction = self.completionTimingFunction;
    pathAnimation.fromValue = @(0.0);
    pathAnimation.toValue = @(1.0);
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.fillMode = kCAFillModeForwards;
    [self.completionIconLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}

#pragma mark - 属性设置

- (void)setDefaultText:(NSString *)defaultText {
    _defaultText = defaultText;
    if (!self.isInCompletionState) {
        self.text = defaultText;
    }
}

- (void)setDefaultTextColor:(UIColor *)defaultTextColor {
    _defaultTextColor = defaultTextColor;
    if (!self.isInCompletionState) {
        self.textColor = defaultTextColor;
    }
}

- (void)setDefaultFont:(UIFont *)defaultFont {
    _defaultFont = defaultFont;
    self.font = defaultFont;
}

- (void)setCompletionText:(NSString *)completionText {
    _completionText = completionText;
    if (self.isInCompletionState) {
        // 在完成状态下，根据新的completionText值更新显示
        if (completionText.length > 0) {
            // 如果有完成文本，显示文本，移除对号图标
            self.text = completionText;
            self.textColor = self.completionTextColor;
            
            if (self.completionIconLayer) {
                [self.completionIconLayer removeFromSuperlayer];
                self.completionIconLayer = nil;
            }
        } else {
            // 如果没有完成文本，显示对号图标
            self.text = @"";
            if (self.showsCompletionIcon && !self.completionIconLayer) {
                [self createCompleteAnimation];
            }
        }
    }
}

- (void)setCompletionTextColor:(UIColor *)completionTextColor {
    _completionTextColor = completionTextColor;
    if (self.isInCompletionState && self.completionText.length > 0) {
        // 只有在完成状态且有完成文本时才更新颜色
        self.textColor = completionTextColor;
    }
}

- (void)setCompletionIconColor:(UIColor *)completionIconColor {
    _completionIconColor = completionIconColor;
    self.completionIconLayer.strokeColor = completionIconColor.CGColor;
}

- (void)setCompletionIconLineWidth:(CGFloat)completionIconLineWidth {
    _completionIconLineWidth = completionIconLineWidth;
    self.completionIconLayer.lineWidth = completionIconLineWidth;
}

- (void)setCompletionIconSize:(CGSize)completionIconSize {
    _completionIconSize = completionIconSize;
    // 重新创建完成图标
    if (self.isInCompletionState) {
        [self createCompleteAnimation];
    }
}

- (void)setTouchAnimationDuration:(NSTimeInterval)touchAnimationDuration {
    _touchAnimationDuration = touchAnimationDuration;
}

- (void)setTouchAnimationScale:(CGFloat)touchAnimationScale {
    _touchAnimationScale = touchAnimationScale;
}

- (void)setTouchAnimationEnabled:(BOOL)touchAnimationEnabled {
    _touchAnimationEnabled = touchAnimationEnabled;
}

- (void)setCompletionAnimationDuration:(NSTimeInterval)completionAnimationDuration {
    _completionAnimationDuration = completionAnimationDuration;
}

- (void)setCompletionTimingFunction:(CAMediaTimingFunction *)completionTimingFunction {
    _completionTimingFunction = completionTimingFunction;
}

- (void)setShowsCompletionIcon:(BOOL)showsCompletionIcon {
    _showsCompletionIcon = showsCompletionIcon;
    if (!showsCompletionIcon && self.completionIconLayer) {
        [self.completionIconLayer removeFromSuperlayer];
        self.completionIconLayer = nil;
    }
}

#pragma mark - 布局

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 更新完成图标位置
    if (self.completionIconLayer && self.isInCompletionState) {
        [self createCompleteAnimation];
    }
}

@end
