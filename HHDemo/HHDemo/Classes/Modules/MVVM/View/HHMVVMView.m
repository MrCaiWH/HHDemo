//
//  HHRedView.m
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/4/18.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHMVVMView.h"

@interface HHMVVMView ()
@property (nonatomic, strong) UIButton *btn;
@end

@implementation HHMVVMView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        [self addSubview:self.btn];

        [self setNeedsUpdateConstraints];
        [self updateConstraints];
    }
    return self;
}

-(void)updateConstraints
{
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(30);
    }];

    [super updateConstraints];
}

- (UIButton *)btn {
    if (_btn == nil) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitle:@"点击我" forState:UIControlStateNormal];
        [_btn setBackgroundColor:[UIColor greenColor]];
        @weakify(self)
        //起飞 降落
        [[_btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            [self.subject sendNext:@"hello"];
        }];
    }
    return _btn;
}

- (RACSubject *)subject {
    if (_subject == nil) {
        _subject = [RACSubject subject];
    }
    return _subject;
}
@end
