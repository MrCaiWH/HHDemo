//
//  UIViewController+HHExtension.m
//  HHDemo
//
//  Created by zero on 2017/3/15.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "UIViewController+HHExtension.h"
#import "HHHookTool.h"

@implementation UIViewController (HHExtension)

+(void)load {
    [HHHookTool swizzlingInClass:[self class] originalSelector:@selector(viewDidLoad) swizzledSelector:@selector(hh_viewDidLoad)];
    [HHHookTool swizzlingInClass:[self class] originalSelector:@selector(viewWillAppear:) swizzledSelector:@selector(hh_viewWillAppear:)];
}

-(void)hh_viewDidLoad {
    
    NSLog(@"%s",__func__);
    [self hh_viewDidLoad];
}

-(void)hh_viewWillAppear:(BOOL)animated {
    
    NSLog(@"%s",__func__);
    
    HHCurrentVC = self;
    [self hh_viewWillAppear:animated];
}

@end
