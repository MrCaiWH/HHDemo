//
//  HHDownLoadManager.h
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/3/14.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^successBlock) (NSString *fileStorePath);
typedef void (^faileBlock) (NSError *error);
typedef void (^progressBlock) (float progress);

@interface HHDownLoadManager : NSObject
/**
 下载方法

 @param URL 下载接口
 @param progressBlock 下载进度
 @param successBlock 成功回调
 @param faileBlock 失败回调
 */
-(void)downLoadWithURL:(NSString *)URL
              progress:(progressBlock)progressBlock
               success:(successBlock)successBlock
                 faile:(faileBlock)faileBlock;

/**
 实例化下载对象

 @return 一个单例
 */
+ (instancetype)shareManager;

/**
 停止任务
 */
- (void)stopTask;
@end
