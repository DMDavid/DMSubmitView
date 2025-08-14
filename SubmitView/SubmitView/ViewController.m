//
//  ViewController.m
//  SubmitView
//
//  Created by David on 16/2/22.
//  Copyright © 2016年 com.david. All rights reserved.
//


#import "ViewController.h"
#import "DMSubmitView.h"

@interface ViewController () <DMSubmitViewDelegate>

@property (nonatomic, strong) DMSubmitView *basicSubmitView;
@property (nonatomic, strong) DMSubmitView *customSubmitView;
@property (nonatomic, strong) DMSubmitView *animatedSubmitView;
@property (nonatomic, strong) UIButton *resetButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.title = @"DMSubmitView 示例";
    
    [self setupBasicSubmitView];
    [self setupCustomSubmitView];
    [self setupAnimatedSubmitView];
    [self setupResetButton];
}

#pragma mark - 基础示例

- (void)setupBasicSubmitView {
    // 基础用法示例
    self.basicSubmitView = [[DMSubmitView alloc] initWithFrame:CGRectMake(50, 100, 200, 50)];
    self.basicSubmitView.delegate = self;
    [self.basicSubmitView setupSubmitViewTitle:@"基础示例"];
    [self.view addSubview:self.basicSubmitView];
    
    // 添加说明标签
    UILabel *basicLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 70, 200, 20)];
    basicLabel.text = @"基础用法";
    basicLabel.font = [UIFont systemFontOfSize:14];
    basicLabel.textColor = [UIColor systemGrayColor];
    [self.view addSubview:basicLabel];
}

#pragma mark - 自定义示例

- (void)setupCustomSubmitView {
    // 自定义样式示例
    self.customSubmitView = [[DMSubmitView alloc] initWithFrame:CGRectMake(50, 200, 200, 50) configuration:^(DMSubmitView *submitView) {
        // 按钮外观
        submitView.buttonColor = [UIColor systemBlueColor];
        submitView.borderColor = [UIColor systemGrayColor];
        submitView.cornerRadius = 25;
        submitView.shadowColor = [UIColor blackColor];
        submitView.shadowOffset = CGSizeMake(0, 2);
        submitView.shadowRadius = 4.0;
        submitView.shadowOpacity = 0.3;
        
        // 文本配置
        submitView.buttonText = @"自定义样式";
        submitView.buttonTextColor = [UIColor whiteColor];
        submitView.buttonTextFont = [UIFont boldSystemFontOfSize:16];
        submitView.completionText = @"完成";
        submitView.completionTextColor = [UIColor systemGreenColor];
        
        // 进度环配置
        submitView.progressColor = [UIColor systemGreenColor];
        submitView.progressTrackColor = [UIColor systemGray5Color];
        submitView.progressLineWidth = 4.0;
        submitView.showsProgressTrack = YES;
        
        // 动画配置
        submitView.scaleAnimationDuration = 0.8;
        submitView.expandAnimationDuration = 1.2;
    }];
    self.customSubmitView.delegate = self;
    [self.view addSubview:self.customSubmitView];
    
    // 添加说明标签
    UILabel *customLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 170, 200, 20)];
    customLabel.text = @"自定义样式";
    customLabel.font = [UIFont systemFontOfSize:14];
    customLabel.textColor = [UIColor systemGrayColor];
    [self.view addSubview:customLabel];
}

#pragma mark - 动画示例

- (void)setupAnimatedSubmitView {
    // 动画效果示例
    self.animatedSubmitView = [[DMSubmitView alloc] initWithFrame:CGRectMake(50, 300, 200, 50) configuration:^(DMSubmitView *submitView) {
        // 按钮外观
        submitView.buttonColor = [UIColor systemPurpleColor];
        submitView.borderColor = [UIColor systemPurpleColor];
        submitView.cornerRadius = 25;
        
        // 文本配置
        submitView.buttonText = @"动画效果";
        submitView.buttonTextColor = [UIColor whiteColor];
        submitView.buttonTextFont = [UIFont boldSystemFontOfSize:16];
        submitView.completionText = @"你好";
        submitView.completionTextColor = [UIColor whiteColor];
        
        // 进度环配置
        submitView.progressColor = [UIColor systemYellowColor];
        submitView.progressTrackColor = [UIColor systemGray6Color];
        submitView.progressLineWidth = 5.0;
        submitView.showsProgressTrack = YES;
        
        // 动画配置
        submitView.scaleAnimationDuration = 1.0;
        submitView.expandAnimationDuration = 1.5;
    }];
    self.animatedSubmitView.delegate = self;
    [self.view addSubview:self.animatedSubmitView];
    
    // 添加说明标签
    UILabel *animatedLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 270, 200, 20)];
    animatedLabel.text = @"动画效果";
    animatedLabel.font = [UIFont systemFontOfSize:14];
    animatedLabel.textColor = [UIColor systemGrayColor];
    [self.view addSubview:animatedLabel];
}

#pragma mark - 重置按钮

- (void)setupResetButton {
    self.resetButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.resetButton.frame = CGRectMake(50, 400, 200, 50);
    [self.resetButton setTitle:@"重置所有状态" forState:UIControlStateNormal];
    self.resetButton.backgroundColor = [UIColor systemGray5Color];
    self.resetButton.layer.cornerRadius = 25;
    [self.resetButton addTarget:self action:@selector(resetAllStates) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.resetButton];
}

#pragma mark - 事件处理

- (void)resetAllStates {
    // 在动画执行过程中，立即重置到原始状态
    [self.basicSubmitView resetToInitialState:NO];
    [self.customSubmitView resetToInitialState:NO];
    [self.animatedSubmitView resetToInitialState:NO];
}

#pragma mark - DMSubmitViewDelegate

- (void)submitViewButtonDidClick {
    NSLog(@"按钮被点击");
}

- (void)submitViewStartShowProgressViewStatus {
    NSLog(@"开始显示进度");
    
    // 根据不同的提交视图执行不同的进度模拟
    if (self.basicSubmitView.isShowingProgress) {
        [self simulateBasicProgress];
    } else if (self.customSubmitView.isShowingProgress) {
        [self simulateCustomProgress];
    } else if (self.animatedSubmitView.isShowingProgress) {
        [self simulateAnimatedProgress];
    }
}

- (void)submitViewDidUpdateProgress:(CGFloat)progress {
    NSLog(@"进度更新: %.2f", progress);
}

- (void)submitViewDidComplete {
    NSLog(@"提交完成");
}

#pragma mark - 进度模拟

- (void)simulateBasicProgress {
    // 基础进度模拟 - 快速完成
    NSLog(@"开始基础进度模拟");
    [self.basicSubmitView updateProgressViewWitCurrenthData:50 totalData:100];
    
    // 延迟后测试100%
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.basicSubmitView updateProgressViewWitCurrenthData:100 totalData:100];
    });
}

- (void)simulateCustomProgress {
    [self.customSubmitView updateProgressViewWitCurrenthData:50 totalData:100];
    
    // 延迟后测试100%
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.customSubmitView updateProgressViewWitCurrenthData:100 totalData:100];
    });
}

- (void)simulateAnimatedProgress {
    [self.animatedSubmitView updateProgressViewWitCurrenthData:50 totalData:100];
    
    // 延迟后测试100%
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.animatedSubmitView updateProgressViewWitCurrenthData:100 totalData:100];
    });
}

@end
