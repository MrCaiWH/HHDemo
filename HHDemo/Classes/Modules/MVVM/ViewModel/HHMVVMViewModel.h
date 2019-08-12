//
//  HHMVVMViewModel.h
//  HHDemo
//
//  Created by zero on 2017/8/24.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHMVVMViewModel : NSObject
/**
 刷新结束信号
 */
@property (nonatomic, strong) RACSubject *refreshEndSubject;

/**
 下拉刷新Command
 */
@property (nonatomic, strong) RACCommand *loadLatestDataCommand;

/**
 上拉加载Command
 */
@property (nonatomic, strong) RACCommand *loadMoreDataCommand;
/**
 所有数据的集合
 */
@property (nonatomic, strong) NSMutableArray *dataArray;

/**
 当前数据集合大小
 */
@property (nonatomic, assign) NSInteger dataArrayCount;
@end
