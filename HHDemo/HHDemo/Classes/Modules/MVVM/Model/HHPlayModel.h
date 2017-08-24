//
//  HHPlayModel.h
//  HHDemo
//
//  Created by zero on 2017/8/24.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHSysUserInfoModel.h"

@interface HHPlayModel : NSObject
@property (nonatomic, copy) NSString *liveId;
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *streamname;
@property (nonatomic, copy) NSString *bannerurl;
@property (nonatomic, copy) NSString *recordurl;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *livetime;
@property (nonatomic, copy) NSString *looknum;
@property (nonatomic, copy) NSString *creattime;
@property (nonatomic, strong) HHSysUserInfoModel *sysUserInfo;
@end
