//
//  ProgressView.m
//  ProgressLayer
//
//  Created by David on 16/2/28.
//  Copyright © 2016年 com.david. All rights reserved.
//

#import "ProgressView.h"

@interface ProgressView() <NSURLSessionDownloadDelegate>
//圆环中心坐标
@property(nonatomic, assign) CGPoint arcLayerCenter;

@end

@implementation ProgressView

- (void)drawRect:(CGRect)rect
{
    //画背景环
    [self drawBackgroundProgressLayer];
    //画进入环
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

- (ProgressView *)initWithURL:(NSURL *)fileURL progressViewWithFrame:(CGRect)frame timeout:(CGFloat)timeout radius:(CGFloat)radius layerWith:(CGFloat)layerWith delegate:(id <ProgressViewDelegate>)theDlegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.arcLineWith = layerWith;
        self.arcLayerCenter = (CGPoint){frame.size.width/2, frame.size.height/2};
        self.delegate = theDlegate;
        self.number = 0.0;
        self.fileName = [[[fileURL absoluteString]lastPathComponent]copy];
        self.clipsToBounds = NO;
        self.radius = radius;
        self.request = [[NSURLRequest alloc] initWithURL:fileURL cachePolicy:(NSURLRequestReloadIgnoringLocalCacheData) timeoutInterval:timeout];
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil] ;
        [[self.session downloadTaskWithRequest:self.request] resume];
        
        if (self.session == nil) {
            [self.delegate progressView:self didFileWithError:[NSError errorWithDomain:@"域错误" code:1 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"链接不存在",NSLocalizedDescriptionKey, nil]]];
        }
    }
    return self;
}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.number = (CGFloat)totalBytesWritten/(CGFloat)totalBytesExpectedToWrite;
        [self setNeedsDisplay];
        [self.delegate progressViewUpdated:self];
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    
    NSString *filePath=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)objectAtIndex:0]stringByAppendingPathComponent:self.fileName];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *error;
    __unused BOOL isSuccess = [manager moveItemAtURL:location toURL:[NSURL fileURLWithPath:filePath] error:&error];
    NSLog(@"位置:  %@", filePath);
    [self.delegate progressView:self didFinishedWithSuggestedFileName:filePath];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error {
    if (error) { 
        [self.delegate progressView:self didFileWithError:error];
    }
}

@end