//
//  HHRedView.m
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/4/18.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHMVVMView.h"
#import "HHMVVMViewModel.h"
#import "HHTableViewCell.h"
#import "UIScrollView+HHExtension.h"
#import "HHViewModelConstant.h"

@interface HHMVVMView ()<UITableViewDelegate, UITableViewDataSource>
/**
 viewmodel
 */
@property (nonatomic, strong) HHMVVMViewModel *viewModel;
/**
 当前的tableview
 */
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation HHMVVMView

+(BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (instancetype)initWithViewModel:(HHMVVMViewModel *)viewModel {
    if (self = [super init]) {
        self.viewModel = viewModel;
        [self addSubview:self.tableView];
        [self bindViewModel];
    }
    return self;
}

- (void)updateConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    [super updateConstraints];
}

- (void)bindViewModel
{
    [self.tableView hh_beginRefreshing];
    @weakify(self)
    [[self.viewModel.refreshEndSubject delay:0.5] subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
        switch ([x integerValue])
        {
            case HHHeaderRefresh_HasMoreData:
            {
                [self.tableView hh_endRefreshing];
                self.tableView.mj_footer.hidden = NO;
                break;
            }
            case HHHeaderRefresh_NoMoreData:
            {
                [self.tableView hh_endRefreshing];
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                if(self.viewModel.dataArrayCount == 0)
                {
                    self.tableView.mj_footer.hidden = YES;
                }
                else
                {
                    self.tableView.mj_footer.hidden = NO;
                }
                break;
            }
            case HHFooterRefresh_HasMoreData:
            {
                [self.tableView.mj_footer endRefreshing];
                break;
            }
            case HHFooterRefresh_NoMoreData:
            {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                break;
            }
            case HHRefreshError:
            {
                [self.tableView hh_endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                break;
            }
        }
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HHTableViewCell identifier]];
    cell.model = [self.viewModel.dataArray objectAtIndex:indexPath.row];
    return cell;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, HHSCREENWIDTH, HHSCREENHEIGHT - 64) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
//        _tableView.tableHeaderView = [self liveHeaderView];
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[HHTableViewCell class] forCellReuseIdentifier:[HHTableViewCell identifier]];
        @weakify(self)
        [_tableView hh_headerWithRefreshingBlock:^{
            @strongify(self)
            [self.viewModel.loadLatestDataCommand execute:nil];
        }];
        [_tableView hh_footerWithRefreshingBlock:^{
            @strongify(self)
            [self.viewModel.loadMoreDataCommand execute:nil];
        }];
    }
    return _tableView;
}

@end
