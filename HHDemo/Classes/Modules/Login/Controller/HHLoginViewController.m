//
//  HHLoginViewController.m
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/9/8.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHLoginViewController.h"
#import "HHUserManager.h"

@interface HHLoginViewController ()

@end

@implementation HHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)WeChatLogin:(UIButton *)sender {
    
    [KUserManager login:HHUserLoginTypeWeChat completion:^(BOOL success, NSString *des) {
        if (success) {
            NSLog(@"登录成功");
        }else{
            NSLog(@"登录失败：%@", des);
        }
    }];
}

- (IBAction)QQLogin:(UIButton *)sender {
    
    [KUserManager login:HHUserLoginTypeQQ completion:^(BOOL success, NSString *des) {
        if (success) {
            NSLog(@"登录成功");
        }else{
            NSLog(@"登录失败：%@", des);
        }
    }];
}
@end
