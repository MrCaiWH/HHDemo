//
//  HHItem.h
//  HHDemo
//
//  Created by wanhong cai on 2019/8/12.
//  Copyright © 2019 huanghuacai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHItem : NSObject
// 标题
@property (nonatomic,copy)NSString *title;

// 为ArrowItem模型增加一个目标控制器类型的属性
@property (nonatomic, assign) Class targetVc;

- (instancetype)initWithTitle:(NSString *)title  targetVc:(Class)targetVc;
@end

NS_ASSUME_NONNULL_END
