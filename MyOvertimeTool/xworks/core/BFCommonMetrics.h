//
//  BFCommonMetrics.h
//  OkayappsFrameworkDev
//
//  Created by xiongwei on 14/12/9.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#if defined __cplusplus
extern "C" {
#endif

#ifndef UIViewAutoresizingFlexibleMargins
#define UIViewAutoresizingFlexibleMargins (UIViewAutoresizingFlexibleLeftMargin \
| UIViewAutoresizingFlexibleTopMargin \
| UIViewAutoresizingFlexibleRightMargin \
| UIViewAutoresizingFlexibleBottomMargin)
#endif

#ifndef UIViewAutoresizingFlexibleDimensions
#define UIViewAutoresizingFlexibleDimensions (UIViewAutoresizingFlexibleWidth \
| UIViewAutoresizingFlexibleHeight)
#endif

#ifndef UIViewAutoresizingNavigationBar
#define UIViewAutoresizingNavigationBar (UIViewAutoresizingFlexibleWidth \
| UIViewAutoresizingFlexibleBottomMargin)
#endif

#ifndef UIViewAutoresizingToolbar
#define UIViewAutoresizingToolbar (UIViewAutoresizingFlexibleWidth \
| UIViewAutoresizingFlexibleTopMargin)
#endif

/**
 * 可点击区域的推荐最小高度
 * Value: 44
 */
CGFloat BFMinTapDimension(void);

/**
 * 根据设备方向获取UIToolbar的高度
 * iPhone:
 * - 竖屏: 44
 * - 横屏: 33
 *
 * iPad: 44
 */
CGFloat BFToolbarHeightForOrientation(UIInterfaceOrientation orientation);

/**
 * 状态栏动画曲线
 * <code>-[[UIApplication sharedApplication] setStatusBarHidden:withAnimation:].</code>
 *
 * Value: UIViewAnimationCurveEaseIn
 */
UIViewAnimationCurve BFStatusBarAnimationCurve(void);

/**
 * 状态栏动画的时间.3s
 * <code>-[[UIApplication sharedApplication] setStatusBarHidden:withAnimation:].</code>
 *
 * Value: 0.3 seconds
 */
NSTimeInterval BFStatusBarAnimationDuration(void);

/**
 * 用于状态栏Bounds的动画曲线
 * Value: UIViewAnimationCurveEaseInOut
 */
UIViewAnimationCurve BFStatusBarBoundsChangeAnimationCurve(void);

/**
 * 状态栏Bounds动画的时间.35s
 *
 * Value: 0.35 seconds
 */
NSTimeInterval BFStatusBarBoundsChangeAnimationDuration(void);

/**
 * 获取状态栏高度，通常为20，如果状态栏隐藏则为0
 */
CGFloat BFStatusBarHeight(void);
    
/**
 * 获取屏幕大小
 */
CGRect BFScreenBounds(void);
    
/**
 * 获取固定的大小，iOS8通过fixedCoordinateSpace来判断
 */
CGRect BFFixedScreenBounds(void);
    
/**
 * 获取屏幕高度
 */
CGFloat BFScreenHeight(void);

/**
 * 获取屏幕宽度
 */
CGFloat BFScreenWidth(void);

/**
 * 获取导航栏高度，固定返44.0f
 */
CGFloat BFNavigationBarHeight(void);

/**
 * 获取tabbar高度，固定返49.0f
 */
CGFloat BFTabBarHeight(void);

/**
 * 获取toolbar高度，固定返44.0f
 */
CGFloat BFToolbarHeight(void);
    

/**
 * 设备旋转方向时的动画时间
 *
 * Value: 旋转90°时为0.4s
 *        旋转180°时为0.8s
 *
 * @param isFlippingUpsideDown YES if the device is being flipped upside down.
 */
NSTimeInterval BFDeviceRotationDuration(BOOL isFlippingUpsideDown);

/**
 * UITableView的cell的内容边距
 *
 * 上下左右均为10
 */
UIEdgeInsets BFCellContentPadding(void);
    
#if defined __cplusplus
};
#endif

/**@}*/// End of Common Metrics ///////////////////////////////////////////////////////////////////