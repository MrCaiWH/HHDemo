//
//  ZOItem.m
//  HHDemo
//
//  Created by 蔡万鸿 on 2016/11/11.
//  Copyright © 2016年 黄花菜. All rights reserved.
//

#import "ZOItem.h"

@implementation ZOItem

- (instancetype)initWithTitle:(NSString *)title  targetVc:(Class)targetVc
{
    if (self = [super init]) {
        self.title = title;
        self.targetVc = targetVc;
    }
    return self;
}

@end
