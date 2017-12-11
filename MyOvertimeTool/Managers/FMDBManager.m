//
//  FMDBManager.m
//  MyOvertimeTool
//
//  Created by 龚宇 on 17/12/11.
//  Copyright © 2017年 gongyuTest. All rights reserved.
//

#import "FMDBManager.h"
#import "BFPaths.h"

@implementation FMDBManager

#pragma mark - 单例模式
static FMDBManager *_sharedManager;
+ (FMDBManager *)sharedManager {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedManager = [[FMDBManager alloc] init];
    });
    
    return _sharedManager;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        [self createDatabase];
        if ([db open]) {
            [self createTable];
            [db close];
        } else {
            NSString *errorMsg = [NSString stringWithFormat:@"打开数据库时发生错误: %@", [db lastErrorMessage]];
            [[ToastManager sharedManager] showError:errorMsg];
            [[LogManager sharedManager] logError:errorMsg data:nil];
        }
    }
    
    return self;
}

#pragma mark - 创建数据库
- (void)createDatabase {
    db = [FMDatabase databaseWithPath:BFPathForDocumentsResource(@"data.sqlite")];
}
- (void)createTable {
    if (![db open]) {
        
        
        return;
    }
    
    if (![db tableExists:@"MOTOvertime"]) {
        BOOL success = [db executeUpdate:@"CREATE TABLE MOTOvertime(id integer PRIMARY KEY AUTOINCREMENT, reason text, time text, type integer, addtime text, used boolean)"];
        
        if (!success) {
            NSString *errorMsg = [NSString stringWithFormat:@"数据表 MOTOvertime 不存在且建立失败: %@", [db lastErrorMessage]];
            [[ToastManager sharedManager] showError:errorMsg];
            [[LogManager sharedManager] logError:errorMsg data:nil];
        }
    }
    
    if (![db tableExists:@"MOTRest"]) {
        BOOL success = [db executeUpdate:@"CREATE TABLE MOTRest(id integer PRIMARY KEY AUTOINCREMENT, reason text, time text, type integer, addtime text)"];
        
        if (!success) {
            NSString *errorMsg = [NSString stringWithFormat:@"数据表 MOTRest 不存在且建立失败: %@", [db lastErrorMessage]];
            [[ToastManager sharedManager] showError:errorMsg];
            [[LogManager sharedManager] logError:errorMsg data:nil];
        }
    }
    
    if (![db tableExists:@"MOTSetting"]) {
        BOOL success = [db executeUpdate:@"CREATE TABLE MOTSetting(id integer PRIMARY KEY AUTOINCREMENT, title text, value text, key text, desc text)"];
        
        if (!success) {
            NSString *errorMsg = [NSString stringWithFormat:@"数据表 MOTSetting 不存在且建立失败: %@", [db lastErrorMessage]];
            [[ToastManager sharedManager] showError:errorMsg];
            [[LogManager sharedManager] logError:errorMsg data:nil];
            return;
        }
        
        [self insertNecessaryData];
    }
}
- (void)insertNecessaryData {
    BOOL success = [db executeUpdate:@"INSERT INTO MOTSetting (id, title, value, key, desc) values(?, ?, ?, ?, ?)", NULL, @"普通加班", @"2", @"overtimeType", @"2 次普通加班可换 1 天调休"];
    if (!success) {
        NSString *errorMsg = [NSString stringWithFormat:@"数据表 MOTSetting 添加数据失败: %@", [db lastErrorMessage]];
        NSString *errorData = [NSString stringWithFormat:@"id: %@, title: %@, value: %@, key:%@, desc: %@", NULL, @"普通加班", @"2", @"overtimeType", @"2 次普通加班可换 1 天调休"];
        [[ToastManager sharedManager] showError:errorMsg];
        [[LogManager sharedManager] logError:errorMsg data:errorData];
    }
    
    success = [db executeUpdate:@"INSERT INTO MOTSetting (id, title, value, key, desc) values(?, ?, ?, ?, ?)", NULL, @"调休加班", @"1", @"overtimeType", @"1 次调休加班可换 1 天调休"];
    if (!success) {
        NSString *errorMsg = [NSString stringWithFormat:@"数据表 MOTSetting 添加数据失败: %@", [db lastErrorMessage]];
        NSString *errorData = [NSString stringWithFormat:@"id: %@, title: %@, value: %@, key:%@, desc: %@", NULL, @"调休加班", @"1", @"overtimeType", @"1 次调休加班可换 1 天调休"];
        [[ToastManager sharedManager] showError:errorMsg];
        [[LogManager sharedManager] logError:errorMsg data:errorData];
    }
}

@end
