//
//  HHWeakObject.h
//  HHTool
//
//  Created by wanhong cai on 2019/8/12.
//  Copyright © 2019 koolearn. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHWeakObject : NSObject
+ (instancetype)proxyWithTarget:(id)target;
@end

NS_ASSUME_NONNULL_END
