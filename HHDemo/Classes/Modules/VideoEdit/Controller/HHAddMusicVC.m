//
//  HHAddMusicVC.m
//  HHDemo
//
//  Created by zero on 2017/5/2.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHAddMusicVC.h"
#import <AVFoundation/AVFoundation.h>
#import "MBProgressHUD+HHExtension.h"

@interface HHAddMusicVC ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) AVPlayer *player;

@property (nonatomic, weak) AVPlayerLayer *playerLayer;

@end

@implementation HHAddMusicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"增加背景音乐";
    
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
    
    
    NSLog(@"%@",NSHomeDirectory());
}

- (IBAction)startClick:(UIButton *)sender {
    [self.player play];
}

- (IBAction)stopClick:(UIButton *)sender {
    [self.player pause];
}

- (IBAction)addMusicClick:(UIButton *)sender {
    [self merge];
}

// 混合音乐
- (void)merge{
    
    [self.player pause];
    
    // mbp提示框
    [MBProgressHUD showStatusWithMessage:@"正在处理中"];
    
    // 路径
    NSString *documents = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    // 声音来源
    NSURL *audioInputUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Folk Song" ofType:@"mp3"]];
    // 视频来源
    NSURL *videoInputUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"20170418_162554944" ofType:@"mp4"]];
    
    // 最终合成输出路径
    NSString *outPutFilePath = [documents stringByAppendingPathComponent:@"merge.mp4"];
    // 添加合成路径
    NSURL *outputFileUrl = [NSURL fileURLWithPath:outPutFilePath];
    // 时间起点
    CMTime nextClistartTime = kCMTimeZero;
    // 创建可变的音视频组合
    AVMutableComposition *comosition = [AVMutableComposition composition];
    
    
    // 视频采集
    AVURLAsset *videoAsset = [[AVURLAsset alloc] initWithURL:videoInputUrl options:nil];
    // 视频时间范围
    CMTimeRange videoTimeRange = CMTimeRangeMake(kCMTimeZero, videoAsset.duration);
    // 视频通道 枚举 kCMPersistentTrackID_Invalid = 0
    AVMutableCompositionTrack *videoTrack = [comosition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    // 视频采集通道
    AVAssetTrack *videoAssetTrack = [[videoAsset tracksWithMediaType:AVMediaTypeVideo] firstObject];
    //  把采集轨道数据加入到可变轨道之中
    [videoTrack insertTimeRange:videoTimeRange ofTrack:videoAssetTrack atTime:nextClistartTime error:nil];

    // 声音采集
    AVURLAsset *audioAsset = [[AVURLAsset alloc] initWithURL:audioInputUrl options:nil];
    // 因为视频短这里就直接用视频长度了,如果自动化需要自己写判断
    CMTimeRange audioTimeRange = videoTimeRange;
    // 音频通道
    AVMutableCompositionTrack *audioTrack = [comosition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    // 音频采集通道
    AVAssetTrack *audioAssetTrack = [[audioAsset tracksWithMediaType:AVMediaTypeAudio] firstObject];
    // 加入合成轨道之中
    [audioTrack insertTimeRange:audioTimeRange ofTrack:audioAssetTrack atTime:nextClistartTime error:nil];
    
    // 创建一个输出
    AVAssetExportSession *assetExport = [[AVAssetExportSession alloc] initWithAsset:comosition presetName:AVAssetExportPresetMediumQuality];
    // 输出类型
    assetExport.outputFileType = AVFileTypeQuickTimeMovie;
    // 输出地址
    assetExport.outputURL = outputFileUrl;
    // 优化
    assetExport.shouldOptimizeForNetworkUse = YES;
    // 合成完毕
    [assetExport exportAsynchronouslyWithCompletionHandler:^{
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            // 调用播放方法
            [self playWithUrl:outputFileUrl];
        });
    }];
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
