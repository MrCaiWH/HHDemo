//
//  YTKBatchRequest.m
//
//  Copyright (c) 2012-2016 YTKNetwork https://github.com/yuantiku
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "YTKBatchRequest.h"
#import "YTKNetworkPrivate.h"
#import "YTKBatchRequestAgent.h"
#import "YTKRequest.h"

@interface YTKBatchRequest() <YTKRequestDelegate>

@property (nonatomic) NSInteger finishedCount;

@end

@implementation YTKBatchRequest

- (instancetype)initWithRequestArray:(NSArray<YTKRequest *> *)requestArray {
    self = [super init];
    if (self) {
        //保存为属性
        _requestArray = [requestArray copy];
        //批量请求完成的数量初始化为0
        _finishedCount = 0;
        //类型检查，所有元素都必须为YTKRequest或的它的子类，否则强制初始化失败
        for (YTKRequest * req in _requestArray) {
            if (![req isKindOfClass:[YTKRequest class]]) {
                YTKLog(@"Error, request item must be YTKRequest instance.");
                return nil;
            }
        }
    }
    return self;
}

- (void)start {
    //如果batch里第一个请求已经成功结束，则不能再start
    if (_finishedCount > 0) {
        YTKLog(@"Error! Batch request has already started.");
        return;
    }
    //最开始设定失败的request为nil
    _failedRequest = nil;
    
    //使用YTKBatchRequestAgent来管理当前的批量请求
    [[YTKBatchRequestAgent sharedAgent] addBatchRequest:self];
    [self toggleAccessoriesWillStartCallBack];
    
    //遍历所有request，并开始请求
    for (YTKRequest * req in _requestArray) {
        req.delegate = self;
        [req clearCompletionBlock];
        [req start];
    }
}

- (void)stop {
    [self toggleAccessoriesWillStopCallBack];
    _delegate = nil;
    [self clearRequest];
    [self toggleAccessoriesDidStopCallBack];
    [[YTKBatchRequestAgent sharedAgent] removeBatchRequest:self];
}

- (void)startWithCompletionBlockWithSuccess:(void (^)(YTKBatchRequest *batchRequest))success
                                    failure:(void (^)(YTKBatchRequest *batchRequest))failure {
    [self setCompletionBlockWithSuccess:success failure:failure];
    [self start];
}

- (void)setCompletionBlockWithSuccess:(void (^)(YTKBatchRequest *batchRequest))success
                              failure:(void (^)(YTKBatchRequest *batchRequest))failure {
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
}

- (void)clearCompletionBlock {
    // nil out to break the retain cycle.
    self.successCompletionBlock = nil;
    self.failureCompletionBlock = nil;
}

- (BOOL)isDataFromCache {
    BOOL result = YES;
    for (YTKRequest *request in _requestArray) {
        if (!request.isDataFromCache) {
            result = NO;
        }
    }
    return result;
}


- (void)dealloc {
    [self clearRequest];
}

#pragma mark - Network Request Delegate

- (void)requestFinished:(YTKRequest *)request {
    //某个request成功后，首先让_finishedCount + 1
    _finishedCount++;
    
    //如果_finishedCount等于_requestArray的个数，则判定当前batch请求成功
    if (_finishedCount == _requestArray.count) {
        //调用即将结束的代理
        [self toggleAccessoriesWillStopCallBack];
        //调用请求成功的代理
        if ([_delegate respondsToSelector:@selector(batchRequestFinished:)]) {
            [_delegate batchRequestFinished:self];
        }
        //调用批量请求成功的block
        if (_successCompletionBlock) {
            _successCompletionBlock(self);
        }
        //清空成功和失败的block
        [self clearCompletionBlock];
        //调用请求结束的代理
        [self toggleAccessoriesDidStopCallBack];
        //从YTKBatchRequestAgent里移除当前的batch
        [[YTKBatchRequestAgent sharedAgent] removeBatchRequest:self];
    }
}

- (void)requestFailed:(YTKRequest *)request {
    _failedRequest = request;
    //调用即将结束的代理
    [self toggleAccessoriesWillStopCallBack];
    // Stop
    //停止batch里所有的请求
    for (YTKRequest *req in _requestArray) {
        [req stop];
    }
    // Callback
    //调用请求失败的代理
    if ([_delegate respondsToSelector:@selector(batchRequestFailed:)]) {
        [_delegate batchRequestFailed:self];
    }
    //调用请求失败的block
    if (_failureCompletionBlock) {
        _failureCompletionBlock(self);
    }
    // Clear
    //清空成功和失败的block
    [self clearCompletionBlock];

    //调用请求结束的代理
    [self toggleAccessoriesDidStopCallBack];
    //从YTKBatchRequestAgent里移除当前的batch
    [[YTKBatchRequestAgent sharedAgent] removeBatchRequest:self];
}

- (void)clearRequest {
    for (YTKRequest * req in _requestArray) {
        [req stop];
    }
    [self clearCompletionBlock];
}

#pragma mark - Request Accessoies

- (void)addAccessory:(id<YTKRequestAccessory>)accessory {
    if (!self.requestAccessories) {
        self.requestAccessories = [NSMutableArray array];
    }
    [self.requestAccessories addObject:accessory];
}

@end
