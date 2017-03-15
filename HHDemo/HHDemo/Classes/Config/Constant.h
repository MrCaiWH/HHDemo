//
//  Constant.h
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/3/14.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

// ------------------------------头文件-------------------------
#import "Masonry.h"
#import "ReactiveCocoa.h"
#import "UIView+HHExtension.h"
#import "UIApplication+HHExtension.h"
#import "MBProgressHUD+HHExtension.h"
#import "UIColor+HHExtend.h"
#import "HHLanguageTool.h"
// ------------------------------宏-------------------------
//竖屏界面宽
#define HHSCREEN_VERTICAL_WIDTH  MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
//竖屏界面高
#define HHSCREEN_VERTICAL_HEIGHT MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
//横屏界面宽
#define HHSCREEN_HORIZONTAL_WIDTH  MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
//横屏界面高
#define HHSCREEN_HORIZONTAL_HEIGHT MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
//RGB色值
#define HHColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
//初始化Image
#define HHIMG(str) [UIImage imageNamed:(str)]
//偏好设置
#define HHUserDefaults [NSUserDefaults standardUserDefaults]
//Document路径
#define HHDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//国际化
#define kString(_KEY)  [HHLanguageTool dpLocalizedString:_KEY]

// release状态下不打印东西，打包状态下提高性能
#if DEBUG
#define NSLog(format, ...) do {                                             \
fprintf(stderr, "<%s : %d> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "-------\n");                                               \
} while (0)
#else
#define NSLog(...)
#endif

#endif /* Constant_h */
