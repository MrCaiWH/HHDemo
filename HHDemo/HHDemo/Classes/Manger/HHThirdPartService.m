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
        BuglyConfig *config = [[BuglyConfig alloc] init];
        //非正常退出事件
        config.unexpectedTerminatingDetectionEnable = YES;
        //卡顿监控
        config.blockMonitorEnable = YES;
        //开启SDK日志
        config.debugMode = YES;
        //进程内还原符号
        config.symbolicateInProcessEnable = YES;
        // 自定义config
        [Bugly startWithAppId:@"BUGLY_APP_ID" config:config];
        
        NSLog(@"第三方服务注册完毕");
    });
}

@end
