//
//  HHThirdPartService.m
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/8/23.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHThirdPartService.h"
#import <Bugly/Bugly.h>
#import <UMSocialCore/UMSocialCore.h>

@implementation HHThirdPartService

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self registerBugly];

        NSLog(@"第三方服务注册完毕");
    });
}

+ (void)registerBugly {
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
}

+ (void)registerUMSocial {
    
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMengKey];
    
    [self configUSharePlatforms];
}

+ (void)configUSharePlatforms {
    
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:kAppKey_Wechat appSecret:kSecret_Wechat redirectURL:nil];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:kAppKey_Tencent/*设置QQ平台的appID*/  appSecret:nil redirectURL:nil];
}
@end
