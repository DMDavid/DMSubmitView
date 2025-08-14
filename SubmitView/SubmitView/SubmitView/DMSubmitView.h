//
//  DMSubmitView.h
//  SubmitView
//
//  Created by David on 16/2/19.
//  Copyright © 2016年 com.david. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DMSubmitViewDelegate <NSObject>
@optional
// 开始显示进度视图回调
- (void)submitViewStartShowProgressViewStatus;
// 提交按钮点击回调
- (void)submitViewButtonDidClick;
// 进度更新回调
- (void)submitViewDidUpdateProgress:(CGFloat)progress;
// 完成回调
- (void)submitViewDidComplete;

@end

@interface DMSubmitView : UIView

// MARK: - 外观配置
/// 按钮背景颜色
@property (nonatomic, strong, nullable) UIColor *buttonColor;
/// 按钮边框颜色
@property (nonatomic, strong, nullable) UIColor *borderColor;
/// 按钮边框宽度
@property (nonatomic, assign) CGFloat borderWidth;
/// 按钮圆角半径
@property (nonatomic, assign) CGFloat cornerRadius;
/// 按钮阴影颜色
@property (nonatomic, strong, nullable) UIColor *shadowColor;
/// 按钮阴影偏移
@property (nonatomic, assign) CGSize shadowOffset;
/// 按钮阴影半径
@property (nonatomic, assign) CGFloat shadowRadius;
/// 按钮阴影透明度
@property (nonatomic, assign) CGFloat shadowOpacity;

// MARK: - 文本配置
/// 按钮文本
@property (nonatomic, strong, nullable) NSString *buttonText;
/// 按钮文本颜色
@property (nonatomic, strong, nullable) UIColor *buttonTextColor;
/// 按钮文本字体
@property (nonatomic, strong, nullable) UIFont *buttonTextFont;
/// 完成状态文本
@property (nonatomic, strong, nullable) NSString *completionText;
/// 完成状态文本颜色
@property (nonatomic, strong, nullable) UIColor *completionTextColor;

// MARK: - 进度环配置
/// 进度环颜色
@property (nonatomic, strong, nullable) UIColor *progressColor;
/// 进度环背景颜色
@property (nonatomic, strong, nullable) UIColor *progressTrackColor;
/// 进度环线宽
@property (nonatomic, assign) CGFloat progressLineWidth;
/// 进度环半径
@property (nonatomic, assign) CGFloat progressRadius;
/// 是否显示进度环背景
@property (nonatomic, assign) BOOL showsProgressTrack;

// MARK: - 动画配置
/// 缩放动画持续时间
@property (nonatomic, assign) NSTimeInterval scaleAnimationDuration;
/// 展开动画持续时间
@property (nonatomic, assign) NSTimeInterval expandAnimationDuration;
/// 是否启用动画
@property (nonatomic, assign) BOOL animated;

// MARK: - 状态
/// 当前进度值 (0.0 - 1.0)
@property (nonatomic, assign, readonly) CGFloat currentProgressFloat;
/// 总进度值
@property (nonatomic, assign, readonly) CGFloat totalProgressFloat;
/// 是否正在显示进度
@property (nonatomic, assign, readonly) BOOL isShowingProgress;
/// 是否已完成
@property (nonatomic, assign, readonly) BOOL isCompleted;

// MARK: - 代理
@property (nonatomic, weak, nullable) id<DMSubmitViewDelegate> delegate;

// MARK: - 初始化方法
/**
 * 使用frame初始化提交视图
 * @param frame 视图frame
 */
- (instancetype)initWithFrame:(CGRect)frame;

/**
 * 使用frame初始化提交视图（推荐）
 * @param frame 视图frame
 * @param configuration 配置block
 */
- (instancetype)initWithFrame:(CGRect)frame 
                configuration:(void(^)(DMSubmitView *submitView))configuration;

// MARK: - 进度控制
/**
 * 更新进度
 * @param currentData 当前数据
 * @param totalData 总数据
 */
- (void)updateProgressViewWitCurrenthData:(CGFloat)currentData 
                                 totalData:(CGFloat)totalData;

/**
 * 设置进度值
 * @param progress 进度值 (0.0 - 1.0)
 * @param animated 是否动画
 */
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

// MARK: - 外观设置
/**
 * 设置按钮标题
 * @param title 标题文本
 */
- (void)setupSubmitViewTitle:(NSString *)title;

/**
 * 设置按钮字体
 * @param font 字体
 */
- (void)setupSubmitViewFont:(UIFont *)font;

/**
 * 设置按钮文本颜色
 * @param textColor 文本颜色
 */
- (void)setupSubmitViewTextColor:(UIColor *)textColor;

/**
 * 设置按钮颜色
 * @param buttonColor 按钮颜色
 */
- (void)setupSubmitViewButtonColor:(UIColor *)buttonColor;

/**
 * 设置按钮边框颜色
 * @param borderColor 边框颜色
 */
- (void)setupSubmitViewButtonBorderColor:(UIColor *)borderColor;

// MARK: - 状态控制
/**
 * 重置为初始状态
 * @param animated 是否动画
 */
- (void)resetToInitialState:(BOOL)animated;

/**
 * 手动触发完成状态
 * @param animated 是否动画
 */
- (void)triggerCompletion:(BOOL)animated;

/**
 * 开始显示进度
 * @param animated 是否动画
 */
- (void)startShowingProgress:(BOOL)animated;

/**
 * 停止显示进度
 * @param animated 是否动画
 */
- (void)stopShowingProgress:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
