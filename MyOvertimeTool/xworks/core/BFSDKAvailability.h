//
//  BFSDKAvailability.h
//  OkayappsFrameworkDev
//
//  Created by xiongwei on 14/12/8.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * For checking SDK feature availibility.
 *
 * @ingroup NimbusCore
 * @defgroup SDK-Availability SDK Availability
 * @{
 *
 * BFIOS macros are defined in parallel to their __IPHONE_ counterparts as a consistently-defined
 * means of checking __IPHONE_OS_VERSION_MAX_ALLOWED.
 *
 * For example:
 *
 * @htmlonly
 * <pre>
 *     #if __IPHONE_OS_VERSION_MAX_ALLOWED >= BFIOS_3_2
 *       // This code will only compile on versions >= iOS 3.2
 *     #endif
 * </pre>
 * @endhtmlonly
 */

/**
 * Released on July 11, 2008
 */
#define BFIOS_2_0     20000

/**
 * Released on September 9, 2008
 */
#define BFIOS_2_1     20100

/**
 * Released on November 21, 2008
 */
#define BFIOS_2_2     20200

/**
 * Released on June 17, 2009
 */
#define BFIOS_3_0     30000

/**
 * Released on September 9, 2009
 */
#define BFIOS_3_1     30100

/**
 * Released on April 3, 2010
 */
#define BFIOS_3_2     30200

/**
 * Released on June 21, 2010
 */
#define BFIOS_4_0     40000

/**
 * Released on September 8, 2010
 */
#define BFIOS_4_1     40100

/**
 * Released on November 22, 2010
 */
#define BFIOS_4_2     40200

/**
 * Released on March 9, 2011
 */
#define BFIOS_4_3     40300

/**
 * Released on October 12, 2011.
 */
#define BFIOS_5_0     50000

/**
 * Released on March 7, 2012.
 */
#define BFIOS_5_1     50100

/**
 * Released on September 19, 2012.
 */
#define BFIOS_6_0     60000

/**
 * Released on January 28, 2013.
 */
#define BFIOS_6_1     60100

/**
 * Released on September 18, 2013
 */
#define BFIOS_7_0     70000

/**
 *
 */
#define BFIOS_8_0     80000

/**
 *
 */
#define BFIOS_8_1     80100

#ifndef kCFCoreFoundationVersionNumber_iPhoneOS_2_0
#define kCFCoreFoundationVersionNumber_iPhoneOS_2_0 478.23
#endif

#ifndef kCFCoreFoundationVersionNumber_iPhoneOS_2_1
#define kCFCoreFoundationVersionNumber_iPhoneOS_2_1 478.26
#endif

#ifndef kCFCoreFoundationVersionNumber_iPhoneOS_2_2
#define kCFCoreFoundationVersionNumber_iPhoneOS_2_2 478.29
#endif

#ifndef kCFCoreFoundationVersionNumber_iPhoneOS_3_0
#define kCFCoreFoundationVersionNumber_iPhoneOS_3_0 478.47
#endif

#ifndef kCFCoreFoundationVersionNumber_iPhoneOS_3_1
#define kCFCoreFoundationVersionNumber_iPhoneOS_3_1 478.52
#endif

#ifndef kCFCoreFoundationVersionNumber_iPhoneOS_3_2
#define kCFCoreFoundationVersionNumber_iPhoneOS_3_2 478.61
#endif

#ifndef kCFCoreFoundationVersionNumber_iOS_4_0
#define kCFCoreFoundationVersionNumber_iOS_4_0 550.32
#endif

#ifndef kCFCoreFoundationVersionNumber_iOS_4_1
#define kCFCoreFoundationVersionNumber_iOS_4_1 550.38
#endif

#ifndef kCFCoreFoundationVersionNumber_iOS_4_2
#define kCFCoreFoundationVersionNumber_iOS_4_2 550.52
#endif

#ifndef kCFCoreFoundationVersionNumber_iOS_4_3
#define kCFCoreFoundationVersionNumber_iOS_4_3 550.52
#endif

#ifndef kCFCoreFoundationVersionNumber_iOS_5_0
#define kCFCoreFoundationVersionNumber_iOS_5_0 675.00
#endif

#ifndef kCFCoreFoundationVersionNumber_iOS_5_1
#define kCFCoreFoundationVersionNumber_iOS_5_1 690.10
#endif

#ifndef kCFCoreFoundationVersionNumber_iOS_6_0
#define kCFCoreFoundationVersionNumber_iOS_6_0 793.00
#endif

#ifndef kCFCoreFoundationVersionNumber_iOS_6_1
#define kCFCoreFoundationVersionNumber_iOS_6_1 793.00
#endif

#ifndef kCFCoreFoundationVersionNumber_iOS_7_0
#define kCFCoreFoundationVersionNumber_iOS_7_0 847.20
#endif

#ifndef kCFCoreFoundationVersionNumber_iOS_7_1
#define kCFCoreFoundationVersionNumber_iOS_7_1 847.24
#endif

#if defined(__cplusplus)
extern "C" {
#endif
    
/**
 * Checks whether the device the app is currently running on is an iPad or not.
 *
 * @returns YES if the device is an iPad.
 */
BOOL BFIsPad(void);

/**
 * Checks whether the device the app is currently running on is an
 * iPhone/iPod touch or not.
 *
 * @returns YES if the device is an iPhone or iPod touch.
 */
BOOL BFIsPhone(void);

/**
 * Checks whether the device supports tint colors on all UIViews.
 *
 * @returns YES if all UIView instances on the device respond to tintColor.
 */
BOOL BFIsTintColorGloballySupported(void);

/**
 * Checks whether the device's OS version is at least the given version number.
 *
 * Useful for runtime checks of the device's version number.
 *
 * @param versionNumber  Any value of kCFCoreFoundationVersionNumber.
 *
 * @attention Apple recommends using respondsToSelector where possible to check for
 *                 feature support. Use this method as a last resort.
 */
BOOL BFDeviceOSVersionIsAtLeast(double versionNumber);

/**
 * Fetch the screen's scale.
 */
CGFloat BFScreenScale(void);

/**
 * Returns YES if the screen is a retina display, NO otherwise.
 */
BOOL BFIsRetina(void);
    
#if defined(__cplusplus)
} // extern "C"
#endif

#pragma mark Building with Old SDKs

// Define methods that were introduced in iOS 7.0.
#if __IPHONE_OS_VERSION_MAX_ALLOWED < BFIOS_7_0

@interface UIViewController (OkayappsFramework7SDKAvailability)

@property (nonatomic, assign) UIRectEdge edgesForExtendedLayout;
- (void)setNeedsStatusBarAppearanceUpdate;

@end

#endif


/**@}*/// End of SDK Availability /////////////////////////////////////////////////////////////////