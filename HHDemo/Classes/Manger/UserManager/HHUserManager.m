//
//  HHUserManager.m
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/9/8.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHUserManager.h"
#import <UMSocialCore/UMSocialCore.h>

@interface HHUserManager ()
/** 当前用户信息 */
@property (nonatomic, strong, readwrite) HHUserInfo *curUserInfo;
/** 登录类型 */
@property (nonatomic, assign, readwrite) HHUserLoginType loginType;
/** 是否登录 */
@property (nonatomic, assign, getter = isLogined, readwrite) BOOL logined;
@end

@implementation HHUserManager

+ (instancetype)sharedUserManager {
    static HHUserManager *manager = nil;
    static dispatch_once_t oneceToken;
    dispatch_once(&oneceToken, ^{
        manager = [[HHUserManager alloc] init];
    });
    return manager;
}

#pragma mark ————— 三方登录 —————
- (void)login:(HHUserLoginType)loginType completion:(HHloginBlock)completion {
    [self login:loginType params:nil completion:completion];
}

#pragma mark ————— 带参数登录 —————
- (void)login:(HHUserLoginType)loginType params:(NSDictionary *)params completion:(HHloginBlock)completion {
    
    //友盟登录类型
    UMSocialPlatformType platFormType;
    
    if (loginType == HHUserLoginTypeQQ) {
        platFormType = UMSocialPlatformType_QQ;
    }else if (loginType == HHUserLoginTypeWeChat){
        platFormType = UMSocialPlatformType_WechatSession;
    }else{
        platFormType = UMSocialPlatformType_UnKnown;
    }
    //第三方登录
    if (loginType != HHUserLoginTypePwd) {
//        [MBProgressHUD showStatusWithMessage:@"授权中..."];
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:platFormType currentViewController:nil completion:^(id result, NSError *error) {
            if (error) {
//                [MBProgressHUD hideHUD];
                if (completion) {
                    completion(NO,error.localizedDescription);
                }
            } else {
                
                UMSocialUserInfoResponse *resp = result;
                //
                //                // 授权信息
                //                NSLog(@"QQ uid: %@", resp.uid);
                //                NSLog(@"QQ openid: %@", resp.openid);
                //                NSLog(@"QQ accessToken: %@", resp.accessToken);
                //                NSLog(@"QQ expiration: %@", resp.expiration);
                //
                //                // 用户信息
                //                NSLog(@"QQ name: %@", resp.name);
                //                NSLog(@"QQ iconurl: %@", resp.iconurl);
                //                NSLog(@"QQ gender: %@", resp.unionGender);
                //
                //                // 第三方平台SDK源数据
                //                NSLog(@"QQ originalResponse: %@", resp.originalResponse);
                
                //登录参数
                NSDictionary *params = @{@"openid":resp.openid, @"nickname":resp.name, @"photo":resp.iconurl, @"sex":[resp.unionGender isEqualToString:@"男"]?@1:@2, @"cityname":resp.originalResponse[@"city"], @"fr":@(loginType)};
                
                self.loginType = loginType;
                //登录到服务器
                [self loginToServer:params completion:completion];
            }
        }];
    }else{
        //账号登录 暂未提供
    }
}

#pragma mark ————— 手动登录到服务器 —————
- (void)loginToServer:(NSDictionary *)params completion:(HHloginBlock)completion{
    [MBProgressHUD showStatusWithMessage:@"登录中..."];
//    [PPNetworkHelper POST:NSStringFormat(@"%@%@",URL_main,URL_user_login) parameters:params success:^(id responseObject) {
//        [self LoginSuccess:responseObject completion:completion];
//        
//    } failure:^(NSError *error) {
//        [MBProgressHUD hideHUD];
//        if (completion) {
//            completion(NO,error.localizedDescription);
//        }
//    }];
}

#pragma mark ————— 自动登录到服务器 —————
- (void)autoLoginToServer:(HHloginBlock)completion{
//    [PPNetworkHelper POST:NSStringFormat(@"%@%@",URL_main,URL_user_auto_login) parameters:nil success:^(id responseObject) {
//        [self LoginSuccess:responseObject completion:completion];
//        
//    } failure:^(NSError *error) {
//        if (completion) {
//            completion(NO,error.localizedDescription);
//        }
//    }];
}

#pragma mark ————— 登录成功处理 —————
- (void)LoginSuccess:(id )responseObject completion:(HHloginBlock)completion{
    
}

#pragma mark ————— 储存用户信息 —————
- (void)saveUserInfo{

}

#pragma mark ————— 加载缓存的用户信息 —————
- (BOOL)loadUserInfo{
    return NO;
}

#pragma mark ————— 退出登录 —————
- (void)logout:(HHloginBlock)completion {
    
}
@end
