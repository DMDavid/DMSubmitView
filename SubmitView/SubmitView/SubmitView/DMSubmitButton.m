//
//  SubmitButton.m
//  SubmitAnimation
//
//  Created by David on 16/2/22.
//  Copyright © 2016年 com.david. All rights reserved.
//

#import "DMSubmitButton.h"

@implementation DMSubmitButton {
    UIColor *_buttonColor;
    UIColor *_blodColor;
}

+ (instancetype)creatSubmitButtonWithFrame:(CGRect)frame {
    DMSubmitButton *submitBtn = [[DMSubmitButton alloc] initWithFrame:frame];
    return submitBtn;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = _buttonColor;
        self.layer.cornerRadius = self.bounds.size.height/2;;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setupSubmitButtonColor:(UIColor *)buttonColor {
    _buttonColor = buttonColor;
    self.backgroundColor = _buttonColor;
}

- (void)setupSubmitButtonBoldColor:(UIColor *)buttonBlodColor {
    _blodColor = buttonBlodColor;
    self.layer.borderColor = _blodColor.CGColor;
}

- (void)setHiddenSubmitButton {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderWidth = 2;
    self.layer.borderColor = _blodColor.CGColor;
}

- (void)setShowSubmitButton {
    self.hidden = NO;
    self.backgroundColor = _buttonColor;
    self.layer.borderWidth = 0;
}

@end

