//
//  ProgressView.h
//  ProgressLayer
//
//  Created by David on 16/2/28.
//  Copyright © 2016年 com.david. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProgressViewDelegate;

@interface ProgressView : UIView

@property (nonatomic,retain) NSURLRequest *request;
@property (nonatomic,retain) NSURLSession *session;
//下载的文件名字
@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, assign) CGFloat number;
@property (nonatomic, assign) CGFloat radius;
@property(nonatomic, assign) CGFloat arcLineWith;
@property (nonatomic, weak)   id <ProgressViewDelegate> delegate;

- (ProgressView *)initWithURL:(NSURL *)fileURL progressViewWithFrame:(CGRect)frame timeout:(CGFloat)timeout radius:(CGFloat)radius layerWith:(CGFloat)layerWith delegate:(id <ProgressViewDelegate>)theDlegate;

@end


@protocol ProgressViewDelegate <NSObject>

//下载错误
- (void)progressView:(ProgressView *)progressView didFileWithError:(NSError *)error;

//下载完成
- (void)progressView:(ProgressView *)progressView didFinishedWithSuggestedFileName:(NSString *)fileName;

//下载中
- (void)progressViewUpdated:(ProgressView *)progressView;

@end