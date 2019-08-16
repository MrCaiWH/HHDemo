//
//  HHWeakProxy.h
//  HHDemo
//
//  Created by wanhong cai on 2019/8/16.
//  Copyright © 2019 huanghuacai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHWeakProxy : NSProxy
+(instancetype)proxyWithTarget:(id)target;
@end

NS_ASSUME_NONNULL_END
