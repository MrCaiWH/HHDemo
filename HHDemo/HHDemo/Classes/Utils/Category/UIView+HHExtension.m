//
//  UIView+HHExtension.m
//  HHDemo
//
//  Created by zero on 2017/3/15.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "UIView+HHExtension.h"

@implementation UIView (HHExtension)

- (void)setHh_x:(CGFloat)hh_x {
    CGRect frame = self.frame;
    frame.origin.x = hh_x;
    self.frame = frame;
}

- (CGFloat)hh_x {
    return self.frame.origin.x;
}

- (void)setHh_y:(CGFloat)hh_y {
    CGRect frame = self.frame;
    frame.origin.y = hh_y;
    self.frame = frame;
}

- (CGFloat)hh_y {
    return self.frame.origin.y;
}

- (void)setHh_centerX:(CGFloat)hh_centerX {
    CGPoint center = self.center;
    center.x = hh_centerX;
    self.center = center;
}

- (CGFloat)hh_centerX {
    return self.center.x;
}

- (void)setHh_centerY:(CGFloat)hh_centerY {
    CGPoint center = self.center;
    center.y = hh_centerY;
    self.center = center;
}

- (CGFloat)hh_centerY {
    return self.center.y;
}

- (void)setHh_width:(CGFloat)hh_width {
    CGRect frame = self.frame;
    frame.size.width = hh_width;
    self.frame = frame;
}

- (void)setHh_height:(CGFloat)hh_height {
    CGRect frame = self.frame;
    frame.size.height = hh_height;
    self.frame = frame;
}

- (CGFloat)hh_height {
    return self.frame.size.height;
}

- (CGFloat)hh_width {
    return self.frame.size.width;
}

- (void)setHh_size:(CGSize)hh_size {
    CGRect frame = self.frame;
    frame.size = hh_size;
    self.frame = frame;
}

- (CGSize)hh_size {
    return self.frame.size;
}

- (void)setHh_origin:(CGPoint)hh_origin {
    CGRect frame = self.frame;
    frame.origin = hh_origin;
    self.frame = frame;
}

- (CGPoint)hh_origin {
    return self.frame.origin;
}

+ (instancetype)hh_viewFromXib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
@end
