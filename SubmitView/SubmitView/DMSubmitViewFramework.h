//
//  DMSubmitViewFramework.h
//  SubmitView
//
//  Created by David on 16/2/19.
//  Copyright © 2016年 com.david. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for DMSubmitViewFramework.
FOUNDATION_EXPORT double DMSubmitViewFrameworkVersionNumber;

//! Project version string for DMSubmitViewFramework.
FOUNDATION_EXPORT const unsigned char DMSubmitViewFrameworkVersionString[];

// 导入所有组件
#import "DMSubmitView.h"
#import "DMSubmitButton.h"
#import "DMSubmitLabel.h"
#import "DMProgressView.h"

// 版本信息
#define DM_SUBMIT_VIEW_VERSION @"2.0.0"
#define DM_SUBMIT_VIEW_VERSION_MAJOR 2
#define DM_SUBMIT_VIEW_VERSION_MINOR 0
#define DM_SUBMIT_VIEW_VERSION_PATCH 0

// 兼容性检查
#define DM_SUBMIT_VIEW_IOS_VERSION_MIN 8.0

// 快速创建宏
#define DMSubmitViewCreate(frame) [[DMSubmitView alloc] initWithFrame:frame]
#define DMSubmitViewCreateWithConfig(frame, config) [[DMSubmitView alloc] initWithFrame:frame configuration:config]

#define DMSubmitButtonCreate(frame) [DMSubmitButton createSubmitButtonWithFrame:frame]
#define DMSubmitButtonCreateWithConfig(frame, config) [DMSubmitButton createSubmitButtonWithFrame:frame configuration:config]

#define DMSubmitLabelCreate(frame) [DMSubmitLabel createSubmitLabelWithFrame:frame]
#define DMSubmitLabelCreateWithConfig(frame, config) [DMSubmitLabel createSubmitLabelWithFrame:frame configuration:config]

#define DMProgressViewCreate(frame) [[DMProgressView alloc] initWithFrame:frame]
#define DMProgressViewCreateWithConfig(frame, config) [[DMProgressView alloc] initWithFrame:frame configuration:config]

// 常用颜色宏
#define DMColorFromRGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define DMColorFromRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

// 默认颜色
#define DMDefaultButtonColor DMColorFromRGB(33, 197, 131)
#define DMDefaultBorderColor DMColorFromRGB(172, 172, 172)
#define DMDefaultProgressColor DMColorFromRGB(33, 197, 131)
#define DMDefaultTrackColor DMColorFromRGB(172, 172, 172)

// 动画时长常量
#define DMDefaultScaleAnimationDuration 1.0
#define DMDefaultExpandAnimationDuration 1.0
#define DMDefaultProgressAnimationDuration 0.3
#define DMDefaultTouchAnimationDuration 0.15

// 默认尺寸
#define DMDefaultCornerRadius 25.0
#define DMDefaultProgressLineWidth 3.0
#define DMDefaultBorderWidth 2.0

// 日志宏
#ifdef DEBUG
    #define DMLog(fmt, ...) NSLog((@"[DMSubmitView] " fmt), ##__VA_ARGS__)
#else
    #define DMLog(...)
#endif

// 弱引用宏
#define DMWeakSelf __weak typeof(self) weakSelf = self
#define DMStrongSelf __strong typeof(weakSelf) strongSelf = weakSelf

// 主线程执行宏
#define DMDispatchMain(block) dispatch_async(dispatch_get_main_queue(), block)
#define DMDispatchMainSync(block) dispatch_sync(dispatch_get_main_queue(), block)

// 后台线程执行宏
#define DMDispatchBackground(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)

// 延迟执行宏
#define DMDispatchAfter(delay, block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), block)

// 安全检查宏
#define DMCheckNil(obj) if (!obj) return
#define DMCheckNilWithReturn(obj, returnValue) if (!obj) return returnValue

// 范围限制宏
#define DMClamp(value, min, max) MAX(min, MIN(max, value))
#define DMClamp01(value) DMClamp(value, 0.0, 1.0)

// 角度转弧度宏
#define DMDegreesToRadians(degrees) ((degrees) * M_PI / 180.0)
#define DMRadiansToDegrees(radians) ((radians) * 180.0 / M_PI)

// 屏幕尺寸宏
#define DMScreenWidth [UIScreen mainScreen].bounds.size.width
#define DMScreenHeight [UIScreen mainScreen].bounds.size.height
#define DMScreenBounds [UIScreen mainScreen].bounds

// 设备类型检查
#define DMIsIPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define DMIsIPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// iOS版本检查
#define DMIOSVersionGreaterThanOrEqualTo(version) ([[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch] != NSOrderedAscending)

// 系统颜色可用性检查
#define DMCanUseSystemColors DMIOSVersionGreaterThanOrEqualTo(@"13.0")

// 系统颜色获取宏
#define DMGetSystemColor(colorName) (DMCanUseSystemColors ? [UIColor colorName] : [UIColor colorName])

// 常用系统颜色
#define DMSystemBlueColor DMGetSystemColor(systemBlueColor)
#define DMSystemGreenColor DMGetSystemColor(systemGreenColor)
#define DMSystemRedColor DMGetSystemColor(systemRedColor)
#define DMSystemOrangeColor DMGetSystemColor(systemOrangeColor)
#define DMSystemYellowColor DMGetSystemColor(systemYellowColor)
#define DMSystemPurpleColor DMGetSystemColor(systemPurpleColor)
#define DMSystemPinkColor DMGetSystemColor(systemPinkColor)
#define DMSystemGrayColor DMGetSystemColor(systemGrayColor)
#define DMSystemGray2Color DMGetSystemColor(systemGray2Color)
#define DMSystemGray3Color DMGetSystemColor(systemGray3Color)
#define DMSystemGray4Color DMGetSystemColor(systemGray4Color)
#define DMSystemGray5Color DMGetSystemColor(systemGray5Color)
#define DMSystemGray6Color DMGetSystemColor(systemGray6Color)

// 背景颜色
#define DMBackgroundColor DMGetSystemColor(systemBackgroundColor)
#define DMSecondaryBackgroundColor DMGetSystemColor(secondarySystemBackgroundColor)
#define DMTertiaryBackgroundColor DMGetSystemColor(tertiarySystemBackgroundColor)

// 标签颜色
#define DMLabelColor DMGetSystemColor(labelColor)
#define DMSecondaryLabelColor DMGetSystemColor(secondaryLabelColor)
#define DMTertiaryLabelColor DMGetSystemColor(tertiaryLabelColor)
#define DMQuaternaryLabelColor DMGetSystemColor(quaternaryLabelColor)

// 分隔线颜色
#define DMSeparatorColor DMGetSystemColor(separatorColor)
#define DMOpaqueSeparatorColor DMGetSystemColor(opaqueSeparatorColor)

// 链接颜色
#define DMLinkColor DMGetSystemColor(linkColor)

// 占位符颜色
#define DMPlaceholderTextColor DMGetSystemColor(placeholderTextColor)

// 组背景颜色
#define DMGroupTableViewBackgroundColor DMGetSystemColor(groupTableViewBackgroundColor)

// 系统填充颜色
#define DMSystemFillColor DMGetSystemColor(systemFillColor)
#define DMSecondarySystemFillColor DMGetSystemColor(secondarySystemFillColor)
#define DMTertiarySystemFillColor DMGetSystemColor(tertiarySystemFillColor)
#define DMQuaternarySystemFillColor DMGetSystemColor(quaternarySystemFillColor)

// 系统组背景颜色
#define DMSystemGroupedBackgroundColor DMGetSystemColor(systemGroupedBackgroundColor)
#define DMSecondarySystemGroupedBackgroundColor DMGetSystemColor(secondarySystemGroupedBackgroundColor)
#define DMTertiarySystemGroupedBackgroundColor DMGetSystemColor(tertiarySystemGroupedBackgroundColor)

// 系统材质颜色
#define DMSystemThinMaterialColor DMGetSystemColor(systemThinMaterialColor)
#define DMSystemThickMaterialColor DMGetSystemColor(systemThickMaterialColor)
#define DMSystemUltraThinMaterialColor DMGetSystemColor(systemUltraThinMaterialColor)
#define DMSystemChromeMaterialColor DMGetSystemColor(systemChromeMaterialColor)

// 系统材质组背景颜色
#define DMSystemThinMaterialGroupedBackgroundColor DMGetSystemColor(systemThinMaterialGroupedBackgroundColor)
#define DMSystemThickMaterialGroupedBackgroundColor DMGetSystemColor(systemThickMaterialGroupedBackgroundColor)
#define DMSystemUltraThinMaterialGroupedBackgroundColor DMGetSystemColor(systemUltraThinMaterialGroupedBackgroundColor)
#define DMSystemChromeMaterialGroupedBackgroundColor DMGetSystemColor(systemChromeMaterialGroupedBackgroundColor)

// 兼容性颜色（iOS 13以下）
#define DMCompatSystemBlueColor (DMCanUseSystemColors ? [UIColor systemBlueColor] : [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0])
#define DMCompatSystemGreenColor (DMCanUseSystemColors ? [UIColor systemGreenColor] : [UIColor colorWithRed:52.0/255.0 green:199.0/255.0 blue:89.0/255.0 alpha:1.0])
#define DMCompatSystemRedColor (DMCanUseSystemColors ? [UIColor systemRedColor] : [UIColor colorWithRed:255.0/255.0 green:59.0/255.0 blue:48.0/255.0 alpha:1.0])
#define DMCompatSystemGrayColor (DMCanUseSystemColors ? [UIColor systemGrayColor] : [UIColor colorWithRed:142.0/255.0 green:142.0/255.0 blue:147.0/255.0 alpha:1.0])

// 框架信息
@interface DMSubmitViewFramework : NSObject

/**
 * 获取框架版本号
 */
+ (NSString *)version;

/**
 * 获取框架版本号（数字）
 */
+ (double)versionNumber;

/**
 * 检查iOS版本兼容性
 */
+ (BOOL)isCompatibleWithCurrentiOSVersion;

/**
 * 获取最低支持的iOS版本
 */
+ (NSString *)minimumSupportediOSVersion;

/**
 * 获取框架信息
 */
+ (NSDictionary *)frameworkInfo;

@end
