//
//  SubmitLabel.m
//  SubmitAnimation
//
//  Created by David on 16/2/22.
//  Copyright © 2016年 com.david. All rights reserved.
//

#import "DMSubmitLabel.h"

@implementation DMSubmitLabel

+ (instancetype)creatSubmitLabelWithFrame:(CGRect)frame {
    DMSubmitLabel *submitLabel = [[DMSubmitLabel alloc] initWithFrame:frame];
    return submitLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.text = defaultText;
        self.textColor = defaultTextColor;
        self.backgroundColor = [UIColor clearColor];
        self.font = textFont;
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)touchDownAnimation {
    CABasicAnimation *fontAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    fontAnimation.duration = 0.2;
    fontAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    fontAnimation.fromValue = [NSNumber numberWithFloat:1.];
    fontAnimation.toValue = [NSNumber numberWithFloat:.7]; 
    [self.layer addAnimation:fontAnimation forKey:@"textScaleAnimation"];
}

- (void)showLabelAnimation {
    self.text = @"";
    [self creatCompleteAnimation];
    [UIView animateWithDuration:1.0 animations:^{
        self.alpha = 1;
    }];
}

- (void)creatCompleteAnimation {
    CGPoint centerPoint = (CGPoint){self.bounds.size.width/2, self.bounds.size.height/2 + 5};
    CGFloat margin = 10;
    
    CAShapeLayer *completeLayer = [CAShapeLayer layer];
    completeLayer.fillColor = [UIColor clearColor].CGColor;
    completeLayer.strokeColor = [UIColor whiteColor].CGColor;
    completeLayer.lineCap   = kCALineJoinRound;
    completeLayer.lineJoin  = kCALineJoinRound;
    completeLayer.lineWidth = 4;
    
    UIBezierPath *completePath = [UIBezierPath bezierPath];
    [completePath moveToPoint:CGPointMake(centerPoint.x - margin, centerPoint.y)];
    [completePath addLineToPoint:CGPointMake(centerPoint.x - 5, centerPoint.y + margin - 5)];
    [completePath addLineToPoint:CGPointMake(centerPoint.x + margin, centerPoint.y - margin)];
    completeLayer.path = completePath.CGPath;
    
    [self.layer addSublayer:completeLayer];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.0;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.fillMode = kCAFillModeForwards;
    [completeLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}

@end
