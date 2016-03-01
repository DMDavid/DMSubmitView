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
#import "ProgressView.h"

#define url [NSURL URLWithString:@"http://image.baidu.com/search/down?tn=download&word=download&ie=utf8&fr=detail&url=http%3A%2F%2Fimgstore.cdn.sogou.com%2Fapp%2Fa%2F100540002%2Ficard_bg_10332.jpg"]

@interface SubmitView () <ProgressViewDelegate>

@property(nonatomic, strong) SubmitButton *submitButton;
@property(nonatomic, strong) SubmitLabel *showLabel;

@property(nonatomic, assign) CGRect originRect;
@property(nonatomic, assign) CGPoint viewCenter;

@end

@implementation SubmitView {
    ProgressView *progress;
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
    
    CGFloat layerWith = 3.0;
    CGFloat progressRadius = self.bounds.size.height/2;
    CGRect progressFrame = (CGRect){{self.bounds.size.width/2-progressRadius, 0}, {self.bounds.size.height + 2*layerWith, self.bounds.size.height + 2*layerWith}};
    
    //创建一个进度环view
    progress = [[ProgressView alloc] initWithURL:url progressViewWithFrame:progressFrame timeout:INTMAX_MAX radius:progressRadius layerWith:layerWith delegate:self];
    [self addSubview:progress];
}


//扩充动画
- (void)expandLayerAnimation {
    [progress removeFromSuperview];
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


#pragma mark - delegate
- (void)progressView:(ProgressView *)progressView didFileWithError:(NSError *)error {
    NSLog(@"错误---- %@",error);
}

- (void)progressViewUpdated:(ProgressView *)progressView {
    NSLog(@"下载中");
}

- (void)progressView:(ProgressView *)progressView didFinishedWithSuggestedFileName:(NSString *)fileName {
    NSLog(@"下载结束,文件地址: %@",fileName);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self expandLayerAnimation];
    });
}

@end
