//
//  HHSortTool.m
//  HHDemo
//
//  Created by zero on 2017/7/4.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHSortTool.h"

@implementation HHSortTool
#pragma - mark 快速排序
+ (void)quickSort:(NSMutableArray *)array low:(int)low high:(int)high
{
    if(array == nil || array.count == 0){
        return;
    }
    if (low >= high) {
        return;
    }
    
    //取中值
    int middle = low + (high - low)/2;
    NSNumber *prmt = array[middle];
    int i = low;
    int j = high;
    
    //开始排序，使得left<prmt 同时right>prmt
    while (i <= j) {
        //        while ([array[i] compare:prmt] == NSOrderedAscending) {  该行与下一行作用相同
        while ([array[i] intValue] < [prmt intValue]) {
            i++;
        }
        //        while ([array[j] compare:prmt] == NSOrderedDescending) { 该行与下一行作用相同
        while ([array[j] intValue] > [prmt intValue]) {
            j--;
        }
        
        if(i <= j){
            [array exchangeObjectAtIndex:i withObjectAtIndex:j];
            i++;
            j--;
        }
        
        printf("排序中:");
        [self printArray:array];
    }
    
    if (low < j) {
        [self quickSort:array low:low high:j];
    }
    if (high > i) {
        [self quickSort:array low:i high:high];
    }
}

#pragma - mark 冒泡排序
+ (void)buddleSort:(NSMutableArray *)array
{
    if(array == nil || array.count == 0){
        return;
    }
    
    for (int i = 1; i < array.count; i++) {
        for (int j = 0; j < array.count - i; j++) {
            if ([array[j] compare:array[j+1]] == NSOrderedDescending) {
                [array exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
            
            printf("排序中:");
            [self printArray:array];
        }
    }
    
}

#pragma - mark 选择排序
+ (void)selectSort:(NSMutableArray *)array
{
    if(array == nil || array.count == 0){
        return;
    }
    
    int min_index;
    for (int i = 0; i < array.count; i++) {
        min_index = i;
        for (int j = i + 1; j<array.count; j++) {
            if ([array[j] compare:array[min_index]] == NSOrderedAscending) {
                [array exchangeObjectAtIndex:j withObjectAtIndex:min_index];
            }
            
            printf("排序中:");
            [self printArray:array];
        }
    }
}

#pragma - mark 插入排序
+ (void)inserSort:(NSMutableArray *)array
{
    if(array == nil || array.count == 0){
        return;
    }
    
    for (int i = 0; i < array.count; i++) {
        NSNumber *temp = array[i];
        int j = i-1;
        
        while (j >= 0 && [array[j] compare:temp] == NSOrderedDescending) {
            [array replaceObjectAtIndex:j+1 withObject:array[j]];
            j--;
            
            printf("排序中:");
            [self printArray:array];
        }
        
        [array replaceObjectAtIndex:j+1 withObject:temp];
    }
}

+ (void)printArray:(NSArray *)array
{
    for(NSNumber *number in array) {
        printf("%d ",[number intValue]);
    }
    
    printf("\n");
}
@end
