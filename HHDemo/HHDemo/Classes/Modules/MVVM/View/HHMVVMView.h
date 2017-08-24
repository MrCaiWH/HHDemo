//
//  HHRedView.h
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/4/18.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHMVVMViewModel;

@interface HHMVVMView : UIView

- (instancetype)initWithViewModel:(HHMVVMViewModel *)viewModel;

@end
