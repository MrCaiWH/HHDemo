//
//  HHTableViewCell.h
//  HHDemo
//
//  Created by zero on 2017/8/24.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HHPlayModel;

@interface HHTableViewCell : UITableViewCell

// You should use the same reuse identifier for all cells of the same form.
+(NSString *)identifier;


@property (nonatomic, strong) HHPlayModel *model;

@end
