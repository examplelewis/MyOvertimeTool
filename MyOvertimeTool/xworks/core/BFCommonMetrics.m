//
//  BFCommonMetrics.m
//  OkayappsFrameworkDev
//
//  Created by xiongwei on 14/12/9.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import "BFCommonMetrics.h"

#import "BFDeviceUtilities.h"
#import "BFSDKAvailability.h"

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "OkayappsFramework requires ARC support."
#endif

CGFloat BFMinTapDimension(void) {
    return 44;
}

CGFloat BFToolbarHeightForOrientation(UIInterfaceOrientation orientation) {
    return (BFIsPad()
            ? 44
            : (UIInterfaceOrientationIsPortrait(orientation)
               ? 44
               : 33));
}

UIViewAnimationCurve BFStatusBarAnimationCurve(void) {
    return UIViewAnimationCurveEaseIn;
}

NSTimeInterval BFStatusBarAnimationDuration(void) {
    return 0.3;
}

UIViewAnimationCurve BFStatusBarBoundsChangeAnimationCurve(void) {
    return UIViewAnimationCurveEaseInOut;
}

NSTimeInterval BFStatusBarBoundsChangeAnimationDuration(void) {
    return 0.35;
}

CGFloat BFStatusBarHeight(void) {
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    
    // We take advantage of the fact that the status bar will always be wider than it is tall
    // in order to avoid having to check the status bar orientation.
    CGFloat statusBarHeight = MIN(statusBarFrame.size.width, statusBarFrame.size.height);
    
    return statusBarHeight;
}

/**
 * 获取屏幕大小
 */
CGRect BFScreenBounds(void) {
    CGRect bounds = BFFixedScreenBounds();
    if (UIInterfaceOrientationIsLandscape(BFInterfaceOrientation())) {
        CGFloat width = bounds.size.width;
        bounds.size.width = bounds.size.height;
        bounds.size.height = width;
    }
    return bounds;
}

CGRect BFFixedScreenBounds() {
    UIScreen *screen = [UIScreen mainScreen];
    
    if ([screen respondsToSelector:@selector(fixedCoordinateSpace)]) {
        return [screen.coordinateSpace convertRect:screen.bounds toCoordinateSpace:screen.fixedCoordinateSpace];
    }
    return screen.bounds;
}

/**
 * 获取屏幕高度
 */
CGFloat BFScreenHeight(void) {
    static CGFloat height = .0f;
    if (height ==.0f) {
        height = CGRectGetHeight(BFScreenBounds());
    }
    return height;
}

/**
 * 获取屏幕宽度
 */
CGFloat BFScreenWidth(void) {
    static CGFloat width = .0f;
    if (width ==.0f) {
        width = CGRectGetWidth(BFScreenBounds());
    }
    return width;
}

/**
 * 获取导航栏高度，固定返44.0f
 */
CGFloat BFNavigationBarHeight(void) {
    return 44.0f;
}

/**
 * 获取tabbar高度，固定返49.0f
 */
CGFloat BFTabBarHeight(void) {
    return 49.0f;
}

/**
 * 获取toolbar高度，固定返44.0f
 */
CGFloat BFToolbarHeight(void) {
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        // for iPad, the bar size does not change
        if (BFIsPad()) {
            return 44.0f;
        }
        return 32.0f;
    }
    else {
        return 44.0f;
    }
}

NSTimeInterval BFDeviceRotationDuration(BOOL isFlippingUpsideDown) {
    return isFlippingUpsideDown ? 0.8 : 0.4;
}

UIEdgeInsets BFCellContentPadding(void) {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
