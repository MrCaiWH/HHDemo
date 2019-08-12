//
//  HHImageViewController.m
//  HHDemo
//
//  Created by zero on 2017/3/21.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHImageViewController.h"
#import "UIImageView+WebCache.h"

@interface HHImageViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation HHImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://img2.imgtn.bdimg.com/it/u=2656434068,2445990406&fm=23&gp=0.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        
//        NSLog(@"come here");
//    }];
    
//    anniu_1_
    
    NSURL *url = [NSURL URLWithString:@"http://pic250.quanjing.com/imageclk005/ic01302986.jpg"];
    
    [self.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"anniu_1_"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        NSLog(@"error %@",error);
    }];
}

@end
