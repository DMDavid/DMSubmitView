//
//  ProgressView.m
//  ProgressLayer
//
//  Created by David on 16/2/28.
//  Copyright © 2016年 com.david. All rights reserved.
//

#import "DMProgressView.h"

@interface DMProgressView()

@property (nonatomic, assign) CGFloat number;
@property (nonatomic, assign) CGFloat radius;
//圆环中心坐标
@property(nonatomic, assign) CGPoint arcLayerCenter;

@end

@implementation DMProgressView

- (void)drawRect:(CGRect)rect
{
    //画背景环
    [self drawBackgroundProgressLayer];
    //画进度环
    [self drawProgressLayer];
}

- (void)drawProgressLayer
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, self.radius / 10.0);
    CGContextSetRGBStrokeColor(ctx, 33.0/255.0, 197.0/255.0, 131.0/255.0, 1);
    CGContextSetLineWidth(ctx, self.arcLineWith);
    CGFloat end = - 1 * M_PI_2 + (4 * M_PI_2 * self.number);
    CGContextAddArc(ctx, _arcLayerCenter.x, _arcLayerCenter.y, self.radius, - 1 * M_PI_2, end, 0);
    CGContextStrokePath(ctx);
}

- (void)drawBackgroundProgressLayer
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, self.radius / 10.0);
    CGContextSetRGBStrokeColor(ctx, 172.0/255.0, 172.0/255.0, 172.0/255.0, 1);
    CGContextSetLineWidth(ctx, self.arcLineWith);
    CGFloat end = - 1 * M_PI + (2 * M_PI);
    CGContextAddArc(ctx, _arcLayerCenter.x, _arcLayerCenter.y, self.radius, - 1 * M_PI, end, 0);
    CGContextStrokePath(ctx);
}

- (DMProgressView *)initWithProgressViewWithFrame:(CGRect)frame timeout:(CGFloat)timeout radius:(CGFloat)radius layerWith:(CGFloat)layerWith {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.arcLineWith = layerWith;
        self.arcLayerCenter = (CGPoint){frame.size.width/2, frame.size.height/2};
        self.number = 0.0;
        self.clipsToBounds = NO;
        self.radius = radius;
        
    }
    return self;
}

- (void)updateProgressViewWitCurrenthData:(CGFloat)currentData totalData:(CGFloat)totalData {
    self.number = (CGFloat)currentData/(CGFloat)totalData;
    [self setNeedsDisplay];
    
    //the animation is completion
    if (self.number >= 1) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(progressViewCompletionCallBack)]) {
            [self.delegate progressViewCompletionCallBack];
        }
    }
}

@end
