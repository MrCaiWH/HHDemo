//
//  HHNetStudyVC.m
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/3/22.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHNetStudyVC.h"

@interface HHNetStudyVC ()<NSURLSessionDownloadDelegate>
@property (nonatomic, strong) NSURLSession *session;
/** 下载任务 */
@property (nonatomic, strong) NSURLSessionDownloadTask *task;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation HHNetStudyVC

#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"网络学习";
}

//解决session和delegate强引用的问题
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.session invalidateAndCancel];
    self.session = nil;
}

#pragma mark - IBAction
/**
 如果要监听 session 的下载进度，不能使用 `sharedSession`
 * 是一个全局的单例
 */
- (IBAction)startClick:(UIButton *)sender {
    
    NSURL *url = [NSURL URLWithString:@"http://dldir1.qq.com/qqfile/QQforMac/QQ_V4.0.2.dmg"];
    
    NSLog(@"start");
    
    // 如果发起的任务带有 completion 回调，不会走代理！
    //    [[self.session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
    //        NSLog(@"%@ %@", location, [NSThread currentThread]);
    //    }] resume];
    
    // 直接建立下载任务并且启动，后续的进度监听又代理负责
    //    [[self.session downloadTaskWithURL:url] resume];
    
    self.task = [self.session downloadTaskWithURL:url];
    [self.task resume];
}

/**
 NSURLConnection 不能挂起，只能开始&取消，一旦取消，如果需要再次启动，需要新建 connection
 SessionTask 状态 挂起/继续/取消/完成
 */
- (IBAction)pauseClick:(UIButton *)sender {
    if (self.task.state == NSURLSessionTaskStateRunning ) {
        [self.task suspend];
    }
}

- (IBAction)resumeClick:(UIButton *)sender {
    if (self.task.state == NSURLSessionTaskStateSuspended ) {
        [self.task resume];
    }
}

#pragma mark - NSURLSessionDownloadDelegate

/**
 下载完成
 
 @param session <#session description#>
 @param downloadTask <#downloadTask description#>
 @param location <#location description#>
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSLog(@"%s  %@",__func__,location);
}

// 在 iOS 7.0 是必须的
/**
 session
 downloadTask
 bytesWritten                   本次下载字节数
 totalBytesWritten              已经下载字节数
 totalBytesExpectedToWrite      总大小
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
 
    NSLog(@"%s",__func__);
    
    float  progress = (float)totalBytesWritten / totalBytesExpectedToWrite;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressView.progress = progress;
    });
}

// 在 iOS 7.0 是必须的
// 续传代理方法，没什么用处
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    NSLog(@"%s",__func__);
}

#pragma mark - Lazy
- (NSURLSession *)session {
    if (_session == nil) {
        /**
         * 下载本身是有一个独立线程`顺序`完成的！
         
         1. 会话配置，大多使用 默认的
         2. 代理 self
         3. `代理工作的队列`，可以使用 nil
         ** 跟下载没有任何关系，指定`代理工作的队列`
         ** 无论选择什么队列，都不会影响主线程！
         
         - nil 会新建一个队列，NSOperation 中没有串行队列的概念！白胡子老头！
         - [[NSOperationQueue alloc] init] 和 nil 相同
         - [NSOperationQueue mainQueue] 代理方法在主线程异步执行！
         
         * 如果代理方法中，有耗时操作，就选择异步队列
         * 如果没有耗时操作，选择主队列
         */
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    }
    return _session;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
