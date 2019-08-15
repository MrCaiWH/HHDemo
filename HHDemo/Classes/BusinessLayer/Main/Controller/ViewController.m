//
//  ViewController.m
//  HHDemo
//
//  Created by wanhong cai on 2019/8/12.
//  Copyright © 2019 huanghuacai. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "HHItem.h"

#import "HHTimerViewController.h"
#import "HHAsyncDrawViewController.h"
#import "HHBarrierViewController.h"

static NSString *const cellIdentifier =@"cellIdentifier";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"笔记列表";
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
    
    HHItem *item1 = [[HHItem alloc] initWithTitle:@"NSTimer循环引用" targetVc:[HHTimerViewController class]];
    [self.dataArray addObject:item1];
    
    HHItem *item2 = [[HHItem alloc] initWithTitle:@"异步绘制" targetVc:[HHAsyncDrawViewController class]];
    [self.dataArray addObject:item2];
    
    HHItem *item3 = [[HHItem alloc] initWithTitle:@"栅栏函数" targetVc:[HHBarrierViewController class]];
    [self.dataArray addObject:item3];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    HHItem *item = self.dataArray[indexPath.row];
    cell.textLabel.text = item.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1. 获取当前被选中的单元格的模型对象
    HHItem *item = self.dataArray[indexPath.row];
    
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
        _tableView.tableFooterView = [[UIView alloc] init];
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
