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


@property (strong, nonatomic) AVAssetExportSession *exportSession;

@property (nonatomic,strong)AVMutableComposition  *composition;

@property(nonatomic,strong) AVAsset *asset;

@property (assign, nonatomic) CGFloat   startTime;
@property (assign, nonatomic) CGFloat   stopTime;

@property (nonatomic, copy) NSString *nowTitle;

@property (nonatomic, copy) NSString *urlStr;

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
//    [self p_addWatermark];
    
    
    self.composition = [AVMutableComposition composition];
    _exportSession = [AVAssetExportSession exportSessionWithAsset:self.composition presetName:AVAssetExportPreset1280x720];

    //
    AVVideoComposition *mainCompositionInst = nil;

    mainCompositionInst = [self p_addWaterOnVideo];
    _exportSession.videoComposition = mainCompositionInst;
    
    NSString *filePath =  NSTemporaryDirectory();

    self.nowTitle = [self p_dateToString];
    NSString *savePath = [filePath stringByAppendingPathComponent:[self.nowTitle stringByAppendingString:@".mp4"]];
    self.urlStr = savePath;
    NSURL *furl = [NSURL fileURLWithPath: savePath];
    
    _exportSession.outputURL = furl;
    _exportSession.outputFileType = AVFileTypeQuickTimeMovie;

    _exportSession.shouldOptimizeForNetworkUse = YES;
    NSLog(@"editaction save start");

    [_exportSession exportAsynchronouslyWithCompletionHandler:^{
        switch ([_exportSession status]) {
            case AVAssetExportSessionStatusCompleted:
            {
                NSLog(@"come here");
            }
                break;
            default:
            {
                NSLog(@"Export failed: %@", [[_exportSession error] localizedDescription]);
            }
                break;
        }
    }];
}

/**
 dateTOString
 
 @return <#return value description#>
 */
-(NSString*)p_dateToString
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSString *str = [NSString stringWithFormat:@"%04ld%02ld%02ld%02ld%02ld%02ld",(long)[dateComponent year],(long)[dateComponent month],(long)[dateComponent day],(long)[dateComponent hour] ,(long)[dateComponent minute],(long)[dateComponent second]];
    return str;
}

/**
 添加水印
 */
-(AVMutableVideoComposition*)p_addWaterOnVideo
{
    CMTime cusorTime = kCMTimeZero;
    AVMutableCompositionTrack *videoTrack = [self.composition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];       //创建配置视频轨道，并加入到轨道容器总
    AVMutableCompositionTrack *audioTrack = [self.composition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];       //创建音频轨道，并加入到轨道容器中
    //得到音视频信息，截取并加入到对应的轨道中
    AVAssetTrack*assetTrackVideo = [[self.asset tracksWithMediaType:AVMediaTypeVideo] firstObject];  //得到视频信息
    AVAssetTrack*assetTrackAudio = [[self.asset tracksWithMediaType:AVMediaTypeAudio] firstObject];
    if (self.startTime < 0) {
        self.startTime = 0;
    }
    if (self.stopTime>CMTimeGetSeconds(self.asset.duration)) {
        self.stopTime = CMTimeGetSeconds(self.asset.duration);
    }
    CMTime start = CMTimeMakeWithSeconds(self.startTime, assetTrackVideo.timeRange.duration.timescale);
    CMTime duration = CMTimeMakeWithSeconds(self.stopTime - self.startTime,assetTrackVideo.timeRange.duration.timescale);
    CMTimeRange range = CMTimeRangeMake(start, duration);
    NSError *error;
    if (assetTrackVideo) {
        [videoTrack insertTimeRange:range ofTrack:assetTrackVideo atTime:cusorTime error:&error];  //截取视频数据，并放入视频轨道中
        NSLog(@"%@",error);
    }
    if (assetTrackAudio) {
        [audioTrack insertTimeRange:range ofTrack:assetTrackAudio atTime:cusorTime error:&error];  //截取音频数据，并放入音频轨道中
        NSLog(@"%@",error);
    }
    if (!assetTrackAudio) {
        [self.composition removeTrack:audioTrack];
    }
    //3.1 AVMutableVideoCompositionInstruction 视频轨道中的一个视频，可以缩放、旋转等
    AVMutableVideoCompositionInstruction *mainInstruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    mainInstruction.timeRange = CMTimeRangeMake(kCMTimeZero,self.asset.duration);
    // 3.2 AVMutableVideoCompositionLayerInstruction 一个视频轨道，包含了这个轨道上的所有视频素材
    AVMutableVideoCompositionLayerInstruction *videolayerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
    CGRect rect = CGRectMake(100, 100, 1080, 720);
    CGAffineTransform t=CGAffineTransformMakeTranslation(-rect.origin.x, -rect.origin.y);
    [videolayerInstruction setTransform:t atTime:kCMTimeZero];
    [videolayerInstruction setOpacity:1.0 atTime:kCMTimeZero];
    // 3.3 - Add instructions
    mainInstruction.layerInstructions = [NSArray arrayWithObjects:videolayerInstruction,nil];
    //AVMutableVideoComposition：管理所有视频轨道，可以决定最终视频的尺寸，裁剪需要在这里进行
    AVMutableVideoComposition *mainCompositionInst = [AVMutableVideoComposition videoComposition];
    mainCompositionInst.renderSize = assetTrackVideo.naturalSize;
    mainCompositionInst.instructions = [NSArray arrayWithObject:mainInstruction];
    mainCompositionInst.frameDuration = CMTimeMake(1, 30);
    [self applyVideoEffectsToComposition:mainCompositionInst size:assetTrackVideo.naturalSize];
    return mainCompositionInst;
}

/**
 水印图片
 
 @param composition <#composition description#>
 @param size        <#size description#>
 */
- (void)applyVideoEffectsToComposition:(AVMutableVideoComposition *)composition size:(CGSize)size
{
    //    水印
    UIImage *image = [UIImage imageNamed:@"rollcap"];
    CALayer *imageLayer = [CALayer layer];
    float x = 4;
    x= size.width /1920  *x;
    imageLayer.frame = CGRectMake(size.width-image.size.width*x,0,image.size.width*x,image.size.height*x);
    imageLayer.contents = (id)image.CGImage;
    //
    //    // 2 - The usual overlay
    CALayer *overlayLayer = [CALayer layer];
    [overlayLayer addSublayer:imageLayer];
    overlayLayer.frame = CGRectMake(0, 0, size.width, size.height);
    [overlayLayer setMasksToBounds:YES];
    
    CALayer *parentLayer = [CALayer layer];
    CALayer *videoLayer = [CALayer layer];
    parentLayer.frame = CGRectMake(0, 0, size.width, size.height);
    videoLayer.frame = CGRectMake(0, 0, size.width, size.height);
    [parentLayer addSublayer:videoLayer];
    [parentLayer addSublayer:overlayLayer];
    
    composition.animationTool = [AVVideoCompositionCoreAnimationTool
                                 videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayer:videoLayer inLayer:parentLayer];
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
