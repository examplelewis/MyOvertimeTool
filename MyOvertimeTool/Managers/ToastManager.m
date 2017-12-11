//
//  ToastManager.m
//  MyOvertimeTool
//
//  Created by 龚宇 on 17/12/11.
//  Copyright © 2017年 gongyuTest. All rights reserved.
//

#import "ToastManager.h"
#import "SVProgressHUD.h"

@implementation ToastManager

#pragma mark - 单例
static ToastManager *_sharedManager;
+ (ToastManager *)sharedManager {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedManager = [[ToastManager alloc] init];
    });
    
    return _sharedManager;
}

#pragma mark - Toast
- (void)showLoading:(NSString *)status {
    [SVProgressHUD showWithStatus:status];
}
- (BOOL)isLoadingShown {
    return [SVProgressHUD isVisible];
}
- (void)dismissLoading {
    [SVProgressHUD dismiss];
}
- (void)showError:(NSString *)msg {
    [SVProgressHUD showErrorWithStatus:msg];
}
- (void)showSuccess:(NSString *)msg {
    [SVProgressHUD showSuccessWithStatus:msg];
}
- (void)showInfo:(NSString *)msg {
    [SVProgressHUD showInfoWithStatus:msg];
}

@end
