//
//  HHMVVMViewController.m
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/3/10.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHMVVMViewController.h"

@interface HHMVVMViewController ()

@end

@implementation HHMVVMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"MVVM和RAC";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@",HHCurrentVC);
}

@end
