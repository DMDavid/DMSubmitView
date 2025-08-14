//
//  CompletionDisplayExample.m
//  SubmitView
//
//  Created for demonstrating completion display logic
//

#import <Foundation/Foundation.h>
#import "DMSubmitView.h"

@interface CompletionDisplayExample : NSObject

+ (void)demonstrateCompletionDisplay;

@end

@implementation CompletionDisplayExample

+ (void)demonstrateCompletionDisplay {
    NSLog(@"=== 完成显示逻辑演示 ===");
    
    // 示例1: 显示对号图标（无completionText）
    NSLog(@"示例1: 显示对号图标");
    DMSubmitView *view1 = [[DMSubmitView alloc] initWithFrame:CGRectMake(0, 0, 200, 50) configuration:^(DMSubmitView *submitView) {
        submitView.buttonText = @"提交";
        submitView.completionText = @""; // 空字符串，显示对号图标
        submitView.completionTextColor = [UIColor whiteColor];
    }];
    
    // 示例2: 显示文本（有completionText）
    NSLog(@"示例2: 显示文本");
    DMSubmitView *view2 = [[DMSubmitView alloc] initWithFrame:CGRectMake(0, 0, 200, 50) configuration:^(DMSubmitView *submitView) {
        submitView.buttonText = @"提交";
        submitView.completionText = @"完成"; // 有文本，显示文本
        submitView.completionTextColor = [UIColor whiteColor];
    }];
    
    // 示例3: 显示自定义文本
    NSLog(@"示例3: 显示自定义文本");
    DMSubmitView *view3 = [[DMSubmitView alloc] initWithFrame:CGRectMake(0, 0, 200, 50) configuration:^(DMSubmitView *submitView) {
        submitView.buttonText = @"提交";
        submitView.completionText = @"成功"; // 自定义文本
        submitView.completionTextColor = [UIColor greenColor];
    }];
    
    NSLog(@"使用说明:");
    NSLog(@"1. 设置 completionText = @\"\" 时，完成时显示对号图标");
    NSLog(@"2. 设置 completionText = @\"文本\" 时，完成时显示文本");
    NSLog(@"3. 可以动态修改 completionText 来切换显示方式");
}

@end
