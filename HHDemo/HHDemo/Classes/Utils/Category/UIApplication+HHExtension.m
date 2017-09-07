//
//  UIApplication+HHExtension.m
//  HHDemo
//
//  Created by zero on 2017/3/15.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "UIApplication+HHExtension.h"
#import <objc/runtime.h>

@implementation UIApplication (HHExtension)

-(void)setCurrentController:(UIViewController *)currentController
{
    objc_setAssociatedObject(self, @selector(currentController), currentController, OBJC_ASSOCIATION_RETAIN);
}

-(UIViewController *)currentController
{
    return objc_getAssociatedObject(self, _cmd);
}

+(UIViewController*)rootViewController
{
    return [self sharedApplication].delegate.window.rootViewController;
}


@end
