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
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"idI = %ld", [overtime[@"type"] integerValue]];
    MOTSettingObject *type = [[FMDBManager sharedManager].overtimeTypes filteredArrayUsingPredicate:predicate].firstObject;
    cell.typeLabel.text = type.title;
    cell.timeLabel.text = overtime[@"time"];
    cell.reasonLabel.text = [NSString stringWithFormat:@"缘由：%@", overtime[@"reason"]];
    cell.statusLabel.text = [NSString stringWithFormat:@"%.1f", 1.0 / [type.value floatValue]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
