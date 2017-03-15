//
//  HHDownLoadVC.m
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/3/14.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHDownLoadVC.h"
#import "HHDownLoadManager.h"

@interface HHDownLoadVC ()
@property (weak, nonatomic) IBOutlet UILabel *progressLbl;
@end

@implementation HHDownLoadVC

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"断点续传";
}

#pragma mark - IBAcation
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
            self.progressLbl.text = [NSString stringWithFormat:@"%f",progress];
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

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
