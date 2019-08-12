//
//  HHItem.m
//  HHDemo
//
//  Created by wanhong cai on 2019/8/12.
//  Copyright © 2019 huanghuacai. All rights reserved.
//

#import "HHItem.h"

@implementation HHItem

- (instancetype)initWithTitle:(NSString *)title  targetVc:(Class)targetVc {
    if (self = [super init]) {
        self.title = title;
        self.targetVc = targetVc;
    }
    return self;
}

@end
