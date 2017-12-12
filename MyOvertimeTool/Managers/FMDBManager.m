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
            [self openDatabaseError];
        }
    }
    
    return self;
}
- (void)openDatabaseError {
    NSString *errorMsg = [NSString stringWithFormat:@"打开数据库时发生错误: %d - %@", [db lastErrorCode], [db lastErrorMessage]];
    [[ToastManager sharedManager] showError:errorMsg];
    [[LogManager sharedManager] logError:errorMsg data:nil];
}

#pragma mark - 创建数据库
- (void)createDatabase {
    db = [FMDatabase databaseWithPath:BFPathForDocumentsResource(@"data.sqlite")];
}
- (void)createTable {
    if (![db tableExists:@"MOTOvertime"]) {
        BOOL success = [db executeUpdate:@"CREATE TABLE MOTOvertime(id integer PRIMARY KEY AUTOINCREMENT, reason text, time text, type integer, addtime text, used integer)"];
        
        if (!success) {
            NSString *errorMsg = [NSString stringWithFormat:@"数据表 MOTOvertime 不存在且建立失败: %d - %@", [db lastErrorCode], [db lastErrorMessage]];
            [[ToastManager sharedManager] showError:errorMsg];
            [[LogManager sharedManager] logError:errorMsg data:nil];
        }
    }
    
    if (![db tableExists:@"MOTRest"]) {
        BOOL success = [db executeUpdate:@"CREATE TABLE MOTRest(id integer PRIMARY KEY AUTOINCREMENT, reason text, time text, type integer, addtime text)"];
        
        if (!success) {
            NSString *errorMsg = [NSString stringWithFormat:@"数据表 MOTRest 不存在且建立失败: %d - %@", [db lastErrorCode], [db lastErrorMessage]];
            [[ToastManager sharedManager] showError:errorMsg];
            [[LogManager sharedManager] logError:errorMsg data:nil];
        }
    }
    
    if (![db tableExists:@"MOTSetting"]) {
        BOOL success = [db executeUpdate:@"CREATE TABLE MOTSetting(id integer PRIMARY KEY AUTOINCREMENT, title text, value text, key text, desc text)"];
        
        if (!success) {
            NSString *errorMsg = [NSString stringWithFormat:@"数据表 MOTSetting 不存在且建立失败:%d - %@", [db lastErrorCode], [db lastErrorMessage]];
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
        NSString *errorMsg = [NSString stringWithFormat:@"数据表 MOTSetting 添加数据失败: %d - %@", [db lastErrorCode], [db lastErrorMessage]];
        NSString *errorData = [NSString stringWithFormat:@"id: %@, title: %@, value: %@, key:%@, desc: %@", NULL, @"普通加班", @"2", @"overtimeType", @"2 次普通加班可换 1 天调休"];
        [[ToastManager sharedManager] showError:errorMsg];
        [[LogManager sharedManager] logError:errorMsg data:errorData];
    }
    
    success = [db executeUpdate:@"INSERT INTO MOTSetting (id, title, value, key, desc) values(?, ?, ?, ?, ?)", NULL, @"调休加班", @"1", @"overtimeType", @"1 次调休加班可换 1 天调休"];
    if (!success) {
        NSString *errorMsg = [NSString stringWithFormat:@"数据表 MOTSetting 添加数据失败: %d - %@", [db lastErrorCode], [db lastErrorMessage]];
        NSString *errorData = [NSString stringWithFormat:@"id: %@, title: %@, value: %@, key:%@, desc: %@", NULL, @"调休加班", @"1", @"overtimeType", @"1 次调休加班可换 1 天调休"];
        [[ToastManager sharedManager] showError:errorMsg];
        [[LogManager sharedManager] logError:errorMsg data:errorData];
    }
}

#pragma mark - 业务逻辑
- (NSArray *)fetchOvertimeTypes {
    if (![db open]) {
        [self openDatabaseError];
        
        return @[];
    }
    
    // 为数据库设置缓存，提高查询效率
    [db setShouldCacheStatements:YES];
    
    NSMutableArray *fetched = [NSMutableArray array];
    FMResultSet *rs = [db executeQuery:@"select * from MOTSetting where key = 'overtimeType'"];
    while ([rs next]) {
        NSInteger typeId = [rs intForColumn:@"id"];
        NSString *title = [rs stringForColumn:@"title"];
        NSString *value = [rs stringForColumn:@"value"];
        NSString *key = [rs stringForColumn:@"key"];
        NSString *desc = [rs stringForColumn:@"desc"];
        
        [fetched addObject:@{@"id": @(typeId), @"title": title, @"value": value, @"key": key, @"desc": desc}];
    }
    
    [rs close];
    [db close];
    
    return [fetched copy];
}
/**
 * 这个 type 就是 MOTSetting 表里的 id，也就是 fetchOvertimeTypes() 方法返回的数组里每个字典的 id 对应的值
 */
- (BOOL)insertOvertimeWithReason:(NSString *)reason time:(NSString *)time type:(NSInteger)type {
    if (![db open]) {
        [self openDatabaseError];
        
        return NO;
    }
    
    // 为数据库设置缓存，提高查询效率
    [db setShouldCacheStatements:YES];
    
    NSString *addtime = [[NSDate date] toNSString:@"yyyy-MM-dd HH:mm:ss.SSS"];
    BOOL success = [db executeUpdate:@"INSERT INTO MOTOvertime (id, reason, time, type, addtime, used) values(?, ?, ?, ?, ?, ?)", NULL, reason, time, @(type), addtime, @(0)];
    
    [db close];
    
    if (!success) {
        NSString *errorMsg = [NSString stringWithFormat:@"数据表 MOTOvertime 添加数据失败: %d - %@", [db lastErrorCode], [db lastErrorMessage]];
        NSString *errorData = [NSString stringWithFormat:@"id: NULL, reason: %@, time: %@, type: %ld, addtime: %@, used: 0", reason, time, type, addtime];
        [[ToastManager sharedManager] showError:errorMsg];
        [[LogManager sharedManager] logError:errorMsg data:errorData];
    }
    return success;
}
- (BOOL)checkHasOvertimeOnDay:(NSString *)day {
    if (![db open]) {
        [self openDatabaseError];
        
        return YES; // 这个地方可能出现重复提示的问题
    }
    
    // 为数据库设置缓存，提高查询效率
    [db setShouldCacheStatements:YES];
    
    NSInteger found = 0;
    FMResultSet *rs = [db executeQuery:@"select * from MOTOvertime where time = ?", day];
    while ([rs next]) {
        found++;
    }
    [rs close];
    [db close];
    
    return found != 0;
}
- (NSArray *)fetchOvertimeAvailableForRest {
    if (![db open]) {
        [self openDatabaseError];
        
        return @[];
    }
    
    // 为数据库设置缓存，提高查询效率
    [db setShouldCacheStatements:YES];
    
    NSMutableArray *fetched = [NSMutableArray array];
    FMResultSet *rs = [db executeQuery:@"select * from MOTOvertime where used = 0"];
    while ([rs next]) {
        NSInteger overtimeId = [rs intForColumn:@"id"];
        NSString *reason = [rs stringForColumn:@"reason"];
        NSString *time = [rs stringForColumn:@"time"];
        NSInteger type = [rs intForColumn:@"type"];
        NSString *addtime = [rs stringForColumn:@"addtime"];
        NSInteger used = [rs intForColumn:@"used"];
        
        [fetched addObject:@{@"id": @(overtimeId), @"reason": reason, @"time": time, @"type": @(type), @"addtime": addtime, @"used": @(used)}];
    }
    
    [rs close];
    [db close];
    
    return [fetched copy];
}
- (float)getRestDays {
    NSArray *types = [self fetchOvertimeTypes];
    NSArray *overtimes = [self fetchOvertimeAvailableForRest];
    
    float total = 0.0;
    for (NSInteger i = 0; i < overtimes.count; i++) {
        NSDictionary *overtime = overtimes[i];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id = %ld", [overtime[@"type"] integerValue]];
        NSDictionary *type = [types filteredArrayUsingPredicate:predicate].firstObject;
        
        total += 1.0 / [type[@"value"] integerValue];
    }
    
    return total;
}
- (NSString *)getLatestTimeOfOvertime {
    if (![db open]) {
        [self openDatabaseError];
        
        return @"没有记录";
    }
    
    // 为数据库设置缓存，提高查询效率
    [db setShouldCacheStatements:YES];
    
    NSString *result = @"没有记录";
    FMResultSet *rs = [db executeQuery:@"select time from MOTOvertime where used = 0 order by time desc limit 1"];
    while ([rs next]) {
        result = [rs stringForColumn:@"time"];
    }
    
    [rs close];
    [db close];
    
    return [result copy];
}

@end
