//
//  UIColor+HHExtend.h
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/3/15.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HHExtend)
/**
 将十六进制颜色的字符串转化为符合iphone/ipad的颜色

 @param hexColor 色值
 @return UIColor
 */
+ (UIColor *)hexChangeFloat:(NSString *)hexColor;
@end
