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
@property (nonatomic, strong) UILabel *messageLbl;
@end

@implementation HHInternationalizationVC
#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"国际化";
    
    [self p_addUI];
    [self p_addViewsEvent];
}

#pragma mark - Private
- (void)p_addViewsEvent {
    //切换语言
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:HHSwitchAPPLanguageNotification object:nil] subscribeNext:^(id x) {
        @strongify(self);
        self.messageLbl.text = kString(@"Sure");
    }];
}

- (void)p_addUI {
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(onClickedOKbtn)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    [self.messageLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.height.with.mas_equalTo(100);
    }];
}

#pragma mark - IBAcation
- (void)onClickedOKbtn {
    HHLanguageVC *languageVC = [[HHLanguageVC alloc] init];
    [self.navigationController pushViewController:languageVC animated:YES];
}

#pragma mark - Lazy
- (UILabel *)messageLbl {
    if (_messageLbl == nil) {
        _messageLbl = [[UILabel alloc] init];
        _messageLbl.text = kString(@"Sure");
        [self.view addSubview:_messageLbl];
    }
    return _messageLbl;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}
@end
