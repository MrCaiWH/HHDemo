//
//  HHSliderView.h
//  HHDemo
//
//  Created by zero on 2017/3/16.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import <UIKit/UIKit.h>

/** slider状态：  */
typedef NS_ENUM(NSUInteger, ZOSliderState) {
    /** 抬起， */
    ZOSliderStateInside,
    /** 按下 */
    ZOSliderStateDown,
    /** 改变中 */
    ZOSliderStateChange
};

@interface HHSliderView : UIView

@end
