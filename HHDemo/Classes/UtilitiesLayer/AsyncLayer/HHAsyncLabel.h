//
//  HHAsyncLabel.h
//  HHTool
//
//  Created by wanhong cai on 2019/8/12.
//  Copyright © 2019 koolearn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHAsyncLabel : UIView

//设置文字内容
@property(nonatomic, copy) NSString *text;
//设置字体
@property(nonatomic, strong) UIFont *font;

@end

NS_ASSUME_NONNULL_END
