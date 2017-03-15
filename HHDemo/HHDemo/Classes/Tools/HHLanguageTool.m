//
//  HHLanguageTool.m
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/3/15.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHLanguageTool.h"

/** APP语言环境 */
NSString * const language = @"language";

@implementation HHLanguageTool
+ (NSString *)dpLocalizedString:(NSString *)translation_key {
    
    NSString *languageType;
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSInteger num = [[defaults objectForKey:language] integerValue];
    
    if (num == 0) {
        if ([self isSimpleChinese]) {
            languageType = @"zh-Hans";
            num = 1;
        }
        else if ([self isJan]) {
            languageType = @"ja";
            num = 3;
        }
        else if ([self isKorea]) {
            languageType = @"ko";
            num = 4;
        }
        else if ([self isTaiWan]) {
            languageType = @"zh-Hant-TW";
            num = 5;
        }
        else if ([self isHongKong]) {
            languageType = @"zh-Hant";
            num = 6;
        }
        else if ([self isFrench]) {
            languageType = @"fr";
            num = 7;
        }
        else
        {
            languageType = @"en";
            num = 2;
        }
        [defaults setObject:@(num) forKey:language];
    }
    else if (num == 1) {
        languageType = @"zh-Hans";
    }
    else if (num == 3) {
        languageType = @"ja";
    }
    else if (num == 4) {
        languageType = @"ko";
    }
    else if (num == 5) {
        languageType = @"zh-Hant-TW";
    }
    else if (num == 6) {
        languageType = @"zh-Hant";
    }
    else if (num == 7) {
        languageType = @"fr";
    }
    else {
        languageType = @"en";
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:languageType ofType:@"lproj"];
    NSString *showValue = [[NSBundle bundleWithPath:path] localizedStringForKey:translation_key value:nil table:@"Localizable"];
    
    //如果小语种翻译没有，就是用英文
    if ([showValue isEqualToString:@""] || [showValue isEqualToString:translation_key]) {
        NSString *path1 = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
        showValue = [[NSBundle bundleWithPath:path1] localizedStringForKey:translation_key value:nil table:@"Localizable"];
    }
    
    return showValue;
}

+ (HHLanguageType)currentAPPLanguageType {
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSInteger num = [[defaults objectForKey:language] integerValue];
    
    if (num == 0) {
        if ([self isSimpleChinese]) {
            return HHLanguageTypeZHHans;
        }
        else if ([self isEnglish]){
            return HHLanguageTypeEN;
        }
        else if ([self isJan]) {
            return HHLanguageTypeJan;
        }
        else if ([self isKorea]) {
            return HHLanguageTypeKorean;
        }
        else if ([self isTaiWan]){
            return HHLanguageTypeTraditionalTaiwan;
        }
        else if ([self isHongKong]) {
            return HHLanguageTypeTraditionalHongKong;
        }
        else if ([self isFrench]) {
            return HHLanguageTypeFranch;
        }
    }
    else if (num == 1) {
        return HHLanguageTypeZHHans;
    }
    else if (num == 2) {
        return HHLanguageTypeEN;
    }
    else if (num == 3){
        return HHLanguageTypeJan;
    }
    else if (num == 4){
        return HHLanguageTypeKorean;
    }
    else if (num == 5){
        return HHLanguageTypeTraditionalTaiwan;
    }
    else if (num == 6){
        return HHLanguageTypeTraditionalHongKong;
    }
    else if (num == 7){
        return HHLanguageTypeFranch;
    }
    return HHLanguageTypeZHHans;
}

+ (NSString *)currentAPPLanguageTypeKey {
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSInteger num = [[defaults objectForKey:language] integerValue];
    
    if (num == 0) {
        if ([self isSimpleChinese]) {
            return @"zh-Hans";
        }
        else if ([self isEnglish]) {
            return @"en";
        }
        else if ([self isJan]) {
            return @"ja";
        }
        else if ([self isKorea]) {
            return @"ko";
        }
        else if ([self isTaiWan]) {
            return @"zh-Hant-TW";
        }
        else if ([self isHongKong]) {
            return @"zh-Hant";
        }
        else if ([self isFrench]){
            return @"fr";
        }
    }
    else if (num == 1) {
        return @"zh-Hans";
    }
    else if (num == 2) {
        return @"en";
    }
    else if (num == 3){
        return @"ja";
    }
    else if (num == 4){
        return @"ko";
    }
    else if (num == 5){
        return @"zh-Hant-TW";
    }
    else if (num == 6){
        return @"zh-Hant";
    }
    else if (num == 7){
        return @"fr";
    }
    return @"zh-Hans";
}

//判断是否为中文简体
+ (BOOL)isSimpleChinese {
    NSString *language = [[NSLocale preferredLanguages] firstObject];
    return [language hasPrefix:@"zh-Hans"];
}

//判断是否为英文
+ (BOOL)isEnglish {
    NSString *language = [[NSLocale preferredLanguages] firstObject];
    return [language hasPrefix:@"en"];
}

//判断是否为日语
+ (BOOL)isJan {
    NSString *language = [[NSLocale preferredLanguages] firstObject];
    return [language hasPrefix:@"ja"];
}

//判断是否为韩语
+ (BOOL)isKorea {
    NSString *language = [[NSLocale preferredLanguages] firstObject];
    return [language hasPrefix:@"ko"];
}

//判断是否为台湾繁体
+ (BOOL)isTaiWan {
    NSString *language = [[NSLocale preferredLanguages] firstObject];
    return [language hasPrefix:@"zh-Hant-TW"] || [language hasPrefix:@"zh-TW"];
}

//判断是否为香港繁体
+ (BOOL)isHongKong {
    NSString *language = [[NSLocale preferredLanguages] firstObject];
    return [language hasPrefix:@"zh-Hant-HK"] || [language hasPrefix:@"zh-HK"];
}
//判断是否为法语
+ (BOOL)isFrench {
    NSString *language = [[NSLocale preferredLanguages] firstObject];
    return [language hasPrefix:@"fr"];
}
@end
