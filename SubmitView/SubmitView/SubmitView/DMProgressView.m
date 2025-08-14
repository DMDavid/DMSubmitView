//
//  DMProgressView.m
//  SubmitView
//
//  Created by David on 16/2/28.
//  Copyright © 2016年 com.david. All rights reserved.
//

#import "DMProgressView.h"

@interface DMProgressView()

@property (nonatomic, strong) CAShapeLayer *trackLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, assign) CGFloat currentProgress;
@property (nonatomic, assign) CGPoint centerPoint;

@end

@implementation DMProgressView

#pragma mark - 初始化方法

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame radius:0 lineWidth:0];
}

- (instancetype)initWithFrame:(CGRect)frame 
                       radius:(CGFloat)radius 
                    lineWidth:(CGFloat)lineWidth {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
        if (radius > 0) self.radius = radius;
        if (lineWidth > 0) self.lineWidth = lineWidth;
        [self setupLayers];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame 
                configuration:(void(^)(DMProgressView *progressView))configuration {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
        if (configuration) {
            configuration(self);
        }
        [self setupLayers];
    }
    return self;
}

- (void)commonInit {
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = NO;
    
    // 默认值设置
    _currentProgress = 0.0;
    _radius = 0;
    _lineWidth = 3.0;
    _progressColor = [UIColor colorWithRed:33.0/255.0 green:197.0/255.0 blue:131.0/255.0 alpha:1.0];
    _trackColor = [UIColor colorWithRed:172.0/255.0 green:172.0/255.0 blue:172.0/255.0 alpha:1.0];
    _showsTrack = YES;
    _startAngle = -M_PI_2; // 从顶部开始 (-90度)
    _clockwise = YES; // 顺时针方向
    _animationDuration = 0.3;
    _timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    _animated = YES;
}

- (void)setupLayers {
    // 计算中心点和半径
    [self calculateCenterAndRadius];
    
    // 创建背景环
    if (self.showsTrack) {
        [self createTrackLayer];
    }
    
    // 创建进度环
    [self createProgressLayer];
}

- (void)calculateCenterAndRadius {
    self.centerPoint = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    
    if (self.radius <= 0) {
        // 自动计算半径
        CGFloat minDimension = MIN(self.bounds.size.width, self.bounds.size.height);
        self.radius = (minDimension - self.lineWidth) / 2;
    }
}

- (void)createTrackLayer {
    self.trackLayer = [CAShapeLayer layer];
    self.trackLayer.fillColor = [UIColor clearColor].CGColor;
    self.trackLayer.strokeColor = self.trackColor.CGColor;
    self.trackLayer.lineWidth = self.lineWidth;
    self.trackLayer.lineCap = kCALineCapRound;
    self.trackLayer.path = [self createCirclePath].CGPath;
    [self.layer addSublayer:self.trackLayer];
}

- (void)createProgressLayer {
    self.progressLayer = [CAShapeLayer layer];
    self.progressLayer.fillColor = [UIColor clearColor].CGColor;
    self.progressLayer.strokeColor = self.progressColor.CGColor;
    self.progressLayer.lineWidth = self.lineWidth;
    self.progressLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:self.progressLayer];
    
    [self updateProgressPath];
}

- (UIBezierPath *)createCirclePath {
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.centerPoint
                                                        radius:self.radius
                                                    startAngle:self.startAngle
                                                      endAngle:self.startAngle + 2 * M_PI
                                                     clockwise:self.clockwise];
    return path;
}

- (void)updateProgressPath {
    // 创建完整的圆形路径，使用 strokeEnd 来控制显示进度
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.centerPoint
                                                        radius:self.radius
                                                    startAngle:self.startAngle
                                                      endAngle:self.startAngle + 2 * M_PI
                                                     clockwise:self.clockwise];
    self.progressLayer.path = path.CGPath;
    self.progressLayer.strokeEnd = self.currentProgress;
    
    // 调试信息
    NSLog(@"更新进度路径 - 中心点: (%.1f, %.1f), 半径: %.1f, 起始角度: %.2f, 当前进度: %.2f, strokeEnd: %.2f", 
          self.centerPoint.x, self.centerPoint.y, self.radius, self.startAngle, self.currentProgress, self.progressLayer.strokeEnd);
}

#pragma mark - 进度控制

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    // 限制进度值范围
    progress = MAX(0.0, MIN(1.0, progress));
    
    NSLog(@"设置进度 - 输入: %.2f, 当前: %.2f, 动画: %@", progress, _currentProgress, animated ? @"是" : @"否");
    
    if (fabs(progress - _currentProgress) < 0.001) {
        NSLog(@"进度值没有变化，跳过");
        return; // 进度值没有变化
    }
    
    CGFloat oldProgress = _currentProgress;
    _currentProgress = progress;
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(progressViewDidUpdateProgress:)]) {
        [self.delegate progressViewDidUpdateProgress:progress];
    }
    
    if (animated && self.animated) {
        [self animateProgressFrom:oldProgress to:progress];
    } else {
        [self updateProgressPath];
    }
    
    // 检查是否完成
    if (progress >= 1.0 && self.isCompleted) {
        [self handleCompletion];
    }
}

- (void)animateProgressFrom:(CGFloat)fromProgress to:(CGFloat)toProgress {
    NSLog(@"开始动画 - 从: %.2f 到: %.2f", fromProgress, toProgress);
    
    // 确保路径是完整的圆形
    [self updateProgressPath];
    
    // 创建动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = self.animationDuration;
    animation.fromValue = @(fromProgress);
    animation.toValue = @(toProgress);
    animation.timingFunction = self.timingFunction;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [self.progressLayer addAnimation:animation forKey:@"progressAnimation"];
    self.progressLayer.strokeEnd = toProgress;
    
    NSLog(@"动画设置完成 - strokeEnd: %.2f", self.progressLayer.strokeEnd);
}

- (void)handleCompletion {
    if ([self.delegate respondsToSelector:@selector(progressViewCompletionCallBack)]) {
        [self.delegate progressViewCompletionCallBack];
    }
}

- (void)updateProgressViewWitCurrenthData:(CGFloat)currentData totalData:(CGFloat)totalData {
    NSLog(@"更新进度数据 - 当前: %.2f, 总计: %.2f", currentData, totalData);
    
    if (totalData <= 0) {
        NSLog(@"总数据为0，跳过");
        return;
    }
    
    CGFloat progress = currentData / totalData;
    NSLog(@"计算进度: %.2f / %.2f = %.2f", currentData, totalData, progress);
    [self setProgress:progress animated:YES];
}

- (void)resetAnimated:(BOOL)animated {
    [self setProgress:0.0 animated:animated];
}

- (void)stopAllAnimations {
    // 停止进度环的动画
    [self.progressLayer removeAllAnimations];
    [self.trackLayer removeAllAnimations];
    
    // 重置进度到0
    self.currentProgress = 0.0;
    self.progressLayer.strokeEnd = 0.0;
    
    // 更新路径
    [self updateProgressPath];
}

#pragma mark - 属性设置

- (void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    self.progressLayer.strokeColor = progressColor.CGColor;
}

- (void)setTrackColor:(UIColor *)trackColor {
    _trackColor = trackColor;
    self.trackLayer.strokeColor = trackColor.CGColor;
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    self.trackLayer.lineWidth = lineWidth;
    self.progressLayer.lineWidth = lineWidth;
    [self calculateCenterAndRadius];
    [self updateProgressPath];
}

- (void)setRadius:(CGFloat)radius {
    _radius = radius;
    [self calculateCenterAndRadius];
    [self updateProgressPath];
}

- (void)setShowsTrack:(BOOL)showsTrack {
    _showsTrack = showsTrack;
    if (showsTrack && !self.trackLayer) {
        [self createTrackLayer];
    } else if (!showsTrack && self.trackLayer) {
        [self.trackLayer removeFromSuperlayer];
        self.trackLayer = nil;
    }
}

- (void)setStartAngle:(CGFloat)startAngle {
    _startAngle = startAngle;
    [self updateProgressPath];
}

- (void)setClockwise:(BOOL)clockwise {
    _clockwise = clockwise;
    [self updateProgressPath];
}

#pragma mark - 布局

- (void)layoutSubviews {
    [super layoutSubviews];
    [self calculateCenterAndRadius];
    [self updateProgressPath];
}

#pragma mark - 只读属性

- (CGFloat)progress {
    return _currentProgress;
}

- (BOOL)isCompleted {
    return _currentProgress >= 1.0;
}

@end
