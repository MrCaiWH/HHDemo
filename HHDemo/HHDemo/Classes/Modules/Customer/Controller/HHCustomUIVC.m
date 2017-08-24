//
//  HHCustomUIVC.m
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/3/15.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHCustomUIVC.h"
#import "HHLoopView.h"
#import "HHSliderView.h"

@interface HHCustomUIVC ()
/** 跑马灯view */
@property (nonatomic, strong) HHLoopView *loopView;

@property (nonatomic, strong) HHSliderView *sliderView;
@end

@implementation HHCustomUIVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"自定义UI";
    
    [self.view addSubview:self.sliderView];
    
//    [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self);
//        make.width.equalTo(@149);
//        make.height.equalTo(@57);
//    }];
    
    NSArray *loopArrs = [NSArray arrayWithObjects:@"我叫黄花菜",@"我是一个程序猿",nil];
    [self addLoopView:loopArrs textColor:[UIColor blackColor]];
}

- (void)addLoopView:(NSArray *)array textColor:(UIColor *)color {
    [self.loopView setTickerArrs:array];
    [self.loopView setLabelColor:color];
    [self.loopView start];
}

#pragma mark - Lazy
- (HHLoopView *)loopView {
    if (_loopView == nil) {
        _loopView = [[HHLoopView alloc] initWithFrame:CGRectMake(0, 100, 200, 30)];
        _loopView.hh_centerX = HHSCREENWIDTH / 2;
        [self.view addSubview:_loopView];
        _loopView.clipsToBounds = YES;
        _loopView.backgroundColor = [UIColor redColor];
        [_loopView setSpeed:60.0f];
    }
    return _loopView;
}

- (HHSliderView *)sliderView {
    if (_sliderView == nil) {
        _sliderView = [[HHSliderView alloc] init];
        _sliderView.frame = CGRectMake(0, 200, 149, 57);
        _sliderView.hh_centerX = HHSCREENWIDTH / 2;
    }
    return _sliderView;
}

-(void)dealloc {
    NSLog(@"%s",__func__);
}

@end
