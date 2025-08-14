//
//  DMSubmitViewFramework.m
//  SubmitView
//
//  Created by David on 16/2/19.
//  Copyright © 2016年 com.david. All rights reserved.
//

#import "DMSubmitViewFramework.h"

// 版本号
double DMSubmitViewFrameworkVersionNumber = 2.0;
const unsigned char DMSubmitViewFrameworkVersionString[] = "2.0.0";

@implementation DMSubmitViewFramework

+ (NSString *)version {
    return DM_SUBMIT_VIEW_VERSION;
}

+ (double)versionNumber {
    return DMSubmitViewFrameworkVersionNumber;
}

+ (BOOL)isCompatibleWithCurrentiOSVersion {
    NSString *currentVersion = [[UIDevice currentDevice] systemVersion];
    return [currentVersion compare:@(DM_SUBMIT_VIEW_IOS_VERSION_MIN).stringValue options:NSNumericSearch] != NSOrderedAscending;
}

+ (NSString *)minimumSupportediOSVersion {
    return @(DM_SUBMIT_VIEW_IOS_VERSION_MIN).stringValue;
}

+ (NSDictionary *)frameworkInfo {
    return @{
        @"name": @"DMSubmitView",
        @"version": [self version],
        @"versionNumber": @([self versionNumber]),
        @"minimumSupportediOSVersion": [self minimumSupportediOSVersion],
        @"isCompatibleWithCurrentiOSVersion": @([self isCompatibleWithCurrentiOSVersion]),
        @"buildDate": @(__DATE__),
        @"buildTime": @(__TIME__),
        @"author": @"David",
        @"description": @"A highly customizable iOS submit button animation framework"
    };
}

@end
