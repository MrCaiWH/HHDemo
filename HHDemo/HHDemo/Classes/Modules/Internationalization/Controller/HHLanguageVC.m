//
//  HHLanguageVC.m
//  HHDemo
//
//  Created by 蔡万鸿 on 2017/3/15.
//  Copyright © 2017年 黄花菜. All rights reserved.
//

#import "HHLanguageVC.h"
#import "UITableView+HHExtension.h"

@interface HHLanguageVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray* dataSourceArray;
@end

@implementation HHLanguageVC
#pragma mark - View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"多语言环境";
    
    [self tableView];
    self.tableView.rowHeight = 57.f;
    self.tableView.separatorColor = [UIColor hexChangeFloat:@"e5e5e5"];
    self.tableView.contentInset = UIEdgeInsetsMake(-57.f, 0, 0, 0);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.textLabel.font = [UIFont systemFontOfSize:14.f];
    }
    cell.textLabel.text = self.dataSourceArray[indexPath.row];
    NSInteger num = [[[NSUserDefaults standardUserDefaults] objectForKey:language] integerValue];
    if (num == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    if(indexPath.row == 0) {
        cell.hidden = YES;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    if ([[defaults valueForKey:language] integerValue] == indexPath.row) return;
    [defaults setObject:@(indexPath.row) forKey:language];
    [defaults synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:HHSwitchAPPLanguageNotification object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Lazy
- (NSArray *)dataSourceArray {
    if (!_dataSourceArray) {
        _dataSourceArray = @[@"跟随手机系统", @"简体中文", @"English", @"日本の", @"한국의", @"臺灣繁體", @"香港繁體", @"Français"];
    }
    return _dataSourceArray;
}

-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, HHSCREEN_VERTICAL_WIDTH, HHSCREEN_VERTICAL_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView hiddenExtraCellLine];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
