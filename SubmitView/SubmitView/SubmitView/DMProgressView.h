//
//  ProgressView.h
//  ProgressLayer
//
//  Created by David on 16/2/28.
//  Copyright © 2016年 com.david. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DMProgressViewDelegate <NSObject>
@optional
// the progress circle is completion call back
- (void)progressViewCompletionCallBack;

@end

@interface DMProgressView : UIView

//line width
@property(nonatomic, assign) CGFloat arcLineWith;

//delegate
@property (nonatomic, weak) id <DMProgressViewDelegate> delegate;


/*
 *  init
 */
- (DMProgressView *)initWithProgressViewWithFrame:(CGRect)frame
                                        timeout:(CGFloat)timeout
                                         radius:(CGFloat)radius
                                      layerWith:(CGFloat)layerWith;

/*
 *  更新进度
 */
- (void)updateProgressViewWitCurrenthData:(CGFloat)currentData totalData:(CGFloat)totalData;


@end
