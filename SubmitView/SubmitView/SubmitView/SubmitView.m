//
//  SubmitView.m
//  SubmitAnimation
//
//  Created by David on 16/2/19.
//  Copyright © 2016年 com.david. All rights reserved.
//

#import "SubmitView.h"

#import "SubmitButton.h"
#import "SubmitLabel.h"

@interface SubmitView ()

@property(nonatomic, strong) SubmitButton *submitButton;
@property(nonatomic, strong) SubmitLabel *showLabel;

@property(nonatomic, assign) CGRect originRect;
@property(nonatomic, assign) CGPoint viewCenter;

@end

@implementation SubmitView
{
    CAShapeLayer *backProgressLayer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _originRect = self.bounds;
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    _submitButton = [SubmitButton creatSubmitButtonWithFrame:self.bounds]; 
    [_submitButton addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_submitButton addTarget:self action:@selector(buttonTouchDown) forControlEvents:UIControlEventTouchDown];
    [self addSubview:_submitButton];
    
    _showLabel = [[SubmitLabel alloc] initWithFrame:self.bounds];
    [self addSubview:_showLabel];
}

- (void)buttonTouchDown {
    [_showLabel touchDownAnimation];
} 

- (void)submitBtnClick:(UIButton *)submitBtn {
    //缩小动画
    [self scaleLayerAnimtaion];
    
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        //隐藏按钮
        self.showLabel.alpha = 0;
        [_submitButton setHiddenSubmitButton];
        
    } completion:^(BOOL finished) {
        self.submitButton.hidden = YES;
        [self drawProgressLayer]; 
    }];
}

- (void)setupSureLayer {
    self.showLabel.hidden = YES;
    CAShapeLayer *sureLayer = [CAShapeLayer layer];
    sureLayer.fillColor = [UIColor whiteColor].CGColor;
    sureLayer.strokeColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *newPath = [UIBezierPath bezierPath];
    [newPath moveToPoint:(CGPoint){_viewCenter.x-5 , _viewCenter.y}];
    [newPath addLineToPoint:CGPointMake(_viewCenter.x, _viewCenter.y + 5)];
    [newPath addLineToPoint:CGPointMake(_viewCenter.x+10, _viewCenter.y -5)];
    
    sureLayer.path = newPath.CGPath;
    [self.submitButton.layer addSublayer:sureLayer];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.0;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    
    [sureLayer addAnimation:pathAnimation forKey:nil];
}

//进度环动画
- (void)drawProgressLayer {
    _viewCenter = (CGPoint){self.bounds.size.width/2, self.bounds.size.height/2};
    
    //1. 背景环
    backProgressLayer = [CAShapeLayer layer];
    backProgressLayer.strokeColor = changedBgColor.CGColor;
    backProgressLayer.fillColor = [UIColor whiteColor].CGColor;
    backProgressLayer.lineCap   = kCALineCapRound;
    backProgressLayer.lineJoin  = kCALineJoinBevel;
    backProgressLayer.lineWidth = 2;
    
    UIBezierPath *backProgressCircle = [UIBezierPath bezierPath];
    [backProgressCircle addArcWithCenter:_viewCenter radius:self.bounds.size.height/2 startAngle:-M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES];
    backProgressLayer.path = backProgressCircle.CGPath;
    [self.layer addSublayer:backProgressLayer];
    
    
    //2. 圆环
    CAShapeLayer *progressLayer = [CAShapeLayer layer];
    progressLayer.strokeColor = btnColor.CGColor;
    progressLayer.fillColor = [UIColor whiteColor].CGColor;
    progressLayer.lineCap   = kCALineCapRound;
    progressLayer.lineJoin  = kCALineJoinBevel;
    progressLayer.lineWidth = 4.0;
    progressLayer.strokeEnd = 0.0;
    
    UIBezierPath *progressCircle = [UIBezierPath bezierPath];
    [progressCircle addArcWithCenter:_viewCenter radius:self.bounds.size.height/2 startAngle:-M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES];
    progressLayer.path = progressCircle.CGPath;
    [backProgressLayer addSublayer:progressLayer];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 3.0;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.fillMode = kCAFillModeForwards;
    [progressLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self expandLayerAnimation];
    });
}


//扩充动画
- (void)expandLayerAnimation {
    [backProgressLayer removeFromSuperlayer];
    [_submitButton setShowSubmitButton];
    [_showLabel showLabelAnimation];

    CABasicAnimation *anima = [CABasicAnimation animation];
    anima.duration = 1.;
    anima.keyPath = @"bounds";
    anima.toValue = [NSValue valueWithCGRect:_originRect];
    anima.removedOnCompletion = NO;
    anima.fillMode = kCAFillModeForwards;
    [self.submitButton.layer addAnimation:anima forKey:nil];
}

//缩放动画
- (void)scaleLayerAnimtaion {
    CABasicAnimation *anima = [CABasicAnimation animation];
    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    anima.duration = 1.;
    anima.keyPath = @"bounds";
    anima.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, _originRect.size.height, _originRect.size.height)];
    anima.removedOnCompletion = NO;
    anima.fillMode = kCAFillModeForwards;
    [self.submitButton.layer addAnimation:anima forKey:nil];
}

@end
