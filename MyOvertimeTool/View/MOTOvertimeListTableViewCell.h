//
//  MOTOvertimeListTableViewCell.h
//  MyOvertimeTool
//
//  Created by 龚宇 on 17/12/13.
//  Copyright © 2017年 gongyuTest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MOTOvertimeListTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *typeLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *reasonLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;

@end
