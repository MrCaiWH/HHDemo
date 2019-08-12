//
//  HHMVVMViewModel.m
//  HHDemo
//
//  Created by zero on 2017/8/24.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHMVVMViewModel.h"
#import "HHPlayModel.h"
#import "HHViewModelConstant.h"
#import "HHPlayListApi.h"
#import "MJExtension.h"

#define LOAD_DATA_NUM 20

@interface HHMVVMViewModel ()
@property (nonatomic, assign) NSInteger maxId;
@end

@implementation HHMVVMViewModel

-(instancetype)init; {
    if (self = [super init]) {
        [self initialize];
        self.dataArrayCount = -1;
    }
    return self;
}

-(void)initialize
{
    @weakify(self)
    [self.loadLatestDataCommand.executionSignals.switchToLatest subscribeNext:^(NSArray *array) {
        @strongify(self)
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:array];
        self.dataArrayCount = self.dataArray.count;
        if (array.count < LOAD_DATA_NUM)
        {
            [self.refreshEndSubject sendNext:@(HHHeaderRefresh_NoMoreData)];
        }
        else
        {
            [self.refreshEndSubject sendNext:@(HHHeaderRefresh_HasMoreData)];
        }
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:array];
    }];
    [self.loadMoreDataCommand.executionSignals.switchToLatest subscribeNext:^(NSArray *array) {
        @strongify(self)
        [self.dataArray addObjectsFromArray:array];
        self.dataArrayCount = self.dataArray.count;
        if (array.count < LOAD_DATA_NUM)
        {
            [self.refreshEndSubject sendNext:@(HHFooterRefresh_NoMoreData)];
        }
        else
        {
            [self.refreshEndSubject sendNext:@(HHFooterRefresh_HasMoreData)];
        }
    }];
}

-(RACCommand *)loadLatestDataCommand {
    if (!_loadLatestDataCommand) {
        _loadLatestDataCommand =  [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id array) {
//            @weakify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//                NSDictionary *parameter = @{ @"max_id": @(0), @"uid": @([ZOJPLoginTool uid])};
//                [[BHNetReqManager sharedManager].bh_requestUrl(kMessageUrl).bh_parameters(parameter) startRequestWithCompleteHandler:^(NSURLSessionDataTask *task, id response, NSError *error) {
//                    @strongify(self)
//                    [self data:response error:error subscriber:subscriber];
//                }];
                
                HHPlayListApi *listApi = [[HHPlayListApi alloc] initWithOneDayOnePlay];
                
                [listApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                    
                    [self data:request subscriber:subscriber];
                    
                } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                    
                }];
                
                return nil;
            }];
        }];
        
    }
    return _loadLatestDataCommand;
}

-(RACCommand *)loadMoreDataCommand {
    if (!_loadMoreDataCommand) {
        _loadMoreDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//            @weakify(self);
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//                NSDictionary *parameter = @{ @"max_id": @(self.maxId), @"uid" : @([ZOJPLoginTool uid]) };
//                [[BHNetReqManager sharedManager].bh_requestUrl(kMessageUrl).bh_parameters(parameter) startRequestWithCompleteHandler:^(NSURLSessionDataTask *task, id response, NSError *error) {
//                    @strongify(self)
//                    [self data:response error:error subscriber:subscriber];
//                }];
                return nil;
            }];
        }];
    }
    return _loadMoreDataCommand;
}

/**
 *  解析数据
 */
-(void)data:(YTKBaseRequest *)request subscriber:(id<RACSubscriber>)subscriber
{
    if (request.error)
    {
        if (request.error.code == 100000002)
        {
            [self.refreshEndSubject sendNext:@(HHFooterRefresh_NoMoreData)];
        }
        else
        {
            [MBProgressHUD showHintMessage:request.error.localizedDescription];
        }
        [self.refreshEndSubject sendNext:@(HHRefreshError)];
    }
    else if (request.response)
    {
        
        NSArray *array = [HHPlayModel mj_objectArrayWithKeyValuesArray:[request.responseObject objectForKey:@"body"]];
        
        [subscriber sendNext:array];
    }
    [subscriber sendCompleted];
}

- (RACSubject *)refreshEndSubject {
    if (!_refreshEndSubject) {
        _refreshEndSubject = [RACSubject subject];
    }
    return _refreshEndSubject;
}

-(NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}

@end
