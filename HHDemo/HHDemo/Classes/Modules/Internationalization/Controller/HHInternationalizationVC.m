//
//  HHInternationalizationVC.m
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/3/15.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHInternationalizationVC.h"
#import "HHLanguageVC.h"

@interface HHInternationalizationVC ()

@end

@implementation HHInternationalizationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"国际化";
    
    [self p_addRightBtn];
}

- (void)p_addRightBtn {
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(onClickedOKbtn)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)onClickedOKbtn {
    HHLanguageVC *languageVC = [[HHLanguageVC alloc] init];
    [self.navigationController pushViewController:languageVC animated:YES];
}

@end
