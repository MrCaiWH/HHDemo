//
//  HHAsyncDrawViewController.m
//  HHDemo
//
//  Created by wanhong cai on 2019/8/12.
//  Copyright © 2019 huanghuacai. All rights reserved.
//

#import "HHAsyncDrawViewController.h"
#import "HHAsyncLabel.h"

@interface HHAsyncDrawViewController ()

@end

@implementation HHAsyncDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    HHAsyncLabel *label = [[HHAsyncLabel alloc] initWithFrame:CGRectMake(50, 200, [UIScreen mainScreen].bounds.size.width - 2 * 50, 100)];
    label.backgroundColor = [UIColor lightGrayColor];
    label.text = @"今天是个好日子啊，心想的事儿都能成，今天是个好日子啊，啊，安心，太平";
    label.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:label];
    [label.layer setNeedsDisplay];
}

@end
