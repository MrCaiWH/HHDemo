//
//  HHBaseRequest.m
//  HHDemo
//
//  Created by zero on 2017/8/29.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHBaseRequest.h"

@implementation HHBaseRequest

/**
 请求完成预处理
 */
- (void)requestCompletePreprocessor {
    [super requestCompletePreprocessor];
    
    NSLog(@"%s",__func__);
}

/**
 回调成功之前的一些处理
 */
- (void)requestCompleteFilter {
    NSLog(@"%s",__func__);
}

/**
 在真正的回调之前做的处理
 */
- (void)requestFailedFilter {
    NSLog(@"%s",__func__);
}

/**
 请求失败的预处理
 */
- (void)requestFailedPreprocessor {
    NSLog(@"%s",__func__);
}

/**
 请求超时时间
 
 @return 时间
 */
- (NSTimeInterval)requestTimeoutInterval {
    return 15;
}

/**
 请求头添加字段

 @return 请求头
 */
- (NSDictionary *)requestHeaderFieldValueDictionary {
    NSDictionary *headerDictionary=@{@"v":@"1-2-2.2.1-1-99"};
    return headerDictionary;
}

@end
