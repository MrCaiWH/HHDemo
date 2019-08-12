//
//  HHUserManager.h
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/9/8.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHUserInfo.h"

typedef NS_ENUM(NSUInteger, HHUserLoginType){
    /** 未知 */
    HHUserLoginTypeUnKnow = 0,
    /** 微信登录 */
    HHUserLoginTypeWeChat,
    /** QQ登录 */
    HHUserLoginTypeQQ,
    /** 账号登录 */
    HHUserLoginTypePwd
};

typedef void (^HHloginBlock)(BOOL success, NSString *des);

#define KUserManager [HHUserManager sharedUserManager]

@interface HHUserManager : NSObject
/** 当前用户信息 */
@property (nonatomic, strong, readonly) HHUserInfo *curUserInfo;
/** 登录类型 */
@property (nonatomic, assign, readonly) HHUserLoginType loginType;
/** 是否登录 */
@property (nonatomic, assign, getter = isLogined, readonly) BOOL logined;

+ (instancetype)sharedUserManager;

/**
 三方登录
 
 @param loginType 登录方式
 @param completion 回调
 */
- (void)login:(HHUserLoginType)loginType completion:(HHloginBlock)completion;

/**
 带参登录
 
 @param loginType 登录方式
 @param params 参数，手机和账号登录需要
 @param completion 回调
 */
- (void)login:(HHUserLoginType)loginType params:(NSDictionary *)params completion:(HHloginBlock)completion;

/**
 自动登录
 
 @param completion 回调
 */
- (void)autoLoginToServer:(HHloginBlock)completion;

/**
 退出登录
 
 @param completion 回调
 */
- (void)logout:(HHloginBlock)completion;

/**
 加载缓存用户数据
 
 @return 是否成功
 */
- (BOOL)loadUserInfo;

@end
