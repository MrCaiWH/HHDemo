//
//  HHMVVMViewController.m
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/3/10.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHMVVMViewController.h"
#import "HHMVVMView.h"
#import "HHPlayListApi.h"

@interface HHMVVMViewController ()
@property (nonatomic, strong) HHMVVMView *mvvmView;
@end

@implementation HHMVVMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"MVVM和RAC";
    
    [self.view addSubview:self.mvvmView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@",HHCurrentVC);
    
    HHPlayListApi *listApi = [[HHPlayListApi alloc] initWithOneDayOnePlay];
    
    [listApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSLog(@"%@",request.responseObject);
        
        NSLog(@"come here");
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSLog(@"%@",request.error);
        
    }];
}

- (HHMVVMView *)mvvmView {
    if (_mvvmView == nil) {
        _mvvmView = [[HHMVVMView alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
        _mvvmView.backgroundColor = [UIColor redColor];
        [_mvvmView.subject subscribeNext:^(id x) {
            NSLog(@"%s  %@",__func__,x);
        }];
    }
    return _mvvmView;
}
@end
