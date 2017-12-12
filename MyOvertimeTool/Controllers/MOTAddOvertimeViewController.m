//
//  MOTAddOvertimeViewController.m
//  MyOvertimeTool
//
//  Created by 龚宇 on 17/12/12.
//  Copyright © 2017年 gongyuTest. All rights reserved.
//

#import "MOTAddOvertimeViewController.h"

@interface MOTAddOvertimeViewController () {
    NSArray *overtimeTypes;
    NSDictionary *overtimeType;
    
    UIAlertController *ac;
}

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UIButton *typeButton;
@property (strong, nonatomic) IBOutlet UITextView *reasonInput;

@end

@implementation MOTAddOvertimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加一次加班";
    UIBarButtonItem *rightBBI = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(rightBBIDidPressed:)];
    self.navigationItem.rightBarButtonItem = rightBBI;
    
    [self setupUIAndData];
}
- (void)setupUIAndData {
    // Data
    overtimeTypes = [[FMDBManager sharedManager] fetchOvertimeTypes];
    overtimeType = overtimeTypes.firstObject;
    
    // UI
    self.timeLabel.text = [[NSDate date] toNSString:@"yyyy-MM-dd"];
//    self.datePicker.minimumDate = [NSDate dateWithYear:2018 month:1 day:1];
    self.datePicker.maximumDate = [NSDate date];
    [self.typeButton roundCornorWithRadius:4.0 borderColor:nil borderWidth:0.0];
    [self.typeButton setTitle:overtimeType[@"title"] forState:UIControlStateNormal];
    [self.reasonInput roundCornorWithRadius:4.0 borderColor:BFCOLOR_GREY_300 borderWidth:1.0 / [UIScreen mainScreen].scale];
    
    ac = [UIAlertController alertControllerWithTitle:@"请选择加班类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (NSInteger i = 0; i < overtimeTypes.count; i++) {
        NSDictionary *type = overtimeTypes[i];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:type[@"title"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            overtimeType = type;
            [self.typeButton setTitle:overtimeType[@"title"] forState:UIControlStateNormal];
        }];
        
        [ac addAction:action];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)datePickerValueChanged:(UIDatePicker *)sender {
    self.timeLabel.text = [sender.date toNSString:@"yyyy-MM-dd"];
}
- (IBAction)changeOvertimeType:(UIButton *)sender {
    [self presentViewController:ac animated:YES completion:nil];
}
- (void)rightBBIDidPressed:(UIBarButtonItem *)sender {
    if (self.reasonInput.isFirstResponder) {
        [self.reasonInput resignFirstResponder];
    }
    
    if ([[FMDBManager sharedManager] checkHasOvertimeOnDay:[self.datePicker.date toNSString:@"yyyy-MM-dd"]]) {
        NSString *errorMsg = [NSString stringWithFormat:@"%@ 已经有一条加班记录，不可重复添加", [self.datePicker.date toNSString:@"yyyy-MM-dd"]];
        [[ToastManager sharedManager] showError:errorMsg];
        
        return;
    }
    
    if ([[FMDBManager sharedManager] insertOvertimeWithReason:self.reasonInput.text time:[self.datePicker.date toNSString:@"yyyy-MM-dd"] type:[overtimeType[@"id"] integerValue]]) {
        [[ToastManager sharedManager] showSuccess:@"添加成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
