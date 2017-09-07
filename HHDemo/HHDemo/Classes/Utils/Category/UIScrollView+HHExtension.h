//
//  UIScrollView+HHExtension.h
//  HHDemo
//
//  Created by zero on 2017/8/24.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@interface UIScrollView (HHExtension)

/**
 *  下拉刷新
 */
- (void)hh_headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;

/**
 *  上拉加载
 */
- (void)hh_footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;

/**
 * MJRefresh下拉刷新国际化
 */
-(void)hh_changeMJRefreshTextLanguage;

/**
 开始刷新
 */
-(void)hh_beginRefreshing;

/**
 结束刷新
 */
-(void)hh_endRefreshing;


@end
