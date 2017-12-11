//
//  BFSDKAvailability.m
//  OkayappsFrameworkDev
//
//  Created by xiongwei on 14/12/8.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import "BFSDKAvailability.h"

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "OkayappsFramework requires ARC support."
#endif

#if __IPHONE_OS_VERSION_MAX_ALLOWED < BFIOS_6_0
const UIImageResizingMode UIImageResizingModeStretch = -1;
#endif

BOOL BFIsPad(void) {
    static NSInteger isPad = -1;
    if (isPad < 0) {
        isPad = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) ? 1 : 0;
    }
    return isPad > 0;
}

BOOL BFIsPhone(void) {
    static NSInteger isPhone = -1;
    if (isPhone < 0) {
        isPhone = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) ? 1 : 0;
    }
    return isPhone > 0;
}

BOOL BFIsTintColorGloballySupported(void) {
    static NSInteger isTintColorGloballySupported = -1;
    if (isTintColorGloballySupported < 0) {
        UIView* view = [[UIView alloc] init];
        isTintColorGloballySupported = [view respondsToSelector:@selector(tintColor)];
    }
    return isTintColorGloballySupported > 0;
}

BOOL BFDeviceOSVersionIsAtLeast(double versionNumber) {
    return kCFCoreFoundationVersionNumber >= versionNumber;
}

CGFloat BFScreenScale(void) {
    return [[UIScreen mainScreen] scale];
}

BOOL BFIsRetina(void) {
    return BFScreenScale() > 1.f;
}