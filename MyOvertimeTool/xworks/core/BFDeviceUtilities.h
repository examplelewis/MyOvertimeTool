//
//  BFDeviceUtilities.h
//  OkayappsFrameworkDev
//
//  Created by xiongwei on 14/12/8.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define BF_DEVICE_HAS_RETINA_DISPLAY (fabs([UIScreen mainScreen].scale - 2.0) <= fabs([UIScreen mainScreen].scale - 2.0)*DBL_EPSILON)
#define BF_IS_SCREEN_HEIGHT_EQUAL(SCREEN_HEIGHT_VALUE) (MAX(BF_SCREEN_HEIGHT,BF_SCREEN_WIDTH)==SCREEN_HEIGHT_VALUE)

#define BF_IS_IPAD         (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
#define BF_IS_IPHONE       (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)

#define BF_IS_SIMULATOR    (BFHardware()==SIMULATOR)
#define BF_IS_IPHONE_5     (BF_IS_IPHONE && BF_IS_SCREEN_HEIGHT_EQUAL(568.0))
#define BF_IS_IPHONE_6     (BF_IS_IPHONE && (BFHardware()==IPHONE_6 || BF_IS_SCREEN_HEIGHT_EQUAL(667.0)))
#define IS_IPHONE_6_PLUS   (BF_IS_IPHONE && (BFHardware()==IPHONE_6_PLUS || BF_IS_SCREEN_HEIGHT_EQUAL(736.0)))

#define BF_GREATER_OSVERSON(x) ([BFOSVersion() floatValue] >= x)

#define BF_SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define BF_SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)

typedef NS_ENUM (NSUInteger, Hardware)
{
    NOT_AVAILABLE,
    
    IPHONE_2G,
    IPHONE_3G,
    IPHONE_3GS,
    IPHONE_4,
    IPHONE_4_CDMA,
    IPHONE_4S,
    IPHONE_5,
    IPHONE_5_CDMA_GSM,
    IPHONE_5C,
    IPHONE_5C_CDMA_GSM,
    IPHONE_5S,
    IPHONE_5S_CDMA_GSM,
    
    IPHONE_6_PLUS,
    IPHONE_6,
    
    IPOD_TOUCH_1G,
    IPOD_TOUCH_2G,
    IPOD_TOUCH_3G,
    IPOD_TOUCH_4G,
    IPOD_TOUCH_5G,
    
    IPAD,
    IPAD_2,
    IPAD_2_WIFI,
    IPAD_2_CDMA,
    IPAD_3,
    IPAD_3G,
    IPAD_3_WIFI,
    IPAD_3_WIFI_CDMA,
    IPAD_4,
    IPAD_4_WIFI,
    IPAD_4_GSM_CDMA,
    
    IPAD_MINI,
    IPAD_MINI_WIFI,
    IPAD_MINI_WIFI_CDMA,
    IPAD_MINI_RETINA_WIFI,
    IPAD_MINI_RETINA_WIFI_CDMA,
    IPAD_MINI_3_WIFI,
    IPAD_MINI_3_WIFI_CELLULAR,
    IPAD_MINI_RETINA_WIFI_CELLULAR_CN,
    
    IPAD_AIR_WIFI,
    IPAD_AIR_WIFI_GSM,
    IPAD_AIR_WIFI_CDMA,
    IPAD_AIR_2_WIFI,
    IPAD_AIR_2_WIFI_CELLULAR,
    
    SIMULATOR
};

#if defined __cplusplus
extern "C" {
#endif
    
/**
 * Returns the application's current interface orientation.
 *
 * This is simply a convenience method for [UIApplication sharedApplication].statusBarOrientation.
 *
 *      @returns The current interface orientation.
 */
UIInterfaceOrientation BFInterfaceOrientation(void);
    
/**
 * Returns YES if the device is a phone and the orientation is landscape.
 *
 * This is a useful check for phone landscape mode which often requires
 * additional logic to handle the smaller vertical real estate.
 *
 *      @returns YES if the device is a phone and orientation is landscape.
 */
BOOL BFIsLandscapePhoneOrientation(UIInterfaceOrientation orientation);

/**
 * Creates an affine transform for the given device orientation.
 *
 * This is useful for creating a transformation matrix for a view that has been added
 * directly to the window and doesn't automatically have its transformation modified.
 */
CGAffineTransform BFRotateTransformForOrientation(UIInterfaceOrientation orientation);

/**
 *  获取设备类型
 *
 *  @return Hardware
 */
Hardware BFHardware();
    
/**
 *  获取设备描述
 *
 *  @return e.g. iPad Air 2 (Wi-Fi + Cellular)
 */
NSString* BFHardwareDescription();
    
/**
 *  获取设备简略描述
 *
 *  @return e.g. iPad Air 2
 */
NSString* BFHardwareSimpleDescription();
    
/**
 *  获取OS版本
 *
 *  @return e.g. 8.1
 */
NSString* BFOSVersion();
    
/**
 *  设备是否越狱
 *
 *  @return YES/NO
 */
BOOL BFIsJailbroken();
    
#if defined __cplusplus
};
#endif
