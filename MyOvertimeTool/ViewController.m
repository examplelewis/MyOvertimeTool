//
//  ViewController.m
//  MyOvertimeTool
//
//  Created by 龚宇 on 17/12/11.
//  Copyright © 2017年 gongyuTest. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSArray *titles;
    NSMutableArray *values;
    NSArray *headers;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"2018年";
    
    [self setupUIAndData];
}
- (void)setupUIAndData {
    // Data
    headers = @[@"Dashboard", @"操作", @"记录", @"设置"];
    titles = @[@[@"可调休天数", @"最近一次加班的日期", @"最近一次调休的日期"], @[@"添加一次加班", @"添加一次调休"], @[@"调休记录", @"加班记录"], @[@"设置"]];
    values = [NSMutableArray arrayWithArray:@[@"1", @"2", @"3"]];
    
    // UI
    _tableView.rowHeight = 44.0f;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return titles.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [titles[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mainCell"];
    }
    
    cell.textLabel.text = titles[indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        cell.detailTextLabel.text = values[indexPath.row];
    }
    cell.accessoryType = indexPath.section == 0 ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return headers[section];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

@end
