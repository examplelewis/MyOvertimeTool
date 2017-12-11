//
//  ToastManager.h
//  MyOvertimeTool
//
//  Created by 龚宇 on 17/12/11.
//  Copyright © 2017年 gongyuTest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToastManager : NSObject

+ (ToastManager *)sharedManager;
- (BOOL)isLoadingShown;
- (void)showLoading:(NSString *)msg;
- (void)showError:(NSString *)msg;
- (void)showSuccess:(NSString *)msg;
- (void)showInfo:(NSString *)msg;
- (void)dismissLoading;

@end
