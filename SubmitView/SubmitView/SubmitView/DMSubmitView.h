//
//  SubmitView.h
//  SubmitAnimation
//
//  Created by David on 16/2/19.
//  Copyright © 2016年 com.david. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DMSubmitViewDelegate <NSObject>
@optional
//the view is start show progress view call back
- (void)submitViewStartShowProgressViewStatus;

@end

@interface DMSubmitView : UIView

//delegaet
@property (nonatomic, weak) id <DMSubmitViewDelegate> delegate;

//current progress float
@property (nonatomic, assign, readonly) CGFloat currentProgressFloat;

//current total float
@property (nonatomic, assign, readonly) CGFloat totalProgressFloat;

//update pregress view
//更新进度
- (void)updateProgressViewWitCurrenthData:(CGFloat)currentData totalData:(CGFloat)totalData;

//setup show
- (void)setupSubmitViewTitle:(NSString *)title;

- (void)setupSubmitViewFont:(UIFont *)font;

- (void)setupSubmitViewTextColor:(UIColor *)textColor;


@end
