//
//  HHSortTool.h
//  HHDemo
//
//  Created by zero on 2017/7/4.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHSortTool : NSObject

//快速排序
+ (void)quickSort:(NSMutableArray *)array low:(int)low high:(int)high;

//冒泡排序
+ (void)buddleSort:(NSMutableArray *)array;

//选择排序
+ (void)selectSort:(NSMutableArray *)array;

//插入排序
+ (void)inserSort:(NSMutableArray *)array;

//打印数组
+ (void)printArray:(NSArray *)array;

@end
