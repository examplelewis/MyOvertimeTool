//
//  ViewController.m
//  MyOvertimeTool
//
//  Created by 龚宇 on 17/12/11.
//  Copyright © 2017年 gongyuTest. All rights reserved.
//

#import "ViewController.h"
#import "MOTAddOvertimeViewController.h"
#import "MOTOvertimeListViewController.h"

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
    headers = @[@"Dashboard", @"添加", @"记录", @"设置"];
    titles = @[@[@"可调休天数", @"最近一次加班的日期", @"最近一次调休的日期"], @[@"添加一次加班", @"添加一次调休"], @[@"加班记录", @"调休记录"], @[@"设置"]];
    values = [NSMutableArray arrayWithArray:@[@"", @"", @""]];
    
    // UI
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSString *restDays = [NSString stringWithFormat:@"%.1f 天", [[FMDBManager sharedManager] getRestDays]];
    NSString *latestOvertime = [[FMDBManager sharedManager] getLatestTimeOfOvertime];
    values = [NSMutableArray arrayWithArray:@[restDays, latestOvertime, @"3"]];
    
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    
    if (indexPath.section == 0) {
        return;
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            MOTAddOvertimeViewController *vc = [[MOTAddOvertimeViewController alloc] initWithNibName:@"MOTAddOvertimeViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            MOTOvertimeListViewController *vc = [[MOTOvertimeListViewController alloc] initWithNibName:@"MOTOvertimeListViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            
        }
    } else {
        
    }
}

@end
