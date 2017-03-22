//
//  HHMainVC.m
//  HHDemo
//
//  Created by 蔡万鸿 on 2016/11/9.
//  Copyright © 2016年 黄花菜. All rights reserved.
//

#import "HHMainVC.h"
#import "ZOItem.h"
#import "HHEncodedVC.h"
#import "HHMVVMViewController.h"
#import "HHDownLoadVC.h"
#import "HHAnimationVC.h"
#import "UITableView+HHExtension.h"
#import "HHInternationalizationVC.h"
#import "HHCustomUIVC.h"
#import "HHResponderVC.h"
#import "HHNetStudyVC.h"

static NSString *const cellIdentifier =@"cellIdentifier";

@interface HHMainVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HHMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"笔记列表";
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
    
    [self.tableView hiddenExtraCellLine];
 
    ZOItem *item1 = [[ZOItem alloc] initWithTitle:@"编码" targetVc:[HHEncodedVC class]];
    [self.dataArray addObject:item1];
    
    ZOItem *item2 = [[ZOItem alloc] initWithTitle:@"MVVM和RAC" targetVc:[HHMVVMViewController class]];
    [self.dataArray addObject:item2];
    
    ZOItem *item3 = [[ZOItem alloc] initWithTitle:@"断点续传" targetVc:[HHDownLoadVC class]];
    [self.dataArray addObject:item3];
    
    ZOItem *item4 = [[ZOItem alloc] initWithTitle:@"动画" targetVc:[HHAnimationVC class]];
    [self.dataArray addObject:item4];
    
    ZOItem *item5 = [[ZOItem alloc] initWithTitle:@"国际化" targetVc:[HHInternationalizationVC class]];
    [self.dataArray addObject:item5];
    
    ZOItem *item6 = [[ZOItem alloc] initWithTitle:@"自定义UI" targetVc:[HHCustomUIVC class]];
    [self.dataArray addObject:item6];
    
    ZOItem *item7 = [[ZOItem alloc] initWithTitle:@"响应链" targetVc:[HHResponderVC class]];
    [self.dataArray addObject:item7];
    
    ZOItem *item8 = [[ZOItem alloc] initWithTitle:@"网络学习" targetVc:[HHNetStudyVC class]];
    [self.dataArray addObject:item8];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    ZOItem *item = self.dataArray[indexPath.row];
    cell.textLabel.text = item.title;
    return cell;
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1. 获取当前被选中的单元格的模型对象
    ZOItem *item = self.dataArray[indexPath.row];
  
    Class targetVc = item.targetVc;
    
    // 创建target的对象
    UIViewController *vc = [[targetVc alloc] init];
    if (vc != nil) {
        // 执行跳转
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
