//
//  HHLoopView.h
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/3/15.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHLoopView : UIView
/**
 *  跑马灯loop速度
 */
@property(nonatomic) float Speed;
/**
 *  显示的内容(支持多条数据)
 */
@property(nonatomic, strong) NSArray *tickerArrs;
/**
 *  设置背景颜色
 */
-(void)setLabelColor:(UIColor *)color;

/**
 *  开启
 */
-(void)start;
@end
