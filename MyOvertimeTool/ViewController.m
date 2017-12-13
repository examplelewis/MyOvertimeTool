//
//  ViewController.m
//  MyOvertimeTool
//
//  Created by 龚宇 on 17/12/11.
//  Copyright © 2017年 gongyuTest. All rights reserved.
//

#import "ViewController.h"
#import "MOTAddOvertimeViewController.h"
#import "MOTAddRestViewController.h"
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
    
    NSString *restDays = [NSString stringWithFormat:@"%.1f 天", [[FMDBManager sharedManager] fetchRestDays]];
    NSString *latestOvertime = [[FMDBManager sharedManager] fetchLatestTimeOfOvertime];
    NSString *latestRest = [[FMDBManager sharedManager] fetchLatestTimeOfRest];
    values = [NSMutableArray arrayWithArray:@[restDays, latestOvertime, latestRest]];
    
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
    
    cell.textLabel.text = (indexPath.section == 0 && indexPath.row == 2) ? [NSString stringWithFormat:@"\n%@\n", titles[indexPath.section][indexPath.row]] : titles[indexPath.section][indexPath.row];
    cell.detailTextLabel.text = indexPath.section == 0 ? values[indexPath.row] : @"";
    cell.detailTextLabel.numberOfLines = (indexPath.section == 0 && indexPath.row == 2) ? 3 : 1;
    cell.textLabel.numberOfLines = (indexPath.section == 0 && indexPath.row == 2) ? 3 : 1;
    cell.accessoryType = indexPath.section == 0 ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.section == 0 && indexPath.row == 2) ? 88 : 44;
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
            MOTAddRestViewController *vc = [[MOTAddRestViewController alloc] initWithNibName:@"MOTAddRestViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
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
