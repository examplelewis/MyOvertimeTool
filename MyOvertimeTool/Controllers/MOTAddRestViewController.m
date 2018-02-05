//
//  MOTAddRestViewController.m
//  MyOvertimeTool
//
//  Created by 龚宇 on 17/12/13.
//  Copyright © 2017年 gongyuTest. All rights reserved.
//

#import "MOTAddRestViewController.h"
#import <DTTimePeriod.h>

@interface MOTAddRestViewController () <UIPickerViewDelegate, UIPickerViewDataSource> {
    NSArray *pickerData;
    NSString *fromSelected;
    NSString *endSelected;
}

@property (strong, nonatomic) IBOutlet UITextView *reasonInput;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalLabel;
@property (strong, nonatomic) IBOutlet UIDatePicker *fromDatePicker;
@property (strong, nonatomic) IBOutlet UIPickerView *fromPicker;
@property (strong, nonatomic) IBOutlet UIDatePicker *endDatePicker;
@property (strong, nonatomic) IBOutlet UIPickerView *endPicker;

@end

@implementation MOTAddRestViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加一次调休";
    UIBarButtonItem *rightBBI = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(rightBBIDidPressed:)];
    self.navigationItem.rightBarButtonItem = rightBBI;
    
    [self setupUIAndData];
}
- (void)setupUIAndData {
    // Data
    pickerData = @[@"上午", @"下午"];
    fromSelected = pickerData[0];
    endSelected = pickerData[0];
    
    // UI
    // 这个地方不直接使用 [NSDate date]，是因为此时 endDatePicker 和 startDatePicker 会有一个时间差，哪怕只有几毫秒，也会影响 DateTools 中 daysFrom: 方法的结果
    NSDate *today = [NSDate date];
    self.fromDatePicker.minimumDate = [NSDate dateWithYear:today.year month:today.month day:today.day];
    self.endDatePicker.minimumDate = [NSDate dateWithYear:today.year month:today.month day:today.day];
    self.fromDatePicker.date = [NSDate dateWithYear:today.year month:today.month day:today.day];
    self.endDatePicker.date = [NSDate dateWithYear:today.year month:today.month day:today.day];
    
    self.dateLabel.text = [NSString stringWithFormat:@"%@ %@", [self.fromDatePicker.date toNSString:@"yyyy-MM-dd"], fromSelected];
    self.totalLabel.text = @"共 0.5 天";
    [self.fromPicker selectRow:0 inComponent:0 animated:YES];
    [self.endPicker selectRow:0 inComponent:0 animated:YES];
    [self.reasonInput roundCornorWithRadius:4.0 borderColor:BFCOLOR_GREY_300 borderWidth:1.0 / [UIScreen mainScreen].scale];
    [self.fromDatePicker addTarget:self action:@selector(fromDatePickerDidChange:) forControlEvents:UIControlEventValueChanged];
    [self.endDatePicker addTarget:self action:@selector(endDatePickerDidChange:) forControlEvents:UIControlEventValueChanged];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIPickerViewDataSource & UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return pickerData.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return pickerData[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView.tag == 1) {
        fromSelected = pickerData[row];
    } else {
        endSelected = pickerData[row];
    }
    
    // 只有 起止日期相同 才应考虑修改 picker 的内容
    if ([[self.fromDatePicker.date toNSString:@"yyyy-MM-dd"] isEqualToString:[self.endDatePicker.date toNSString:@"yyyy-MM-dd"]]) {
        // 如果 fromPicker 选中的值是下午，那么 endPicker 的值应当变成下午
        if (pickerView.tag == 1 && row == 1 && [endSelected isEqualToString:@"上午"]) {
            [self.endPicker selectRow:1 inComponent:0 animated:YES];
            endSelected = pickerData[1];
        }
        
        // 如果 endPicker 选中的值是上午，那么 fromPicker 的值应当变成上午
        if (pickerView.tag == 2 && row == 0 && [fromSelected isEqualToString:@"下午"]) {
            [self.fromPicker selectRow:0 inComponent:0 animated:YES];
            fromSelected = pickerData[0];
        }
    }
    
    self.dateLabel.text = [self getDateText];
    self.totalLabel.text = [NSString stringWithFormat:@"共 %.1f 天", [self calcTotalDays]];
}

#pragma mark - Action
- (void)rightBBIDidPressed:(UIBarButtonItem *)sender {
    if (self.reasonInput.isFirstResponder) {
        [self.reasonInput resignFirstResponder];
    }
    
    // 为 DTTimePeriod 做准备
    NSString *fromDetail = [self.fromDatePicker.date toNSString:@"yyyy-MM-dd"];
    if ([fromSelected isEqualToString:@"上午"]) {
        fromDetail = [fromDetail stringByAppendingString:@" 00:00:00.000"];
    } else {
        fromDetail = [fromDetail stringByAppendingString:@" 12:00:00.000"];
    }
    NSString *endDetail = [self.endDatePicker.date toNSString:@"yyyy-MM-dd"];
    if ([endSelected isEqualToString:@"上午"]) {
        endDetail = [endDetail stringByAppendingString:@" 11:59:59.999"];
    } else {
        endDetail = [endDetail stringByAppendingString:@" 23:59:59.999"];
    }
    NSDate *currentFromDate = [NSDate dateFromNSString:fromDetail withFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSDate *currentEndDate = [NSDate dateFromNSString:endDetail withFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    DTTimePeriod *currentPeriod = [DTTimePeriod timePeriodWithStartDate:currentFromDate endDate:currentEndDate];
    
    // 查询当天是否有调休记录
    NSArray *rests = [[FMDBManager sharedManager] fetchAllRests];
    BOOL isRestIntersect = NO;
    for (NSInteger i = 0; i < rests.count; i++) {
        NSDictionary *rest = rests[i];
        
        NSDate *fromDate = [NSDate dateFromNSString:rest[@"startDetail"] withFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
        NSDate *endDate = [NSDate dateFromNSString:rest[@"endDetail"] withFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
        DTTimePeriod *period = [DTTimePeriod timePeriodWithStartDate:fromDate endDate:endDate];
        
        if ([currentPeriod intersects:period]) {
            isRestIntersect = YES;
            break;
        }
    }
    if (isRestIntersect) {
        [[ToastManager sharedManager] showError:@"选定的日期与调休已有记录冲突，不可重复添加"];
        return;
    }
    
    // 查询当天是否有加班记录
    NSArray *overtimes = [[FMDBManager sharedManager] fetchAllOvertimes];
    BOOL isOvertimeIntersect = NO;
    for (NSInteger i = 0; i < overtimes.count; i++) {
        NSDictionary *overtime = overtimes[i];
        
        NSDate *fromDate = [NSDate dateFromNSString:overtime[@"start"] withFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
        NSDate *endDate = [NSDate dateFromNSString:overtime[@"end"] withFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
        DTTimePeriod *period = [DTTimePeriod timePeriodWithStartDate:fromDate endDate:endDate];
        
        if ([currentPeriod intersects:period]) {
            isOvertimeIntersect = YES;
            break;
        }
    }
    if (isOvertimeIntersect) {
        [[ToastManager sharedManager] showError:@"选定的日期与加班已有记录冲突，不可重复添加"];
        return;
    }
    
    // 再查询还有几天假
    if ([[FMDBManager sharedManager].restLefts.firstObject.value floatValue] < [self calcTotalDays]) {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"警告" message:@"调休的天数大于可调休的天数，这意味着需要另行请假，是否继续？" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"是，确认请假" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self commitRest];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"否，返回修改" style:UIAlertActionStyleCancel handler:nil];
        
        [ac addAction:confirmAction];
        [ac addAction:cancelAction];
        
        [self presentViewController:ac animated:YES completion:nil];
    } else {
        [self commitRest];
    }
}
- (void)fromDatePickerDidChange:(UIDatePicker *)sender {
    self.endDatePicker.minimumDate = sender.date;
    
    self.dateLabel.text = [self getDateText];
    self.totalLabel.text = [NSString stringWithFormat:@"共 %.1f 天", [self calcTotalDays]];
}
- (void)endDatePickerDidChange:(UIDatePicker *)sender {
    self.fromDatePicker.maximumDate = sender.date;
    
    self.dateLabel.text = [self getDateText];
    self.totalLabel.text = [NSString stringWithFormat:@"共 %.1f 天", [self calcTotalDays]];
}

#pragma mark - Other
- (void)commitRest {
    NSString *from = [NSString stringWithFormat:@"%@ %@", [self.fromDatePicker.date toNSString:@"yyyy-MM-dd"], fromSelected];
    NSString *end = [NSString stringWithFormat:@"%@ %@", [self.endDatePicker.date toNSString:@"yyyy-MM-dd"], endSelected];
    NSString *fromDetail = [self.fromDatePicker.date toNSString:@"yyyy-MM-dd"];
    if ([fromSelected isEqualToString:@"上午"]) {
        fromDetail = [fromDetail stringByAppendingString:@" 00:00:00.000"];
    } else {
        fromDetail = [fromDetail stringByAppendingString:@" 12:00:00.000"];
    }
    NSString *endDetail = [self.endDatePicker.date toNSString:@"yyyy-MM-dd"];
    if ([endSelected isEqualToString:@"上午"]) {
        endDetail = [endDetail stringByAppendingString:@" 11:59:59.999"];
    } else {
        endDetail = [endDetail stringByAppendingString:@" 23:59:59.999"];
    }
    if ([[FMDBManager sharedManager] insertRestWithReason:self.reasonInput.text start:from end:end startDetail:fromDetail endDetail:endDetail total:[self calcTotalDays]]) {
        if ([[FMDBManager sharedManager] updateRestLeft:[self calcTotalDays] plus:NO]) {
            [[ToastManager sharedManager] showSuccess:@"添加成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
- (float)calcTotalDays {
    float total = 0.0;
    
    if ([[self.fromDatePicker.date toNSString:@"yyyy-MM-dd"] isEqualToString:[self.endDatePicker.date toNSString:@"yyyy-MM-dd"]]) {
        total = [fromSelected isEqualToString:endSelected] ? 0.5 : 1.0;
    } else {
        total = [self.endDatePicker.date daysFrom:self.fromDatePicker.date];
        
        // 从 上午 到 上午 或者 从 下午 到 下午
        if ([fromSelected isEqualToString:endSelected]) {
            total += 0.5;
        } else {
            if ([fromSelected isEqualToString:@"上午"]) { // 从 上午 到 下午
                total += 1;
            } else { // 从 下午 到 上午
                // do nothing...
            }
        }
    }
    
    return total;
}
- (NSString *)getDateText {
    if ([[self.fromDatePicker.date toNSString:@"yyyy-MM-dd"] isEqualToString:[self.endDatePicker.date toNSString:@"yyyy-MM-dd"]]) {
        if ([fromSelected isEqualToString:endSelected]) {
            return [NSString stringWithFormat:@"%@ %@", [self.fromDatePicker.date toNSString:@"yyyy-MM-dd"], fromSelected];
        } else {
            return [NSString stringWithFormat:@"%@ 全天", [self.fromDatePicker.date toNSString:@"yyyy-MM-dd"]];
        }
    } else {
        return [NSString stringWithFormat:@"%@ %@  ~  %@ %@", [self.fromDatePicker.date toNSString:@"yyyy-MM-dd"], fromSelected, [self.endDatePicker.date toNSString:@"yyyy-MM-dd"], endSelected];
    }
}

@end
