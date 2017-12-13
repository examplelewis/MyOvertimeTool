//
//  MOTRestListViewController.m
//  MyOvertimeTool
//
//  Created by 龚宇 on 17/12/13.
//  Copyright © 2017年 gongyuTest. All rights reserved.
//

#import "MOTRestListViewController.h"
#import "MOTRestListTableViewCell.h"

@interface MOTRestListViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSArray *data;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MOTRestListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"调休记录";
    
    [self setupUIAndData];
}
- (void)setupUIAndData {
    // data
    data = [[FMDBManager sharedManager] fetchAllRests];
    
    // UI
    [_tableView registerNib:[UINib nibWithNibName:@"MOTRestListTableViewCell" bundle:nil] forCellReuseIdentifier:@"restListCell"];
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
    MOTRestListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"restListCell"];
    
    NSDictionary *rest = data[indexPath.row];

    cell.timeLabel.text = [NSString stringWithFormat:@"%@  ~  %@", rest[@"start"], rest[@"end"]];
    cell.reasonLabel.text = [NSString stringWithFormat:@"缘由：%@", rest[@"reason"]];
    cell.dayLabel.text = [NSString stringWithFormat:@"%@ 天", rest[@"total"]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
