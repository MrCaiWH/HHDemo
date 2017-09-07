//
//  HHURLMacros.h
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/9/7.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#ifndef HHURLMacros_h
#define HHURLMacros_h

/*
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */

#define DevelopSever    1
#define TestSever       0
#define ProductSever    0

#if DevelopSever

/**开发服务器*/
#define URL_main @"http://192.168.20.31:20000/shark-miai-service"
//#define URL_main @"http://192.168.11.122:8090" //展鹏

#elif TestSever

/**测试服务器*/
#define URL_main @"http://192.168.20.31:20000/shark-miai-service"

#elif ProductSever

/**生产服务器*/
#define URL_main @"http://192.168.20.31:20000/shark-miai-service"
#endif


// 一天一播中的 直播回放
#define ABA_LIVE_PLAY_BACK_URL @"/userLive/queryUserLiveForHistory"

#define kUserLogin              @"sign/login"           //登录

#endif /* HHURLMacros_h */
