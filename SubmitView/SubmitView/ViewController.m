//
//  ViewController.m
//  SubmitView
//
//  Created by David on 16/2/22.
//  Copyright © 2016年 com.david. All rights reserved.
//


#import "ViewController.h"
#import "SubmitView.h"

@interface ViewController ()

@end

@implementation ViewController{
    SubmitView *sub;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self newSubmitView];
}

- (void)newSubmitView {
    sub = [[SubmitView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
    [sub setDownloadUrl:@"https://avatars1.githubusercontent.com/u/12080954?v=3&s=460"];
    sub.center = self.view.center;
    [self.view addSubview:sub];
}

- (IBAction)click:(id)sender {
    [sub removeFromSuperview];
    [self newSubmitView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
