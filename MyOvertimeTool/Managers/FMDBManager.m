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
            [self fetchAllSettings];
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
//    NSLog(@"%@", BFPathForDocumentsResource(@"data.sqlite"));
    db = [FMDatabase databaseWithPath:BFPathForDocumentsResource(@"data.sqlite")];
}
- (void)createTable {
    if (![db tableExists:@"MOTOvertime"]) {
        BOOL success = [db executeUpdate:@"CREATE TABLE MOTOvertime(id integer PRIMARY KEY AUTOINCREMENT, reason text, time text, start text, end text, type integer, addtime text)"];
        
        if (!success) {
            NSString *errorMsg = [NSString stringWithFormat:@"数据表 MOTOvertime 不存在且建立失败: %d - %@", [db lastErrorCode], [db lastErrorMessage]];
            [[ToastManager sharedManager] showError:errorMsg];
            [[LogManager sharedManager] logError:errorMsg data:nil];
        }
    }
    
    if (![db tableExists:@"MOTRest"]) {
        BOOL success = [db executeUpdate:@"CREATE TABLE MOTRest(id integer PRIMARY KEY AUTOINCREMENT, reason text, start text, end text, startDetail text, endDetail text, total text, addtime text)"];
        
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
    
    success = [db executeUpdate:@"INSERT INTO MOTSetting (id, title, value, key, desc) values(?, ?, ?, ?, ?)", NULL, @"剩余可调休", @"0.0", @"restLeft", @"还有多少天可以用于调休"];
    if (!success) {
        NSString *errorMsg = [NSString stringWithFormat:@"数据表 MOTSetting 添加数据失败: %d - %@", [db lastErrorCode], [db lastErrorMessage]];
        NSString *errorData = [NSString stringWithFormat:@"id: %@, title: %@, value: %@, key:%@, desc: %@", NULL, @"剩余可调休", @"0.0", @"restLeft", @"还有多少天可以用于调休"];
        [[ToastManager sharedManager] showError:errorMsg];
        [[LogManager sharedManager] logError:errorMsg data:errorData];
    }
}

#pragma mark - 业务逻辑 - 查询
/**
 * 查询所有的设置参数
 */
- (void)fetchAllSettings {
    if (![db open]) {
        [self openDatabaseError];
        _overtimeTypes = @[];
        _restLefts = @[];
        
        return;
    }
    
    // 为数据库设置缓存，提高查询效率
    [db setShouldCacheStatements:YES];
    
    NSMutableArray *fetched = [NSMutableArray array];
    FMResultSet *rs = [db executeQuery:@"select * from MOTSetting"];
    while ([rs next]) {
        NSInteger typeId = [rs intForColumn:@"id"];
        NSString *title = [rs stringForColumn:@"title"];
        NSString *value = [rs stringForColumn:@"value"];
        NSString *key = [rs stringForColumn:@"key"];
        NSString *desc = [rs stringForColumn:@"desc"];
        
        NSDictionary *dictionary = @{@"id": @(typeId), @"title": title, @"value": value, @"key": key, @"desc": desc};
        MOTSettingObject *object = [[MOTSettingObject alloc] initWithDictionary:dictionary];
        [fetched addObject:object];
    }
    
    _overtimeTypes = [fetched filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"type = %ld", MOTSettingOvertimeType]];
    _restLefts = [fetched filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"type = %ld", MOTSettingRestLeft]];
    
    [rs close];
    [db close];
}
/**
 * 查询所有的加班
 */
- (NSArray *)fetchAllOvertimes {
    if (![db open]) {
        [self openDatabaseError];
        
        return @[];
    }
    
    // 为数据库设置缓存，提高查询效率
    [db setShouldCacheStatements:YES];
    
    NSMutableArray *fetched = [NSMutableArray array];
    FMResultSet *rs = [db executeQuery:@"select * from MOTOvertime order by time desc"];
    while ([rs next]) {
        NSInteger overtimeId = [rs intForColumn:@"id"];
        NSString *reason = [rs stringForColumn:@"reason"];
        NSString *time = [rs stringForColumn:@"time"];
        NSString *start = [rs stringForColumn:@"start"];
        NSString *end = [rs stringForColumn:@"end"];
        NSInteger type = [rs intForColumn:@"type"];
        NSString *addtime = [rs stringForColumn:@"addtime"];
        
        [fetched addObject:@{@"id": @(overtimeId), @"reason": reason, @"time": time, @"start": start, @"end": end, @"type": @(type), @"addtime": addtime}];
    }
    
    [rs close];
    [db close];
    
    return [fetched copy];
}
/**
 * 查询所有的休息
 */
- (NSArray *)fetchAllRests {
    if (![db open]) {
        [self openDatabaseError];
        
        return @[];
    }
    
    // 为数据库设置缓存，提高查询效率
    [db setShouldCacheStatements:YES];
    
    NSMutableArray *fetched = [NSMutableArray array];
    FMResultSet *rs = [db executeQuery:@"select * from MOTRest order by start desc"];
    while ([rs next]) {
        NSInteger restId = [rs intForColumn:@"id"];
        NSString *reason = [rs stringForColumn:@"reason"];
        NSString *start = [rs stringForColumn:@"start"];
        NSString *end = [rs stringForColumn:@"end"];
        NSString *startDetail = [rs stringForColumn:@"startDetail"];
        NSString *endDetail = [rs stringForColumn:@"endDetail"];
        NSString *total = [rs stringForColumn:@"total"];
        NSString *addtime = [rs stringForColumn:@"addtime"];
        
        [fetched addObject:@{@"id": @(restId), @"reason": reason, @"start": start, @"end": end, @"startDetail": startDetail, @"endDetail": endDetail, @"total": total, @"addtime": addtime}];
    }
    
    [rs close];
    [db close];
    
    return [fetched copy];
}
/**
 * 查询是否当天已经有加班记录了
 */
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
/**
 * 查询最新一次加班的时间
 */
- (NSString *)fetchLatestTimeOfOvertime {
    if (![db open]) {
        [self openDatabaseError];
        
        return @"没有记录";
    }
    
    // 为数据库设置缓存，提高查询效率
    [db setShouldCacheStatements:YES];
    
    NSString *result = @"没有记录";
    FMResultSet *rs = [db executeQuery:@"select time from MOTOvertime order by time desc limit 1"];
    while ([rs next]) {
        result = [rs stringForColumn:@"time"];
    }
    
    [rs close];
    [db close];
    
    return [result copy];
}
/**
 * 查询最新一次休息的时间
 */
- (NSString *)fetchLatestTimeOfRest {
    if (![db open]) {
        [self openDatabaseError];
        
        return @"\n没有记录\n";
    }
    
    // 为数据库设置缓存，提高查询效率
    [db setShouldCacheStatements:YES];
    
    NSString *result = @"\n没有记录\n";
    FMResultSet *rs = [db executeQuery:@"select * from MOTRest order by start desc limit 1"];
    while ([rs next]) {
        result = [NSString stringWithFormat:@"%@\n~\n%@", [rs stringForColumn:@"start"], [rs stringForColumn:@"end"]];
    }
    
    [rs close];
    [db close];
    
    return [result copy];
}

#pragma mark - 业务逻辑 - 插入
/**
 * 添加一次加班
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
    NSString *start = [time stringByAppendingString:@" 00:00:00.000"];
    NSString *end = [time stringByAppendingString:@" 23:59:59.999"];
    BOOL success = [db executeUpdate:@"INSERT INTO MOTOvertime (id, reason, time, start, end, type, addtime) values(?, ?, ?, ?, ?, ?, ?)", NULL, reason, time, start, end, @(type), addtime];
    
    [db close];
    
    if (!success) {
        NSString *errorMsg = [NSString stringWithFormat:@"数据表 MOTOvertime 添加数据失败: %d - %@", [db lastErrorCode], [db lastErrorMessage]];
        NSString *errorData = [NSString stringWithFormat:@"id: NULL, reason: %@, time: %@, type: %ld, addtime: %@", reason, time, type, addtime];
        [[ToastManager sharedManager] showError:errorMsg];
        [[LogManager sharedManager] logError:errorMsg data:errorData];
    }
    return success;
}
/**
 * 添加一次调休
 */
- (BOOL)insertRestWithReason:(NSString *)reason start:(NSString *)start end:(NSString *)end startDetail:(NSString *)startDetail endDetail:(NSString *)endDetail total:(float)total {
    if (![db open]) {
        [self openDatabaseError];
        
        return NO;
    }
    
    // 为数据库设置缓存，提高查询效率
    [db setShouldCacheStatements:YES];
    
    NSString *addtime = [[NSDate date] toNSString:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSString *totalString = [NSString stringWithFormat:@"%.1f", total];
    BOOL success = [db executeUpdate:@"INSERT INTO MOTRest (id, reason, start, end, startDetail, endDetail, total, addtime) values(?, ?, ?, ?, ?, ?, ?, ?)", NULL, reason, start, end, startDetail, endDetail, totalString, addtime];
    
    [db close];
    
    if (!success) {
        NSString *errorMsg = [NSString stringWithFormat:@"数据表 MOTRest 添加数据失败: %d - %@", [db lastErrorCode], [db lastErrorMessage]];
        NSString *errorData = [NSString stringWithFormat:@"id: NULL, reason: %@, start: %@, end: %@, startDetail: %@, endDetail: %@, total: %@, addtime: %@", reason, start, end, startDetail, endDetail, totalString, addtime];
        [[ToastManager sharedManager] showError:errorMsg];
        [[LogManager sharedManager] logError:errorMsg data:errorData];
    }
    return success;
}
/**
 * 更新 剩余天数
 */
- (BOOL)updateRestLeft:(float)day plus:(BOOL)plus {
    if (![db open]) {
        [self openDatabaseError];
        
        return NO;
    }
    
    // 为数据库设置缓存，提高查询效率
    [db setShouldCacheStatements:YES];
    
    float left = [_restLefts.firstObject.value floatValue];
    if (plus) {
        left += day;
    } else {
        left -= day;
    }
    
    if (left < 0.5) {
        left = 0.0;
    }
    
    NSString *update = [NSString stringWithFormat:@"update MOTSetting set value = '%.1f' where key = 'restLeft'", left];
    BOOL success = [db executeUpdate:update];
    
    [db close];
    
    if (!success) {
        NSString *errorMsg = [NSString stringWithFormat:@"数据表 MOTSetting 添加数据失败: %d - %@", [db lastErrorCode], [db lastErrorMessage]];
        NSString *errorData = [NSString stringWithFormat:@"value: %.1f", left];
        [[ToastManager sharedManager] showError:errorMsg];
        [[LogManager sharedManager] logError:errorMsg data:errorData];
    } else {
        [self fetchAllSettings];
    }
    
    return success;
}

@end
