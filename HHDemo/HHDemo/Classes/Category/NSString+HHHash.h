//
//  NSString+HHHash.h
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/3/14.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HHHash)
@property (nonatomic, readonly, copy) NSString *hh_md5String;
@property (nonatomic, readonly, copy) NSString *hh_sha1String;
@property (nonatomic, readonly, copy) NSString *hh_sha256String;
@property (nonatomic, readonly, copy) NSString *hh_sha512String;

- (NSString *)hh_hmacSHA1StringWithKey:(NSString *)key;
- (NSString *)hh_hmacSHA256StringWithKey:(NSString *)key;
- (NSString *)hh_hmacSHA512StringWithKey:(NSString *)key;
@end
