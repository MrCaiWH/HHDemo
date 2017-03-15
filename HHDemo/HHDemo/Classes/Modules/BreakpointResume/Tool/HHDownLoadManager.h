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
