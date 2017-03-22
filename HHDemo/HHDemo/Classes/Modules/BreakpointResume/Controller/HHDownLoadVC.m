//
//  HHDownLoadVC.m
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/3/14.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHDownLoadVC.h"
#import "HHDownLoadManager.h"
#import "ASProgressPopUpView.h"

@interface HHDownLoadVC ()
@property (nonatomic, strong) ASProgressPopUpView *progressView1;
@end

@implementation HHDownLoadVC

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"断点续传";
    [self progressView1];
}

#pragma mark - IBAction
/**
 * 开始下载
 */
- (IBAction)startDownload:(UIButton *)sender {
    // 下载地址
    NSString * downLoadUrl =  @"http://audio.xmcdn.com/group11/M01/93/AF/wKgDa1dzzJLBL0gCAPUzeJqK84Y539.m4a";
    
     @weakify(self);
    [[HHDownLoadManager shareManager] downLoadWithURL:downLoadUrl progress:^(float progress) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.progressView1 setProgress:progress animated:YES];
        });
        
    } success:^(NSString *fileStorePath) {
        NSLog(@"###%@",fileStorePath);
        
    } faile:^(NSError *error) {
        NSLog(@"###%@",error.userInfo[NSLocalizedDescriptionKey]);
    }];
}

/**
 * 暂停下载
 */
- (IBAction)pauseClick:(UIButton *)sender {
    [[HHDownLoadManager shareManager] stopTask];
}

- (ASProgressPopUpView *)progressView1 {
    if (_progressView1 == nil) {
        _progressView1 = [[ASProgressPopUpView alloc] initWithFrame:CGRectMake(50, 100, 250, 2)];
        // 设置字体
        _progressView1.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:15.f];
        // 设置进度条颜色
        _progressView1.popUpViewAnimatedColors = @[[UIColor redColor],
                                                   [UIColor orangeColor],
                                                   [UIColor greenColor]];
        // 显示数值百分比
        [_progressView1 showPopUpViewAnimated:YES];
        [self.view addSubview:_progressView1];
    }
    return _progressView1;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
