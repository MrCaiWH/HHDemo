//
//  UIApplication+HHExtension.h
//  HHDemo
//
//  Created by zero on 2017/3/15.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HHCurrentVC [UIApplication sharedApplication].currentController

@interface UIApplication (HHExtension)
/**
 *  利用runtime中的associative机制给类扩展添加属性
 */
@property(nonatomic, strong) UIViewController *currentController;

/**
 *  获取跟控制器
 *
 *  @return UIViewController
 */
+(UIViewController*)rootViewController;

@end
