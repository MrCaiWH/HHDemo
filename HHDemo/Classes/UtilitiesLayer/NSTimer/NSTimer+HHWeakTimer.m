//
//  NSTimer+HHWeakTimer.m
//  HHTool
//
//  Created by wanhong cai on 2019/8/12.
//  Copyright © 2019 koolearn. All rights reserved.
//

#import "NSTimer+HHWeakTimer.h"

@interface HHTimerWeakObject : NSObject
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation HHTimerWeakObject

- (void)fire:(NSTimer *)timer {
    if (self.target) {
        if ([self.target respondsToSelector:self.selector]) {
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self.target performSelector:self.selector withObject:timer.userInfo];
            #pragma clang diagnostic pop
        }
    }
    else{
        [self.timer invalidate];
        _timer = nil;//一定要将_timer置为nil,否则_timer还被runloop强引用，造成内存泄漏
    }
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end

@implementation NSTimer (HHWeakTimer)

+ (NSTimer *)hh_scheduledWeakTimerWithTimeInterval:(NSTimeInterval)interval
                                         target:(id)aTarget
                                       selector:(SEL)aSelector
                                       userInfo:(id)userInfo
                                        repeats:(BOOL)repeats {
    HHTimerWeakObject *object = [[HHTimerWeakObject alloc] init];
    object.target = aTarget;
    object.selector = aSelector;
    object.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:object selector:@selector(fire:) userInfo:userInfo repeats:repeats];
    
    return object.timer;
}


@end
