//
//  HHAddWatermarkVC.m
//  HHDemo
//
//  Created by zero on 2017/5/2.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHAddWatermarkVC.h"
#import <AVFoundation/AVFoundation.h>
#import "MBProgressHUD+HHExtension.h"
#import <GPUImage/GPUImage.h>

@interface HHAddWatermarkVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, weak) AVPlayerLayer *playerLayer;

@end

@implementation HHAddWatermarkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"增加水印";
    
    // 视频来源
    NSURL *videoInputUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"20170418_162554944" ofType:@"mp4"]];

    // 传入地址
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:videoInputUrl];
    // 播放器
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    // 播放器layer
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = self.imageView.frame;
    // 视频填充模式
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    // 添加到imageview的layer上
    [self.imageView.layer addSublayer:playerLayer];
    
    self.player = player;
    self.playerLayer = playerLayer;
    
    // 播放
    [player play];
}

- (IBAction)startClick:(UIButton *)sender {
    [self.player play];
}

- (IBAction)stopClick:(UIButton *)sender {
    [self.player pause];
}

- (IBAction)addMusicClick:(UIButton *)sender {
    [self p_addWatermark];
}

// 增加水印
- (void)p_addWatermark{
    
    [self.player pause];
    
    // 路径
    NSString *documents = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    // 最终合成输出路径
    NSString *outPutFilePath = [documents stringByAppendingPathComponent:@"watermark.mp4"];
    // 添加合成路径
    NSURL *outputFileUrl = [NSURL fileURLWithPath:outPutFilePath];
    
    // 视频来源
    NSURL *videoInputUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"20170418_162554944" ofType:@"mp4"]];

    // mbp提示框
    [MBProgressHUD showStatusWithMessage:@"正在处理中"];
}

/** 播放方法 */
- (void)playWithUrl:(NSURL *)url{
    
    [self.playerLayer removeFromSuperlayer];
    
    // 传入地址
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
    // 播放器
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    // 播放器layer
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = self.imageView.frame;
    // 视频填充模式
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    // 添加到imageview的layer上
    [self.imageView.layer addSublayer:playerLayer];
    // 隐藏提示框 开始播放
    [MBProgressHUD hideHUD];
    [MBProgressHUD showHintMessage:@"合成完成"];
    // 播放
    [player play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
