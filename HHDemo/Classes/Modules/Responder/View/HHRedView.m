//
//  HHRedView.m
//  HHDemo
//
//  Created by zero on 2017/3/16.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHRedView.h"

@implementation HHRedView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    for(UIView *subView in self.subviews)
    {
        if(CGRectContainsPoint(subView.frame, point))
        {
            return YES;
        }
    }
    return NO;
}

@end
