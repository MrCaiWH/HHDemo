//
//  HHViewModelConstant.h
//  HHDemo
//
//  Created by zero on 2017/8/24.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#ifndef HHViewModelConstant_h
#define HHViewModelConstant_h

/** 刷新控件的状态 */
typedef NS_ENUM(NSInteger, HHRefreshState) {
    HHHeaderRefresh_HasMoreData,        //header还有更多数据
    HHHeaderRefresh_NoMoreData,         //header没有更多数据
    HHFooterRefresh_HasMoreData,        //footer还有更多数据
    HHFooterRefresh_NoMoreData,         //footer没有更多数据
    HHRefreshError,                     //刷新出错
};

#endif /* HHViewModelConstant_h */
