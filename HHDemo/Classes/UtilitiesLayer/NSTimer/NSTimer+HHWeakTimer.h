//
//  NSTimer+HHWeakTimer.h
//  HHTool
//
//  Created by wanhong cai on 2019/8/12.
//  Copyright © 2019 koolearn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (HHWeakTimer)
+ (NSTimer *)hh_scheduledWeakTimerWithTimeInterval:(NSTimeInterval)interval
                                         target:(id)aTarget
                                       selector:(SEL)aSelector
                                       userInfo:(id)userInfo
                                        repeats:(BOOL)repeats;
@end

