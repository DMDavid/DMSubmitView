//
//  TestCompletionDisplay.m
//  SubmitView
//
//  Created for testing completion display logic
//

#import <Foundation/Foundation.h>
#import "DMSubmitLabel.h"

@interface TestCompletionDisplay : NSObject

+ (void)testCompletionDisplayLogic;

@end

@implementation TestCompletionDisplay

+ (void)testCompletionDisplayLogic {
    NSLog(@"开始测试完成显示逻辑");
    
    // 创建测试标签
    DMSubmitLabel *testLabel = [[DMSubmitLabel alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    
    // 测试1: 没有completionText时显示对号图标
    NSLog(@"测试1: 没有completionText时显示对号图标");
    testLabel.completionText = @"";
    [testLabel showCompletionAnimation:^{
        NSLog(@"   - 文本内容: '%@'", testLabel.text);
        NSLog(@"   - 对号图标存在: %@", testLabel.completionIconLayer ? @"YES" : @"NO");
        
        if (testLabel.text.length == 0 && testLabel.completionIconLayer) {
            NSLog(@"   ✅ 测试1通过：显示对号图标");
        } else {
            NSLog(@"   ❌ 测试1失败");
        }
    }];
    
    // 等待动画完成
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 测试2: 有completionText时显示文本，不显示对号图标
        NSLog(@"测试2: 有completionText时显示文本，不显示对号图标");
        testLabel.completionText = @"完成";
        [testLabel showCompletionAnimation:^{
            NSLog(@"   - 文本内容: '%@'", testLabel.text);
            NSLog(@"   - 对号图标存在: %@", testLabel.completionIconLayer ? @"YES" : @"NO");
            
            if ([testLabel.text isEqualToString:@"完成"] && !testLabel.completionIconLayer) {
                NSLog(@"   ✅ 测试2通过：显示文本，不显示对号图标");
            } else {
                NSLog(@"   ❌ 测试2失败");
            }
        }];
        
        // 等待动画完成
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // 测试3: 动态修改completionText
            NSLog(@"测试3: 动态修改completionText");
            testLabel.completionText = @"";
            
            if (testLabel.text.length == 0 && testLabel.completionIconLayer) {
                NSLog(@"   ✅ 测试3通过：动态切换到对号图标");
            } else {
                NSLog(@"   ❌ 测试3失败");
            }
            
            NSLog(@"所有测试完成");
        });
    });
}

@end
