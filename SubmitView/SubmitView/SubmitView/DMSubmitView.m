//
//  DMSubmitView.m
//  SubmitView
//
//  Created by David on 16/2/19.
//  Copyright © 2016年 com.david. All rights reserved.
//

#import "DMSubmitView.h"
#import "DMSubmitButton.h"
#import "DMSubmitLabel.h"
#import "DMProgressView.h"

@interface DMSubmitView () <DMProgressViewDelegate>

@property (nonatomic, strong) DMSubmitButton *submitButton;
@property (nonatomic, strong) DMSubmitLabel *showLabel;
@property (nonatomic, strong) DMProgressView *progressView;

@property (nonatomic, assign) CGRect originRect;
@property (nonatomic, assign) CGPoint viewCenter;

@property (nonatomic, assign, readwrite) CGFloat currentProgressFloat;
@property (nonatomic, assign, readwrite) CGFloat totalProgressFloat;
@property (nonatomic, assign, readwrite) BOOL isShowingProgress;
@property (nonatomic, assign, readwrite) BOOL isCompleted;

@end

@implementation DMSubmitView

#pragma mark - 初始化方法

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame configuration:nil];
}

- (instancetype)initWithFrame:(CGRect)frame 
                configuration:(void(^)(DMSubmitView *submitView))configuration {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
        if (configuration) {
            configuration(self);
        }
        [self setupSubViews];
    }
    return self;
}

- (void)commonInit {
    _originRect = self.bounds;
    _viewCenter = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    
    // 默认值设置
    _buttonColor = [UIColor colorWithRed:33.0/255.0 green:197.0/255.0 blue:131.0/255.0 alpha:1.0];
    _borderColor = [UIColor colorWithRed:172.0/255.0 green:172.0/255.0 blue:172.0/255.0 alpha:1.0];
    _borderWidth = 0.0;
    _cornerRadius = 0.0;
    _shadowColor = [UIColor blackColor];
    _shadowOffset = CGSizeMake(0, 2);
    _shadowRadius = 4.0;
    _shadowOpacity = 0.3;
    
    _buttonText = @"Submit";
    _buttonTextColor = [UIColor whiteColor];
    _buttonTextFont = [UIFont systemFontOfSize:17];
    _completionText = @"";
    _completionTextColor = [UIColor whiteColor];
    
    _progressColor = [UIColor colorWithRed:33.0/255.0 green:197.0/255.0 blue:131.0/255.0 alpha:1.0];
    _progressTrackColor = [UIColor colorWithRed:172.0/255.0 green:172.0/255.0 blue:172.0/255.0 alpha:1.0];
    _progressLineWidth = 3.0;
    _progressRadius = 0.0;
    _showsProgressTrack = YES;
    
    _scaleAnimationDuration = 1.0;
    _expandAnimationDuration = 1.0;
    _animated = YES;
    
    _currentProgressFloat = 0.0;
    _totalProgressFloat = 1.0;
    _isShowingProgress = NO;
    _isCompleted = NO;
}

- (void)setupSubViews {
    // 创建提交按钮
    self.submitButton = [DMSubmitButton createSubmitButtonWithFrame:self.bounds configuration:^(DMSubmitButton *button) {
        button.buttonColor = self.buttonColor;
        button.borderColor = self.borderColor;
        button.borderWidth = self.borderWidth;
        button.cornerRadius = self.cornerRadius;
        button.shadowColor = self.shadowColor;
        button.shadowOffset = self.shadowOffset;
        button.shadowRadius = self.shadowRadius;
        button.shadowOpacity = self.shadowOpacity;
    }];
    
    [self.submitButton addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.submitButton addTarget:self action:@selector(buttonTouchDown) forControlEvents:UIControlEventTouchDown];
    [self addSubview:self.submitButton];
    
    // 创建显示标签
    self.showLabel = [DMSubmitLabel createSubmitLabelWithFrame:self.bounds configuration:^(DMSubmitLabel *label) {
        label.defaultText = self.buttonText;
        label.defaultTextColor = self.buttonTextColor;
        label.defaultFont = self.buttonTextFont;
        label.completionText = self.completionText;
        label.completionTextColor = self.completionTextColor;
    }];
    [self addSubview:self.showLabel];
}

#pragma mark - 进度控制

- (void)updateProgressViewWitCurrenthData:(CGFloat)currentData totalData:(CGFloat)totalData {
    if (!self.progressView) {
        return;
    }
    
    self.currentProgressFloat = currentData;
    self.totalProgressFloat = totalData;
    
    [self.progressView updateProgressViewWitCurrenthData:currentData totalData:totalData];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    if (!self.progressView) {
        return;
    }
    
    [self.progressView setProgress:progress animated:animated];
}

#pragma mark - 外观设置

- (void)setupSubmitViewTitle:(NSString *)title {
    self.buttonText = title;
    self.showLabel.defaultText = title;
}

- (void)setupSubmitViewFont:(UIFont *)font {
    self.buttonTextFont = font;
    self.showLabel.defaultFont = font;
}

- (void)setupSubmitViewTextColor:(UIColor *)textColor {
    self.buttonTextColor = textColor;
    self.showLabel.defaultTextColor = textColor;
}

- (void)setupSubmitViewButtonColor:(UIColor *)buttonColor {
    self.buttonColor = buttonColor;
    [self.submitButton setupSubmitButtonColor:buttonColor];
}

- (void)setupSubmitViewButtonBorderColor:(UIColor *)borderColor {
    self.borderColor = borderColor;
    [self.submitButton setupSubmitButtonBorderColor:borderColor];
}

#pragma mark - 状态控制

- (void)resetToInitialState:(BOOL)animated {
    // 立即停止所有正在进行的动画
    [self stopAllAnimations];
    
    self.isCompleted = NO;
    self.isShowingProgress = NO;
    
    if (animated) {
        [UIView animateWithDuration:0.3 animations:^{
            self.submitButton.alpha = 1.0;
            self.showLabel.alpha = 1.0;
        }];
    } else {
        self.submitButton.alpha = 1.0;
        self.showLabel.alpha = 1.0;
    }
    
    [self.submitButton setShowSubmitButton];
    [self.showLabel resetToDefaultState:animated];
    
    if (self.progressView) {
        [self.progressView removeFromSuperview];
        self.progressView = nil;
    }
    
    // 重置进度值
    self.currentProgressFloat = 0.0;
    self.totalProgressFloat = 1.0;
    
    // 确保视图状态完全重置
    self.submitButton.hidden = NO;
    self.submitButton.alpha = 1.0;
    self.showLabel.alpha = 1.0;
}

- (void)triggerCompletion:(BOOL)animated {
    if (self.isCompleted) return;
    
    self.isCompleted = YES;
    [self expandLayerAnimation];
    
    if ([self.delegate respondsToSelector:@selector(submitViewDidComplete)]) {
        [self.delegate submitViewDidComplete];
    }
}

- (void)startShowingProgress:(BOOL)animated {
    if (self.isShowingProgress) return;
    
    self.isShowingProgress = YES;
    [self drawProgressLayer];
    
    if ([self.delegate respondsToSelector:@selector(submitViewStartShowProgressViewStatus)]) {
        [self.delegate submitViewStartShowProgressViewStatus];
    }
}

- (void)stopShowingProgress:(BOOL)animated {
    if (!self.isShowingProgress) return;
    
    self.isShowingProgress = NO;
    
    if (self.progressView) {
        [self.progressView removeFromSuperview];
        self.progressView = nil;
    }
}

#pragma mark - 事件处理

- (void)buttonTouchDown {
    [self.showLabel touchDownAnimation];
}

- (void)submitBtnClick:(UIButton *)submitBtn {
    if ([self.delegate respondsToSelector:@selector(submitViewButtonDidClick)]) {
        [self.delegate submitViewButtonDidClick];
    }
    
    // 缩放动画
    [self scaleLayerAnimation];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:self.scaleAnimationDuration 
                          delay:0.0 
                        options:UIViewAnimationOptionCurveEaseInOut 
                     animations:^{
        // 隐藏标签
        weakSelf.showLabel.alpha = 0;
        [weakSelf.submitButton setHiddenSubmitButton];
    } completion:^(BOOL finished) {
        weakSelf.submitButton.hidden = YES;
        [weakSelf startShowingProgress:YES];
    }];
}

#pragma mark - 动画控制

- (void)stopAllAnimations {
    // 停止按钮的动画
    [self.submitButton stopAllAnimations];
    
    // 停止进度环的动画
    if (self.progressView) {
        [self.progressView stopAllAnimations];
    }
    
    // 停止标签的动画
    [self.showLabel stopAllAnimations];
    
    // 重置按钮的bounds到原始状态
    self.submitButton.layer.bounds = _originRect;
    self.submitButton.frame = _originRect;
    
    // 确保按钮可见
    self.submitButton.hidden = NO;
    self.submitButton.alpha = 1.0;
}

#pragma mark - 动画方法

- (void)scaleLayerAnimation {
    CABasicAnimation *anima = [CABasicAnimation animation];
    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    anima.duration = self.scaleAnimationDuration;
    anima.keyPath = @"bounds";
    anima.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, _originRect.size.height, _originRect.size.height)];
    anima.removedOnCompletion = NO;
    anima.fillMode = kCAFillModeForwards;
    [self.submitButton.layer addAnimation:anima forKey:nil];
}

- (void)expandLayerAnimation {
    [self.progressView removeFromSuperview];
    [self.submitButton setShowSubmitButton];
    [self.showLabel showCompletionAnimation:^{
        // 完成动画后的回调
    }];
    
    CABasicAnimation *anima = [CABasicAnimation animation];
    anima.duration = self.expandAnimationDuration;
    anima.keyPath = @"bounds";
    anima.toValue = [NSValue valueWithCGRect:_originRect];
    anima.removedOnCompletion = NO;
    anima.fillMode = kCAFillModeForwards;
    [self.submitButton.layer addAnimation:anima forKey:nil];
}

- (void)drawProgressLayer {
    _viewCenter = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    
    CGFloat layerWidth = self.progressLineWidth;
    CGFloat progressRadius = self.progressRadius > 0 ? self.progressRadius : self.bounds.size.height / 2;
    CGFloat progressX = self.bounds.size.width / 2 - progressRadius - layerWidth;
    CGFloat progressWH = self.bounds.size.height + 2 * layerWidth;
    CGRect progressFrame = CGRectMake(progressX, -layerWidth, progressWH, progressWH);
    
    // 创建进度环视图
    self.progressView = [[DMProgressView alloc] initWithFrame:progressFrame configuration:^(DMProgressView *progressView) {
        progressView.radius = progressRadius;
        progressView.lineWidth = layerWidth;
        progressView.progressColor = self.progressColor;
        progressView.trackColor = self.progressTrackColor;
        progressView.showsTrack = self.showsProgressTrack;
        progressView.animationDuration = 0.3;
        progressView.delegate = self;
    }];
    
    [self addSubview:self.progressView];
}

#pragma mark - DMProgressViewDelegate

- (void)progressViewCompletionCallBack {
    [self triggerCompletion:YES];
}

- (void)progressViewDidUpdateProgress:(CGFloat)progress {
    if ([self.delegate respondsToSelector:@selector(submitViewDidUpdateProgress:)]) {
        [self.delegate submitViewDidUpdateProgress:progress];
    }
}

#pragma mark - 属性设置

- (void)setButtonColor:(UIColor *)buttonColor {
    _buttonColor = buttonColor;
    [self.submitButton setupSubmitButtonColor:buttonColor];
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    [self.submitButton setupSubmitButtonBorderColor:borderColor];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    self.submitButton.borderWidth = borderWidth;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.submitButton.cornerRadius = cornerRadius;
}

- (void)setShadowColor:(UIColor *)shadowColor {
    _shadowColor = shadowColor;
    self.submitButton.shadowColor = shadowColor;
}

- (void)setShadowOffset:(CGSize)shadowOffset {
    _shadowOffset = shadowOffset;
    self.submitButton.shadowOffset = shadowOffset;
}

- (void)setShadowRadius:(CGFloat)shadowRadius {
    _shadowRadius = shadowRadius;
    self.submitButton.shadowRadius = shadowRadius;
}

- (void)setShadowOpacity:(CGFloat)shadowOpacity {
    _shadowOpacity = shadowOpacity;
    self.submitButton.shadowOpacity = shadowOpacity;
}

- (void)setButtonText:(NSString *)buttonText {
    _buttonText = buttonText;
    self.showLabel.defaultText = buttonText;
}

- (void)setButtonTextColor:(UIColor *)buttonTextColor {
    _buttonTextColor = buttonTextColor;
    self.showLabel.defaultTextColor = buttonTextColor;
}

- (void)setButtonTextFont:(UIFont *)buttonTextFont {
    _buttonTextFont = buttonTextFont;
    self.showLabel.defaultFont = buttonTextFont;
}

- (void)setCompletionText:(NSString *)completionText {
    _completionText = completionText;
    self.showLabel.completionText = completionText;
}

- (void)setCompletionTextColor:(UIColor *)completionTextColor {
    _completionTextColor = completionTextColor;
    self.showLabel.completionTextColor = completionTextColor;
}

- (void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    self.progressView.progressColor = progressColor;
}

- (void)setProgressTrackColor:(UIColor *)progressTrackColor {
    _progressTrackColor = progressTrackColor;
    self.progressView.trackColor = progressTrackColor;
}

- (void)setProgressLineWidth:(CGFloat)progressLineWidth {
    _progressLineWidth = progressLineWidth;
    self.progressView.lineWidth = progressLineWidth;
}

- (void)setProgressRadius:(CGFloat)progressRadius {
    _progressRadius = progressRadius;
    self.progressView.radius = progressRadius;
}

- (void)setShowsProgressTrack:(BOOL)showsProgressTrack {
    _showsProgressTrack = showsProgressTrack;
    self.progressView.showsTrack = showsProgressTrack;
}

#pragma mark - 布局

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _originRect = self.bounds;
    _viewCenter = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    
    // 更新子视图frame
    self.submitButton.frame = self.bounds;
    self.showLabel.frame = self.bounds;
    
    // 更新进度环位置
    if (self.progressView) {
        CGFloat layerWidth = self.progressLineWidth;
        CGFloat progressRadius = self.progressRadius > 0 ? self.progressRadius : self.bounds.size.height / 2;
        CGFloat progressX = self.bounds.size.width / 2 - progressRadius - layerWidth;
        CGFloat progressWH = self.bounds.size.height + 2 * layerWidth;
        CGRect progressFrame = CGRectMake(progressX, -layerWidth, progressWH, progressWH);
        self.progressView.frame = progressFrame;
    }
}

@end
