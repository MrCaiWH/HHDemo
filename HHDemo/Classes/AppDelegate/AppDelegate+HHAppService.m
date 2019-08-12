//
//  AppDelegate+HHAppService.m
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/9/8.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "AppDelegate+HHAppService.h"
#import "HHMainVC.h"
#import "HHMainNavVC.h"
#import "YTKNetwork.h"
#import <AFNetworking/AFNetworking.h>
#import <UMSocialCore/UMSocialCore.h>

@implementation AppDelegate (HHAppService)

#pragma mark ————— 初始化window —————
- (void)initWindow {
    // 1.创建window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    // 2.显示window
    [self.window makeKeyAndVisible];
    
    // 3.显示默认界面
    HHMainVC *mainVC = [[HHMainVC alloc] init];
    HHMainNavVC *navVC = [[HHMainNavVC alloc] initWithRootViewController:mainVC];
    self.window.rootViewController = navVC;
}

#pragma mark ————— 初始化网络请求框架 —————
- (void)initYTKNetwork {
    // 配置安全模式
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = @"https://dobbyapi.zerotech.com";
    config.cdnUrl = @"https://test-dobbyh5.zerotech.com";
}

#pragma mark ————— 友盟 初始化 —————
-(void)initUMeng{
    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMengKey];
    
    [self configUSharePlatforms];
}
#pragma mark ————— 配置第三方 —————
-(void)configUSharePlatforms{
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

#pragma mark ————— OpenURL 回调 —————
// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

@end
