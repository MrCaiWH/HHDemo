//
//  HHWeakObject.m
//  HHTool
//
//  Created by wanhong cai on 2019/8/12.
//  Copyright © 2019 koolearn. All rights reserved.
//

#import "HHWeakObject.h"

@interface HHWeakObject()

@property (weak, nonatomic) id weakObject;

@end

@implementation HHWeakObject

- (instancetype)initWithWeakObject:(id)obj {
    _weakObject = obj;
    return self;
}

+ (instancetype)proxyWithWeakObject:(id)obj {
    return [[HHWeakObject alloc] initWithWeakObject:obj];
}

/**
 * 消息转发，对象转发，让_weakObject响应事件
 */
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return _weakObject;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    void *null = NULL;
    [invocation setReturnValue:&null];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [_weakObject respondsToSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    return [NSObject instanceMethodSignatureForSelector:@selector(init)];
}

- (Class)class {
    return [_weakObject class];
}

- (Class)superclass {
    return [_weakObject superclass];
}

- (BOOL)isKindOfClass:(Class)aClass {
    return [_weakObject isKindOfClass:aClass];
}

- (BOOL)isMemberOfClass:(Class)aClass {
    return [_weakObject isMemberOfClass:aClass];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}


@end
