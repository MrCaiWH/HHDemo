//
//  HHThirdPartService.m
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/8/23.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHThirdPartService.h"
#import <Bugly/Bugly.h>

@implementation HHThirdPartService

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //异常检测，Crash收集
        [Bugly startWithAppId:@"005c4ad1be"];
        
        NSLog(@"第三方服务注册完毕");
    });
}

@end
