//
//  HHBarrierViewController.m
//  HHDemo
//
//  Created by wanhong cai on 2019/8/15.
//  Copyright © 2019 huanghuacai. All rights reserved.
//

#import "HHBarrierViewController.h"
#import "HHUserCenter.h"

@interface HHBarrierViewController ()
@property (nonatomic, strong) HHUserCenter *userCenter;
@end

@implementation HHBarrierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.userCenter = [[HHUserCenter alloc] init];
}

@end
