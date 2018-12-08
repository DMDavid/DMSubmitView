//
//  SubmitButton.h
//  SubmitAnimation
//
//  Created by David on 16/2/22.
//  Copyright © 2016年 com.david. All rights reserved.
//

#import <UIKit/UIKit.h>

#define btnColor [UIColor colorWithRed:33.0/255.0 green:197.0/255.0 blue:131.0/255.0 alpha:1]
#define changedBgColor [UIColor colorWithRed:172.0/255.0 green:172.0/255.0 blue:172.0/255.0 alpha:1]
 

@interface DMSubmitButton : UIButton

+ (instancetype)creatSubmitButtonWithFrame:(CGRect)frame;

- (void)setHiddenSubmitButton;

- (void)setShowSubmitButton;

@end
