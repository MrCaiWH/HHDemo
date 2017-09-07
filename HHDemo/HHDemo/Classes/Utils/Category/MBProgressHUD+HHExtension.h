//
//  MBProgressHUD+HHExtension.h
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/3/15.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (HHExtension)
/**
 加载中 用于一些网络加载过程中不可点击返回操作
 */
+(void)show;

/**
 弹出提示信息
 
 @param message 提示信息
 */
+(void)showHintMessage:(NSString *)message;

/**
 持续显示菊花
 @param message 提示信息
 */
+(void)showStatusWithMessage:(NSString *)message;

/**
 关闭当前的MBProgressHUD
 */
+ (void)hideHUD;
@end
