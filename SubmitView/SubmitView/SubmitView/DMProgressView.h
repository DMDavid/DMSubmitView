//
//  DMProgressView.h
//  SubmitView
//
//  Created by David on 16/2/28.
//  Copyright © 2016年 com.david. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DMProgressViewDelegate <NSObject>
@optional
// 进度环完成回调
- (void)progressViewCompletionCallBack;
// 进度更新回调
- (void)progressViewDidUpdateProgress:(CGFloat)progress;

@end

@interface DMProgressView : UIView

// MARK: - 外观配置
/// 进度环线宽
@property (nonatomic, assign) CGFloat lineWidth;
/// 进度环颜色
@property (nonatomic, strong, nullable) UIColor *progressColor;
/// 背景环颜色
@property (nonatomic, strong, nullable) UIColor *trackColor;
/// 进度环半径
@property (nonatomic, assign) CGFloat radius;
/// 是否显示背景环
@property (nonatomic, assign) BOOL showsTrack;
/// 进度环起始角度（弧度，默认从顶部开始）
@property (nonatomic, assign) CGFloat startAngle;
/// 进度环结束角度（弧度，默认顺时针）
@property (nonatomic, assign) BOOL clockwise;

// MARK: - 动画配置
/// 动画持续时间
@property (nonatomic, assign) NSTimeInterval animationDuration;
/// 动画曲线
@property (nonatomic, strong) CAMediaTimingFunction *timingFunction;
/// 是否启用动画
@property (nonatomic, assign) BOOL animated;

// MARK: - 状态
/// 当前进度值 (0.0 - 1.0)
@property (nonatomic, assign, readonly) CGFloat progress;
/// 是否已完成
@property (nonatomic, assign, readonly) BOOL isCompleted;

// MARK: - 代理
@property (nonatomic, weak, nullable) id<DMProgressViewDelegate> delegate;

// MARK: - 初始化方法
/**
 * 使用frame初始化进度环
 * @param frame 视图frame
 * @param radius 进度环半径
 * @param lineWidth 线宽
 */
- (instancetype)initWithFrame:(CGRect)frame 
                       radius:(CGFloat)radius 
                    lineWidth:(CGFloat)lineWidth;

/**
 * 使用frame初始化进度环（推荐）
 * @param frame 视图frame
 * @param configuration 配置block
 */
- (instancetype)initWithFrame:(CGRect)frame 
                configuration:(void(^)(DMProgressView *progressView))configuration;

// MARK: - 进度控制
/**
 * 设置进度值
 * @param progress 进度值 (0.0 - 1.0)
 * @param animated 是否动画
 */
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

/**
 * 更新进度（兼容旧接口）
 * @param currentData 当前数据
 * @param totalData 总数据
 */
- (void)updateProgressViewWitCurrenthData:(CGFloat)currentData 
                                 totalData:(CGFloat)totalData;

// MARK: - 重置
/**
 * 重置进度环
 * @param animated 是否动画
 */
- (void)resetAnimated:(BOOL)animated;

/**
 * 停止所有动画
 */
- (void)stopAllAnimations;

@end

NS_ASSUME_NONNULL_END
