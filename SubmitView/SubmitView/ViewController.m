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

@property (nonatomic, strong) DMSubmitView *sub;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ViewController{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self newSubmitView];
    
    [self.sub setupSubmitViewTitle:@"提交"];
}

- (void)newSubmitView {
    _sub = [[DMSubmitView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
    _sub.center = self.view.center;
    _sub.delegate = self;
    [self.view addSubview:_sub];
}

- (IBAction)click:(id)sender {
    [_sub removeFromSuperview];
    [self newSubmitView];
}

#pragma mark -

- (void)submitViewStartShowProgressViewStatus {
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(updateAction) userInfo:nil repeats:YES];
    [_timer fire];
}

static float currentCount = 0.0;

- (void)updateAction {
    
    float totalCount = 10.0;
    
    if (currentCount > totalCount) {
        [_timer invalidate];
        _timer = nil;
        return;
    }
    
    [self.sub updateProgressViewWitCurrenthData:currentCount totalData:totalCount];
    
    currentCount++;
}

@end
