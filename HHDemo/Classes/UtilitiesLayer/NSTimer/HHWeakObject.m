//
//  HHWeakObject.m
//  HHTool
//
//  Created by wanhong cai on 2019/8/12.
//  Copyright © 2019 koolearn. All rights reserved.
//

#import "HHWeakObject.h"

@interface HHWeakObject()

@property (weak, nonatomic) id target;

@end

@implementation HHWeakObject

+ (instancetype)proxyWithTarget:(id)target {
    HHWeakObject *proxy = [[HHWeakObject alloc] init];
    proxy.target = target;
    return proxy;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.target;
}

@end
