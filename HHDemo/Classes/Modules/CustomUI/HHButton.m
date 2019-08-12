//
//  HHButton.m
//  HHDemo
//
//  Created by zero on 2017/4/14.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHButton.h"

@implementation HHButton

-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize imgViewSize,titleSize,btnSize;
    UIEdgeInsets imageViewEdge,titleEdge;
    CGFloat heightSpace = 10.0f;
    
    //设置按钮内边距
    imgViewSize = self.imageView.bounds.size;
    titleSize = self.titleLabel.bounds.size;
    btnSize = self.bounds.size;
    
    imageViewEdge = UIEdgeInsetsMake(heightSpace,0.0, btnSize.height -imgViewSize.height - heightSpace, - titleSize.width);
    [self setImageEdgeInsets:imageViewEdge];
    
    titleEdge = UIEdgeInsetsMake(imgViewSize.height +heightSpace, - imgViewSize.width, 0.0, 0.0);
    [self setTitleEdgeInsets:titleEdge];
}

@end
