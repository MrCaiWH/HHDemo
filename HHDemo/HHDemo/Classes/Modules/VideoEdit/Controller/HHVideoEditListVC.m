//
//  HHVideoEditListVC.m
//  HHDemo
//
//  Created by zero on 2017/5/2.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHVideoEditListVC.h"
#import "ZOItem.h"
#import "UITableView+HHExtension.h"
#import "HHAddMusicVC.h"

static NSString *const cellIdentifier =@"cellIdentifier";

@interface HHVideoEditListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HHVideoEditListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"视频编辑";
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
    
    [self.tableView hiddenExtraCellLine];
    
    ZOItem *item1 = [[ZOItem alloc] initWithTitle:@"增加背景音乐" targetVc:[HHAddMusicVC class]];
    [self.dataArray addObject:item1];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
