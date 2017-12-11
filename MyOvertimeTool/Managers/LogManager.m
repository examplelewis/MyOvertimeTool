//
//  LogManager.m
//  MyOvertimeTool
//
//  Created by 龚宇 on 17/12/11.
//  Copyright © 2017年 gongyuTest. All rights reserved.
//

#import "LogManager.h"

@implementation LogManager

#pragma mark - 单例
static LogManager *_sharedManager;
+ (LogManager *)sharedManager {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedManager = [[LogManager alloc] init];
    });
    
    return _sharedManager;
}

- (void)logInfo:(NSString *)msg data:(NSString *)data {
    DDLogInfo(@"提示信息：%@", msg);
    if (data) {
        DDLogInfo(@"对应数据：%@", data);
    }
}
- (void)logWarning:(NSString *)msg data:(NSString *)data {
    DDLogWarn(@"警告信息：%@", msg);
    if (data) {
        DDLogWarn(@"对应数据：%@", data);
    }
}
- (void)logError:(NSString *)msg data:(NSString *)data {
    DDLogError(@"错误信息：%@", msg);
    if (data) {
        DDLogError(@"对应数据：%@", data);
    }
}

@end
