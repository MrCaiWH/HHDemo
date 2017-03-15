//
//  HHLanguageTool.h
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/3/15.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import <Foundation/Foundation.h>

/** APP语言环境 */
UIKIT_EXTERN NSString * const language;
/** 切换APP语言通知 */
UIKIT_EXTERN NSString * const HHSwitchAPPLanguageNotification;

/** APP语言类型 */
typedef NS_ENUM(NSUInteger, HHLanguageType) {
    /** 根据系统语言决定 */
    HHLanguageTypeSystem,
    /** 简体中文 */
    HHLanguageTypeZHHans,
    /** 英文 */
    HHLanguageTypeEN,
    /** 日语 */
    HHLanguageTypeJan,
    /** 韩文 */
    HHLanguageTypeKorean,
    /** 台湾繁体 */
    HHLanguageTypeTraditionalTaiwan,
    /** 香港繁体 */
    HHLanguageTypeTraditionalHongKong,
    /** 法语 */
    HHLanguageTypeFranch,
};

@interface HHLanguageTool : NSObject
+ (NSString *)dpLocalizedString:(NSString *)translation_key;
/**
 *  获得当前APP语言
 *
 *  @return 语言类型
 */
+ (HHLanguageType)currentAPPLanguageType;

/**
 *  获得当前APP语言key
 *
 *  @return 语言类型key
 */
+ (NSString *)currentAPPLanguageTypeKey;
@end
