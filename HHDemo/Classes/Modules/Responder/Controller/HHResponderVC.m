//
//  HHResponderVC.m
//  HHDemo
//
//  Created by zero on 2017/3/16.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHResponderVC.h"

@interface HHResponderVC ()

@end

@implementation HHResponderVC

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)btnClick:(UIButton *)sender {
    [MBProgressHUD showHintMessage:@"按钮被点击"];
}
@end
