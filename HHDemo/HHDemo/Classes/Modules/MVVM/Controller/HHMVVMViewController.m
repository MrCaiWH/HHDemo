//
//  HHMVVMViewController.m
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/3/10.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHMVVMViewController.h"
#import "HHMVVMView.h"
#import "HHMVVMViewModel.h"

@interface HHMVVMViewController ()

@property (nonatomic, strong) HHMVVMView *mvvmView;

@property (nonatomic, strong) HHMVVMViewModel *viewModel;
@end

@implementation HHMVVMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"MVVM和RAC";
    
    [self.view addSubview:self.mvvmView];
}

- (void)updateViewConstraints {
    [self.mvvmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    [super updateViewConstraints];
}

- (HHMVVMView *)mvvmView {
    if (_mvvmView == nil) {
        _mvvmView = [[HHMVVMView alloc] initWithViewModel:self.viewModel];
    }
    return _mvvmView;
}

- (HHMVVMViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[HHMVVMViewModel alloc] init];
    }
    return _viewModel;
}
@end
