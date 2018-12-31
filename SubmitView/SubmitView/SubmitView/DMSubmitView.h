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

//submit button Did Click
- (void)submitViewButtonDidClick;

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

//setup label font
- (void)setupSubmitViewFont:(UIFont *)font;

//setup label text color
- (void)setupSubmitViewTextColor:(UIColor *)textColor;

//setup subview button color,
//default is [UIColor colorWithRed:33.0/255.0 green:197.0/255.0 blue:131.0/255.0 alpha:1]
- (void)setupSubmitViewButtonColor:(UIColor *)buttonColor;

//setup subview button blod color,
//default is [UIColor colorWithRed:172.0/255.0 green:172.0/255.0 blue:172.0/255.0 alpha:1]
- (void)setupSubmitViewButtonBlodColor:(UIColor *)blodColor;

@end
