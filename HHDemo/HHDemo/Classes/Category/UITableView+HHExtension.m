//
//  UITableView+HHExtension.m
//  HHDemo
//
//  Created by zero on 2017/3/15.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "UITableView+HHExtension.h"

@implementation UITableView (HHExtension)

- (void)hiddenExtraCellLine {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:view];;
}

@end
