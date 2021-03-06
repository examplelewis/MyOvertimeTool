//
//  AppDelegate.m
//  MyOvertimeTool
//
//  Created by 龚宇 on 17/12/11.
//  Copyright © 2017年 gongyuTest. All rights reserved.
//

#import "AppDelegate.h"
#import "BFAppearance.h"
#import "BFPaths.h"
#import <IQKeyboardManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //在系统上保持一周的日志文件
    NSString *logDirectory = BFPathForDocumentsResource(@"Logs");
    DDLogFileManagerDefault *logFileManager = [[DDLogFileManagerDefault alloc] initWithLogsDirectory:logDirectory];
    DDFileLogger *fileLogger = [[DDFileLogger alloc] initWithLogFileManager:logFileManager];
    fileLogger.rollingFrequency = 60 * 60 * 24 * 7; // 1 week rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 1;
    fileLogger.maximumFileSize = 10 * 1024 * 1024;
    [DDLog addLogger:fileLogger];
    
    // 导航栏样式
    BFAppearance *appearance = [BFAppearance sharedAppearance];
    
    appearance.navigationBarBackgroundColor = [UIColor colorWithHexString:@"#44A2F9"];
    appearance.navigationBarTintColor = [UIColor whiteColor];
    appearance.backgroundColor = BFCOLOR_GREY_1000_WHITE;
    appearance.navigationBarTitleSize = 18.0f;
    appearance.navigationBarTitleColor = [UIColor whiteColor];
    [appearance updateAppearance];
    // 状态栏样式
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    // 自动隐藏键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    // SVProgressHUD
    [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"#44A2F9"]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setMinimumDismissTimeInterval:3.0];
    
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
