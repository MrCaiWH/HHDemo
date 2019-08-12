//
//  HHLoginApi.m
//  HHDemo
//
//  Created by zero on 2017/8/29.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHLoginApi.h"

@implementation HHLoginApi

- (NSString *)requestUrl {
    return kUserLogin;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPOST;
}

- (NSDictionary *)requestArgument {
    return @{
             @"phone": @"18811108252",
             @"password": @"11111111"
             };
}

@end
