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

- (id)requestArgument {
    return @{
             @"phone": @"18811108252",
             @"password": @"11111111"
             };
}

- (NSDictionary *)requestHeaderFieldValueDictionary {
    NSDictionary *headerDictionary=@{@"v":@"1-2-2.2.1-1-99"};
    return headerDictionary;
}

@end
