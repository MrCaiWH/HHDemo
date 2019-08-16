//
//  HHTimerViewController.m
//  HHDemo
//
//  Created by wanhong cai on 2019/8/12.
//  Copyright © 2019 huanghuacai. All rights reserved.
//

#import "HHTimerViewController.h"
#import "NSTimer+HHWeakTimer.h"
#import "HHWeakObject.h"
#import "HHWeakProxy.h"

@interface HHTimerViewController ()
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation HHTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //方法一
    self.timer = [NSTimer hh_scheduledWeakTimerWithTimeInterval:1.0 target:self selector:@selector(test) userInfo:nil repeats:YES];
    
    //方法二
    HHWeakObject *weakObj = [HHWeakObject proxyWithWeakObject:self];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:weakObj selector:@selector(test) userInfo:nil repeats:YES];
    
    //方法三
    self.timer = [NSTimer timerWithTimeInterval:1
                                         target:[HHWeakProxy proxyWithTarget:self]
                                       selector:@selector(test)
                                       userInfo:nil
                                        repeats:YES];
}

- (void)test {
    NSLog(@"%s",__func__);
}

- (void)dealloc {
    NSLog(@"%s",__func__);
    
    //方法二，需要在外部手动去调用销毁timer
    [self.timer invalidate];
    self.timer = nil;
}

@end
