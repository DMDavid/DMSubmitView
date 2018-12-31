//
//  SubmitButton.h
//  SubmitAnimation
//
//  Created by David on 16/2/22.
//  Copyright © 2016年 com.david. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DMSubmitButton : UIButton

//init mothod
+ (instancetype)creatSubmitButtonWithFrame:(CGRect)frame;

//set button color
- (void)setupSubmitButtonColor:(UIColor *)buttonColor;

//set button bold color
- (void)setupSubmitButtonBoldColor:(UIColor *)buttonBlodColor;

//hidden submitButton
- (void)setHiddenSubmitButton;

//show submitButton
- (void)setShowSubmitButton;

@end
