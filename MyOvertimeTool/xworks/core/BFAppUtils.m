//
//  BFAppUtils.m
//  OkayappsFrameworkDev
//
//  Created by lcy on 14/12/12.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import "BFAppUtils.h"

NSString* BFGetAppVersion() {
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return appVersion;
}

NSString* BFGetAppBuild() {
    NSString *appBuild = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    return appBuild;
}

