//
//  LocationManager.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/23.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHLocationManager : NSObject

+ (instancetype)ShareLocation;

/**
 *  经度
 */
@property(nonatomic,readonly,copy)NSString * longitude;
/**
 *  纬度
 */
@property(nonatomic,readonly,copy)NSString * latitude;

@end
