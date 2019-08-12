//
//  UIScrollView+HHExtension.m
//  HHDemo
//
//  Created by zero on 2017/8/24.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "UIScrollView+HHExtension.h"

#define C999999 @"999999"

@implementation UIScrollView (HHExtension)

- (void)hh_headerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock {
    MJRefreshNormalHeader *mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:refreshingBlock];
    mj_header.stateLabel.hidden = YES;
    mj_header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = mj_header;
    
}

- (void)hh_footerWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock {
    MJRefreshAutoStateFooter *mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:refreshingBlock];
    mj_footer.stateLabel.textColor = [UIColor hexChangeFloat:C999999];
    self.mj_footer = mj_footer;
    self.mj_footer.hidden = YES;
}

-(void)hh_changeMJRefreshTextLanguage {
    MJRefreshAutoStateFooter *mj_footer = (MJRefreshAutoStateFooter *)self.mj_footer;
    [mj_footer setTitle:kString(@"Album_Refresh_FooterTitleIdle") forState:MJRefreshStateIdle];
    [mj_footer setTitle:kString(@"Album_Refresh_TitlePulling") forState:MJRefreshStatePulling];
    [mj_footer setTitle:kString(@"Album_Refresh_FooterTitleRefreshing") forState:MJRefreshStateRefreshing];
    [mj_footer setTitle:kString(@"Base_NoData") forState:MJRefreshStateNoMoreData];
}

-(void)hh_beginRefreshing {
    [self.mj_header beginRefreshing];
}

-(void)hh_endRefreshing {
    [self.mj_header endRefreshing];
}

@end
