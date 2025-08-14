//
//  DMSubmitButton.h
//  SubmitView
//
//  Created by David on 16/2/22.
//  Copyright © 2016年 com.david. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DMSubmitButton : UIButton

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

// MARK: - 状态配置
/// 正常状态下的背景颜色
@property (nonatomic, strong, nullable) UIColor *normalBackgroundColor;
/// 高亮状态下的背景颜色
@property (nonatomic, strong, nullable) UIColor *highlightedBackgroundColor;
/// 禁用状态下的背景颜色
@property (nonatomic, strong, nullable) UIColor *disabledBackgroundColor;

// MARK: - 动画配置
/// 点击动画持续时间
@property (nonatomic, assign) NSTimeInterval touchAnimationDuration;
/// 点击动画缩放比例
@property (nonatomic, assign) CGFloat touchAnimationScale;
/// 是否启用点击动画
@property (nonatomic, assign) BOOL touchAnimationEnabled;

// MARK: - 初始化方法
/**
 * 使用frame创建提交按钮
 * @param frame 按钮frame
 */
+ (instancetype)createSubmitButtonWithFrame:(CGRect)frame;

/**
 * 使用frame创建提交按钮（推荐）
 * @param frame 按钮frame
 * @param configuration 配置block
 */
+ (instancetype)createSubmitButtonWithFrame:(CGRect)frame 
                              configuration:(void(^)(DMSubmitButton *button))configuration;

// MARK: - 外观设置
/**
 * 设置按钮颜色
 * @param buttonColor 按钮背景颜色
 */
- (void)setupSubmitButtonColor:(UIColor *)buttonColor;

/**
 * 设置按钮边框颜色
 * @param borderColor 边框颜色
 */
- (void)setupSubmitButtonBorderColor:(UIColor *)borderColor;

/**
 * 设置按钮样式
 * @param backgroundColor 背景颜色
 * @param borderColor 边框颜色
 * @param borderWidth 边框宽度
 */
- (void)setupButtonStyleWithBackgroundColor:(UIColor *)backgroundColor
                                borderColor:(UIColor *)borderColor
                                borderWidth:(CGFloat)borderWidth;

// MARK: - 状态控制
/**
 * 隐藏提交按钮（显示边框样式）
 */
- (void)setHiddenSubmitButton;

/**
 * 显示提交按钮（显示填充样式）
 */
- (void)setShowSubmitButton;

/**
 * 设置按钮状态
 * @param hidden 是否隐藏
 * @param animated 是否动画
 */
- (void)setButtonHidden:(BOOL)hidden animated:(BOOL)animated;

// MARK: - 动画控制
/**
 * 执行点击动画
 */
- (void)performTouchAnimation;

/**
 * 执行缩放动画
 * @param scale 缩放比例
 * @param duration 动画持续时间
 * @param completion 完成回调
 */
- (void)performScaleAnimation:(CGFloat)scale 
                     duration:(NSTimeInterval)duration 
                   completion:(void(^)(void))completion;

/**
 * 停止所有动画
 */
- (void)stopAllAnimations;

@end

NS_ASSUME_NONNULL_END
