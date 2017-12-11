//
//  LogManager.h
//  MyOvertimeTool
//
//  Created by 龚宇 on 17/12/11.
//  Copyright © 2017年 gongyuTest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogManager : NSObject

+ (LogManager *)sharedManager;

- (void)logInfo:(NSString *)msg data:(NSString *)data;
- (void)logWarning:(NSString *)msg data:(NSString *)data;
- (void)logError:(NSString *)msg data:(NSString *)data;

@end
