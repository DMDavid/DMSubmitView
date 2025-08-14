# DMSubmitView



[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/DMDavid/SubmitView/blob/master/LICENSE)&nbsp;

## A submit progress Hud view

### CocoaPods

1. Add `pod 'DMSubmitView'` to your Podfile.
2. Run `pod install` or `pod update`.


## rendering:
效果图:
 ![image](https://github.com/DMDavid/SubmitView/blob/master/SubmitView/rendering.gif)


# DMSubmitView - 优化的提交按钮动效框架

## 概述

DMSubmitView 是一个功能强大、高度可定制化的 iOS 提交按钮动效框架。它提供了流畅的动画效果，包括按钮点击、进度显示和完成状态，适用于各种提交场景。

## 特性

### 🎨 高度可定制化
- 支持自定义按钮颜色、边框、阴影
- 可配置文本、字体、颜色
- 进度环样式完全可定制
- 动画参数可调整

### ⚡ 性能优化
- 使用 CAShapeLayer 实现高效绘制
- 内存管理优化
- 流畅的动画效果

### 🔧 易于使用
- 简洁的 API 设计
- 支持配置块初始化
- 完整的代理回调
- 向后兼容

## 安装

将以下文件添加到您的项目中：
- `DMSubmitView.h/m`
- `DMSubmitButton.h/m`
- `DMSubmitLabel.h/m`
- `DMProgressView.h/m`

## 基本使用

### 简单使用

```objc
// 创建提交视图
DMSubmitView *submitView = [[DMSubmitView alloc] initWithFrame:CGRectMake(50, 200, 200, 50)];
[self.view addSubview:submitView];

// 设置代理
submitView.delegate = self;

// 设置标题
[submitView setupSubmitViewTitle:@"提交"];
```

### 配置块初始化（推荐）

```objc
DMSubmitView *submitView = [[DMSubmitView alloc] initWithFrame:CGRectMake(50, 200, 200, 50) configuration:^(DMSubmitView *submitView) {
    // 按钮外观
    submitView.buttonColor = [UIColor systemBlueColor];
    submitView.borderColor = [UIColor systemGrayColor];
    submitView.cornerRadius = 25;
    
    // 文本配置
    submitView.buttonText = @"提交订单";
    submitView.buttonTextColor = [UIColor whiteColor];
    submitView.buttonTextFont = [UIFont boldSystemFontOfSize:16];
    
    // 进度环配置
    submitView.progressColor = [UIColor systemGreenColor];
    submitView.progressTrackColor = [UIColor systemGray5Color];
    submitView.progressLineWidth = 4.0;
    
    // 动画配置
    submitView.scaleAnimationDuration = 0.8;
    submitView.expandAnimationDuration = 1.2;
}];
```

## 高级配置

### 按钮外观配置

```objc
// 基础颜色
submitView.buttonColor = [UIColor systemBlueColor];
submitView.borderColor = [UIColor systemGrayColor];
submitView.borderWidth = 2.0;

// 圆角和阴影
submitView.cornerRadius = 25;
submitView.shadowColor = [UIColor blackColor];
submitView.shadowOffset = CGSizeMake(0, 2);
submitView.shadowRadius = 4.0;
submitView.shadowOpacity = 0.3;
```

### 文本配置

```objc
// 按钮文本
submitView.buttonText = @"提交订单";
submitView.buttonTextColor = [UIColor whiteColor];
submitView.buttonTextFont = [UIFont boldSystemFontOfSize:16];

// 完成状态文本
submitView.completionText = @"完成";
submitView.completionTextColor = [UIColor systemGreenColor];
```

### 进度环配置

```objc
// 进度环样式
submitView.progressColor = [UIColor systemGreenColor];
submitView.progressTrackColor = [UIColor systemGray5Color];
submitView.progressLineWidth = 4.0;
submitView.progressRadius = 20.0;
submitView.showsProgressTrack = YES;
```

### 动画配置

```objc
// 动画参数
submitView.scaleAnimationDuration = 0.8;
submitView.expandAnimationDuration = 1.2;
submitView.animated = YES;
```

## 进度控制

### 更新进度

```objc
// 使用数据更新进度
[submitView updateProgressViewWitCurrenthData:50 totalData:100];

// 直接设置进度值
[submitView setProgress:0.75 animated:YES];
```

### 状态控制

```objc
// 重置为初始状态
[submitView resetToInitialState:YES];

// 手动触发完成
[submitView triggerCompletion:YES];

// 开始/停止显示进度
[submitView startShowingProgress:YES];
[submitView stopShowingProgress:YES];
```

## 代理方法

```objc
@interface ViewController () <DMSubmitViewDelegate>
@end

@implementation ViewController

- (void)submitViewButtonDidClick {
    NSLog(@"按钮被点击");
    // 开始模拟进度更新
    [self simulateProgress];
}

- (void)submitViewStartShowProgressViewStatus {
    NSLog(@"开始显示进度");
}

- (void)submitViewDidUpdateProgress:(CGFloat)progress {
    NSLog(@"进度更新: %.2f", progress);
}

- (void)submitViewDidComplete {
    NSLog(@"提交完成");
}

- (void)simulateProgress {
    // 模拟进度更新
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i <= 100; i += 10) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.submitView updateProgressViewWitCurrenthData:i totalData:100];
            });
            [NSThread sleepForTimeInterval:0.2];
        }
    });
}

@end
```

## 组件详解

### DMProgressView

独立的进度环组件，支持：
- 自定义颜色和线宽
- 动画控制
- 进度回调
- 背景环显示控制

```objc
DMProgressView *progressView = [[DMProgressView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) configuration:^(DMProgressView *progressView) {
    progressView.radius = 40;
    progressView.lineWidth = 4;
    progressView.progressColor = [UIColor systemBlueColor];
    progressView.trackColor = [UIColor systemGray5Color];
    progressView.animationDuration = 0.3;
    progressView.delegate = self;
}];
```

### DMSubmitButton

可定制的按钮组件，支持：
- 多种状态颜色
- 点击动画
- 阴影效果
- 边框样式

```objc
DMSubmitButton *button = [DMSubmitButton createSubmitButtonWithFrame:CGRectMake(0, 0, 200, 50) configuration:^(DMSubmitButton *button) {
    button.buttonColor = [UIColor systemBlueColor];
    button.borderColor = [UIColor systemGrayColor];
    button.cornerRadius = 25;
    button.touchAnimationEnabled = YES;
}];
```

### DMSubmitLabel

文本标签组件，支持：
- 默认和完成状态文本
- 点击动画
- 完成图标
- 自定义字体和颜色

```objc
DMSubmitLabel *label = [DMSubmitLabel createSubmitLabelWithFrame:CGRectMake(0, 0, 200, 50) configuration:^(DMSubmitLabel *label) {
    label.defaultText = @"提交";
    label.completionText = @"完成";
    label.showsCompletionIcon = YES;
    label.completionIconColor = [UIColor whiteColor];
}];
```

## 最佳实践

### 1. 使用配置块初始化
配置块提供了更清晰的代码结构和更好的可读性。

### 2. 合理设置动画时长
根据用户体验调整动画时长，通常 0.8-1.2 秒比较合适。

### 3. 颜色搭配
使用系统颜色或遵循设计规范的颜色搭配，确保良好的视觉效果。

### 4. 进度更新频率
避免过于频繁的进度更新，建议间隔 0.1-0.3 秒。

### 5. 内存管理
在视图控制器销毁时，将代理设置为 nil。

## 版本历史

### v2.0.0 (当前版本)
- 完全重构，提升性能和可维护性
- 添加配置块初始化方式
- 增强可定制化能力
- 优化动画效果
- 完善文档和示例

### v1.0.0
- 初始版本
- 基础功能实现

## 许可证

MIT License

## 贡献

欢迎提交 Issue 和 Pull Request！

## 联系方式

如有问题或建议，请通过以下方式联系：
- 提交 GitHub Issue
- 发送邮件至开发者

---

**注意**: 本框架需要 iOS 8.0 或更高版本。
