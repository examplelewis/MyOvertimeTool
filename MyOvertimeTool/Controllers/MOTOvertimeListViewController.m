//
//  MOTOvertimeListViewController.m
//  MyOvertimeTool
//
//  Created by 龚宇 on 17/12/13.
//  Copyright © 2017年 gongyuTest. All rights reserved.
//

#import "MOTOvertimeListViewController.h"
#import "MOTOvertimeListTableViewCell.h"

@interface MOTOvertimeListViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSArray *data;
    NSArray *types;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MOTOvertimeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"加班记录";
    
    [self setupUIAndData];
}
- (void)setupUIAndData {
    // data
    data = [[FMDBManager sharedManager] fetchAllOvertimes];
    types = [[FMDBManager sharedManager] fetchOvertimeTypes];
    
    // UI
    [_tableView registerNib:[UINib nibWithNibName:@"MOTOvertimeListTableViewCell" bundle:nil] forCellReuseIdentifier:@"overtimeListCell"];
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.tableFooterView = [UIView new];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MOTOvertimeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"overtimeListCell"];
    
    NSDictionary *overtime = data[indexPath.row];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id = %ld", [overtime[@"type"] integerValue]];
    NSDictionary *type = [types filteredArrayUsingPredicate:predicate].firstObject;
    cell.typeLabel.text = type[@"title"];
    cell.timeLabel.text = overtime[@"time"];
    cell.reasonLabel.text = [NSString stringWithFormat:@"缘由：%@", overtime[@"reason"]];
    cell.statusLabel.text = [overtime[@"used"] integerValue] == 0 ? @"可调休" : @"已调休";
    cell.statusLabel.textColor = [UIColor colorWithHexString:[overtime[@"used"] integerValue] == 0 ? @"42d852" : @"d9453d"];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
