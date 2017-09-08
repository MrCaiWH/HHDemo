//
//  LocationManager.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/23.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "HHLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface HHLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end


@implementation HHLocationManager

+ (instancetype)shareLocation {
    static HHLocationManager *manager = nil;
    static dispatch_once_t oneceToken;
    dispatch_once(&oneceToken, ^{
        manager = [[HHLocationManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        
        // 开启一直定位
        [self.locationManager requestAlwaysAuthorization];
        
        // 开启前台定位
        [self.locationManager requestWhenInUseAuthorization];
        
        // 最精准
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        // 水平距离5米以内不更新  5米以外才更新
        self.locationManager.distanceFilter = 5.0;
        
        // 开启定位服务
        [self.locationManager startUpdatingLocation];
        
    }
    return self;
    
}

// 定位成功
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    // 停止方向
    [manager stopUpdatingHeading];
    
    CLLocation *currentLocation = [locations lastObject];
    CGFloat longitude = currentLocation.coordinate.longitude;
    CGFloat latitude  = currentLocation.coordinate.latitude;
    
    _longitude = [NSString stringWithFormat:@"%f", longitude];
    _latitude  = [NSString stringWithFormat:@"%f", latitude];
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    //设置提示提醒用户打开定位服务
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"允许定位提示"  message:@"请在设置中打开定位" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"打开定位", nil];
//    [alert show];
    // 可以根据URL scheme 跳转
    
}

@end
