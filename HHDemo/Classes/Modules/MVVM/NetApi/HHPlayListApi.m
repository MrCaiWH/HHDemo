//
//  HHPlayListApi.m
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/8/23.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHPlayListApi.h"

@implementation HHPlayListApi

- (id)initWithOneDayOnePlay
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSString *)requestUrl
{
    return ABA_LIVE_PLAY_BACK_URL;
}

- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

@end
