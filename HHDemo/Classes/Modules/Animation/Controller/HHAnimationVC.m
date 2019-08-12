//
//  HHAnimationVC.m
//  HHDemo
//
//  Created by zero on 2017/3/15.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHAnimationVC.h"
#import "POP.h"

@interface HHAnimationVC ()
@property (nonatomic, strong) UIView *contentView;
@end

@implementation HHAnimationVC
#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //非常棒的动画教程
//    https://github.com/AttackOnDobby/iOS-Core-Animation-Advanced-Techniques
    
//    POP默认支持三种动画 但同时也支持自定义动画
//    POPBasicAnimation    //与Core Animation一样
//    POPSpringAnimation  //弹簧动画
//    POPDecayAnimation   //减速动画
//    POPCustomAnimation //自定义动画
    
//    Pop Animation应用于CALayer时，在动画运行的任何时刻，layer和其presentationLayer的相关属性值始终保持一致，而Core Animation做不到。
//    Pop Animation可以应用任何NSObject的对象，而Core Aniamtion必须是CALayer。
    
    self.title = @"动画";
    [self.view addSubview:self.contentView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    anim.fromValue = @(0.0);
    anim.toValue = @(1.0);
    [self.contentView pop_addAnimation:anim forKey:@"fade"];
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.springBounciness = 10;
    scaleAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.2)];
    [self.contentView.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}

#pragma mark - Lazy
- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _contentView.center = self.view.center;
        _contentView.backgroundColor = [UIColor redColor];
    }
    return _contentView;
}

@end
