//
//  TestResetBug.m
//  SubmitView
//
//  Created for testing resetToInitialState bug fix
//

#import <Foundation/Foundation.h>
#import "DMSubmitView.h"

@interface TestResetBug : NSObject

+ (void)testResetDuringAnimation;

@end

@implementation TestResetBug

+ (void)testResetDuringAnimation {
    NSLog(@"开始测试动画过程中的重置功能");
    
    // 创建测试视图
    DMSubmitView *testView = [[DMSubmitView alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    
    // 模拟点击按钮开始动画
    NSLog(@"1. 模拟点击按钮开始动画");
    [testView.submitButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    // 等待一小段时间让动画开始
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"2. 动画进行中，调用重置方法");
        
        // 在动画过程中调用重置
        [testView resetToInitialState:NO];
        
        // 验证状态
        NSLog(@"3. 验证重置结果:");
        NSLog(@"   - isShowingProgress: %@", testView.isShowingProgress ? @"YES" : @"NO");
        NSLog(@"   - isCompleted: %@", testView.isCompleted ? @"YES" : @"NO");
        NSLog(@"   - currentProgress: %.2f", testView.currentProgressFloat);
        NSLog(@"   - button hidden: %@", testView.submitButton.hidden ? @"YES" : @"NO");
        NSLog(@"   - button alpha: %.2f", testView.submitButton.alpha);
        
        if (!testView.isShowingProgress && !testView.isCompleted && 
            testView.currentProgressFloat == 0.0 && 
            !testView.submitButton.hidden && 
            testView.submitButton.alpha == 1.0) {
            NSLog(@"✅ 测试通过：视图成功重置到初始状态");
        } else {
            NSLog(@"❌ 测试失败：视图状态重置不正确");
        }
    });
}

@end
