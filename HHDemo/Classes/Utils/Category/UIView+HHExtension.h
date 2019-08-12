//
//  UIView+HHExtension.h
//  HHDemo
//
//  Created by zero on 2017/3/15.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HHExtension)

@property (nonatomic, assign) CGFloat hh_x;
@property (nonatomic, assign) CGFloat hh_y;
@property (nonatomic, assign) CGFloat hh_width;
@property (nonatomic, assign) CGFloat hh_height;
@property (nonatomic, assign) CGFloat hh_centerX;
@property (nonatomic, assign) CGFloat hh_centerY;
@property (nonatomic, assign) CGSize  hh_size;
@property (nonatomic, assign) CGPoint hh_origin;

+ (instancetype)hh_viewFromXib;

@end
