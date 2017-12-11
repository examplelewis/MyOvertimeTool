//
//  BFNavigationController.h
//  OkayappsFrameworkDev
//
//  Created by lcy on 14/12/17.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFNavigationController : UINavigationController

/**
 *  自定义push，解决定义leftBarButtonItems后的滑动返回问题
 *
 *  @param viewController viewController
 *  @param animated       animated
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

/**
 *  设置导航栏背景图片
 *
 *  @param name 图片名
 */
- (void)setNavigationBarBackgroundImage:(NSString *)name;

/**
 *  设置导航栏背景颜色
 *
 *  @param color 颜色值
 */
- (void)setNavigationBarBackgroundColor:(UIColor *)color;

@end
