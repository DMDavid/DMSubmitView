//
//  SubmitView.m
//  SubmitAnimation
//
//  Created by David on 16/2/19.
//  Copyright © 2016年 com.david. All rights reserved.
//

#import "DMSubmitView.h"

#import "DMSubmitButton.h"
#import "DMSubmitLabel.h"
#import "DMProgressView.h"

@interface DMSubmitView () <DMProgressViewDelegate>

@property(nonatomic, strong) DMSubmitButton *submitButton;
@property(nonatomic, strong) DMSubmitLabel *showLabel;

@property(nonatomic, assign) CGRect originRect;
@property(nonatomic, assign) CGPoint viewCenter;

@property (nonatomic, strong) DMProgressView *progress;

@property (nonatomic, assign, readwrite) CGFloat currentProgressFloat;
@property (nonatomic, assign, readwrite) CGFloat totalProgressFloat;

@end

@implementation DMSubmitView

- (void)updateProgressViewWitCurrenthData:(CGFloat)currentData totalData:(CGFloat)totalData {
    if (!_progress) {
        return;
    }
    
    self.currentProgressFloat = currentData;
    self.totalProgressFloat = totalData;
    
    [_progress updateProgressViewWitCurrenthData:currentData totalData:totalData];
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
    _submitButton = [DMSubmitButton creatSubmitButtonWithFrame:self.bounds];
    [_submitButton addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_submitButton addTarget:self action:@selector(buttonTouchDown) forControlEvents:UIControlEventTouchDown];
    [self addSubview:_submitButton];
    
    _showLabel = [[DMSubmitLabel alloc] initWithFrame:self.bounds];
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
        
        //call back
        if (self.delegate && [self.delegate respondsToSelector:@selector(submitViewStartShowProgressViewStatus)]) {
            [self.delegate submitViewStartShowProgressViewStatus];
        }
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
    
    CGFloat layerWith = 3.0;
    CGFloat progressRadius = self.bounds.size.height/2;
    CGFloat progressX = self.bounds.size.width/2-progressRadius-layerWith;
    CGFloat progressWH = self.bounds.size.height + 2*layerWith;
    CGRect progressFrame = (CGRect){{progressX, -layerWith}, {progressWH, progressWH}};
    
    //创建一个进度环view
    self.progress = [[DMProgressView alloc] initWithProgressViewWithFrame:progressFrame timeout:INTMAX_MAX radius:progressRadius layerWith:layerWith];
    self.progress.delegate = self;
    
    [self addSubview:self.progress];
}


//扩充动画
- (void)expandLayerAnimation {
    [_progress removeFromSuperview];
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


#pragma mark - ProgressViewDelegate

- (void)progressViewCompletionCallBack {
    [self expandLayerAnimation];
}

@end
