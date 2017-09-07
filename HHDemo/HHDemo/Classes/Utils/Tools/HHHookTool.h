//
//  HHHookTool.h
//  HHDemo
//
//  Created by zero on 2017/3/15.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

//hook工具类

#import <Foundation/Foundation.h>

@interface HHHookTool : NSObject
/**
 交换两个方法
 
 @param cls 当前class
 @param originalSelector originalSelector description
 @param swizzledSelector swizzledSelector description
 @return 返回
 */
+ (BOOL)swizzlingInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;
@end
