//
//  ZOItem.h
//  HHDemo
//
//  Created by 蔡万鸿 on 2016/11/11.
//  Copyright © 2016年 黄花菜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZOItem : NSObject
// 标题
@property (nonatomic,copy)NSString *title;

// 为ArrowItem模型增加一个目标控制器类型的属性
@property (nonatomic, assign) Class targetVc;

- (instancetype)initWithTitle:(NSString *)title  targetVc:(Class)targetVc;
@end
