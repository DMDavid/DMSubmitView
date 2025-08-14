//
//  DMSubmitLabel.h
//  SubmitView
//
//  Created by David on 16/2/22.
//  Copyright © 2016年 com.david. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DMSubmitLabel : UILabel

// MARK: - 外观配置
/// 默认文本
@property (nonatomic, strong, nullable) NSString *defaultText;
/// 默认文本颜色
@property (nonatomic, strong, nullable) UIColor *defaultTextColor;
/// 默认字体
@property (nonatomic, strong, nullable) UIFont *defaultFont;
/// 完成状态文本
@property (nonatomic, strong, nullable) NSString *completionText;
/// 完成状态文本颜色
@property (nonatomic, strong, nullable) UIColor *completionTextColor;

// MARK: - 动画配置
/// 点击动画持续时间
@property (nonatomic, assign) NSTimeInterval touchAnimationDuration;
/// 点击动画缩放比例
@property (nonatomic, assign) CGFloat touchAnimationScale;
/// 是否启用点击动画
@property (nonatomic, assign) BOOL touchAnimationEnabled;
/// 完成动画持续时间
@property (nonatomic, assign) NSTimeInterval completionAnimationDuration;
/// 完成动画曲线
@property (nonatomic, strong) CAMediaTimingFunction *completionTimingFunction;

// MARK: - 完成图标配置
/// 是否显示完成图标
@property (nonatomic, assign) BOOL showsCompletionIcon;
/// 完成图标颜色
@property (nonatomic, strong, nullable) UIColor *completionIconColor;
/// 完成图标线宽
@property (nonatomic, assign) CGFloat completionIconLineWidth;
/// 完成图标大小
@property (nonatomic, assign) CGSize completionIconSize;

// MARK: - 初始化方法
/**
 * 使用frame创建提交标签
 * @param frame 标签frame
 */
+ (instancetype)createSubmitLabelWithFrame:(CGRect)frame;

/**
 * 使用frame创建提交标签（推荐）
 * @param frame 标签frame
 * @param configuration 配置block
 */
+ (instancetype)createSubmitLabelWithFrame:(CGRect)frame 
                             configuration:(void(^)(DMSubmitLabel *label))configuration;

// MARK: - 动画控制
/**
 * 执行点击动画
 */
- (void)touchDownAnimation;

/**
 * 执行显示标签动画
 */
- (void)showLabelAnimation;

/**
 * 执行完成动画
 * @param completion 完成回调
 */
- (void)showCompletionAnimation:(void(^)(void))completion;

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
 * 执行淡入动画
 * @param duration 动画持续时间
 * @param completion 完成回调
 */
- (void)performFadeInAnimation:(NSTimeInterval)duration 
                    completion:(void(^)(void))completion;

/**
 * 停止所有动画
 */
- (void)stopAllAnimations;

// MARK: - 状态控制
/**
 * 重置为默认状态
 * @param animated 是否动画
 */
- (void)resetToDefaultState:(BOOL)animated;

/**
 * 设置完成状态
 * @param animated 是否动画
 */
- (void)setCompletionState:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
