//
//  FMDBManager.h
//  MyOvertimeTool
//
//  Created by 龚宇 on 17/12/11.
//  Copyright © 2017年 gongyuTest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
#import "MOTSettingObject.h"

@interface FMDBManager : NSObject {
    FMDatabase *db;
}

@property (nonatomic, strong) NSArray<MOTSettingObject *> *overtimeTypes;
@property (nonatomic, strong) NSArray<MOTSettingObject *> *restLefts;

+ (FMDBManager *)sharedManager;

- (NSArray *)fetchAllOvertimes;
- (NSArray *)fetchAllRests;
- (BOOL)checkHasOvertimeOnDay:(NSString *)day;
- (NSString *)fetchLatestTimeOfOvertime;
- (NSString *)fetchLatestTimeOfRest;

- (BOOL)insertOvertimeWithReason:(NSString *)reason time:(NSString *)time type:(NSInteger)type;
- (BOOL)insertRestWithReason:(NSString *)reason start:(NSString *)start end:(NSString *)end startDetail:(NSString *)startDetail endDetail:(NSString *)endDetail total:(float)total;
- (BOOL)updateRestLeft:(float)day plus:(BOOL)plus;

@end
