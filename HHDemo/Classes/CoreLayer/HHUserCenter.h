//
//  HHUserCenter.h
//  HHDemo
//
//  Created by wanhong cai on 2019/8/15.
//  Copyright © 2019 huanghuacai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHUserCenter : NSObject

- (id)objectForKey:(NSString *)key;

- (void)setObject:(id)obj forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
