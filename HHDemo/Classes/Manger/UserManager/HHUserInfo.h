//
//  HHUserInfo.h
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/9/8.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import <Foundation/Foundation.h>

//性别
typedef NS_ENUM(NSUInteger,HHUserGender){
    /** 未知 */
    HHUserGenderUnKnow = 0,
    /** 男 */
    HHUserGenderMale,
    /** 女 */
    HHUserGenderFemale
};

@interface HHUserInfo : NSObject
/** 用户ID */
@property (nonatomic, assign) long long userid;
/** 头像 */
@property (nonatomic, copy) NSString * photo;
/** 昵称 */
@property (nonatomic, copy) NSString * nickname;
/** 性别 */
@property (nonatomic, assign) HHUserGender sex;
/** 个性签名 */
@property (nonatomic, copy) NSString * signature;
/** 用户登录后分配的登录Token */
@property (nonatomic, copy) NSString * token;

@end
