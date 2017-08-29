//
//  ZOEncodedVC.m
//  HHDemo
//
//  Created by 蔡万鸿 on 2016/11/11.
//  Copyright © 2016年 黄花菜. All rights reserved.
//

#import "HHEncodedVC.h"
#import "HHLoginApi.h"

#import <AFNetworking/AFNetworking.h>

@interface HHEncodedVC ()

@end

@implementation HHEncodedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"编码";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"1-2-2.2.1-1-99" forHTTPHeaderField:@"v"];

    NSString *url = [@"https://dobbyapi.zerotech.com" stringByAppendingPathComponent:[NSString stringWithFormat:@"sign/login"]];
    
    NSDictionary *parameters = @{ @"phone" : @"18811108252", @"password" :@"11111111"};
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject %@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        NSLog(@"error %@",error);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    HHLoginApi *loginApi = [[HHLoginApi alloc] init];
    
    [loginApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSLog(@"request.responseObject  %@",request.responseObject);
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSLog(@"request.error  %@",request.error);
    }];
}

@end
