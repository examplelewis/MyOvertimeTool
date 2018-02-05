//
//  ViewController.m
//  MyOvertimeTool
//
//  Created by 龚宇 on 17/12/11.
//  Copyright © 2017年 gongyuTest. All rights reserved.
//

#import "ViewController.h"
#import "MOTOvertimeMainViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSArray *titles;
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
    titles = @[@"加班记录"];
    
    // UI
    _tableView.rowHeight = 44;
    _tableView.tableFooterView = [UIView new];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return titles.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mainCell"];
    }
    
    cell.textLabel.text = titles[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        MOTOvertimeMainViewController *vc = [[MOTOvertimeMainViewController alloc] initWithNibName:@"MOTOvertimeMainViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        
    }
}

@end
