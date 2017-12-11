//
//  BFAppearance.h
//  OkayappsFrameworkDev
//
//  Created by xiongwei on 15/2/6.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  @author xiongwei
 *
 *  @brief  页面背景色改变时的通知名称
 */
extern NSString * const BFAppearanceBackgroundChanged;


/*!
 *  @class
 *  @author xiongwei
 *
 *  @brief  框架UI的管理器
 */
@interface BFAppearance : NSObject

/**
 * @brief 背景色，全局通用，应用于页面背景
 */
@property (strong, nonatomic) UIColor *backgroundColor;

/**
 * @brief 背景图片，全局通用，应用于页面背景
 */
@property (strong, nonatomic) UIImage *backgroundImage;

/**
 * @brief 导航栏背景色，与navigationBarBackgroundImage二者仅有一个生效，如果都提供，则使用navigationBarBackgroundColor
 */
@property (strong, nonatomic) UIColor *navigationBarBackgroundColor;

/**
 * @brief 导航栏背景图片，与navigationBarBackgroundColor二者仅有一个生效，如果都提供，则使用navigationBarBackgroundColor
 */
@property (strong, nonatomic) UIImage *navigationBarBackgroundImage;

/**
 * @brief 导航栏是否半透明，仅在iOS8以上有效，iOS8以下系统，请直接设置UINavigationBar
 */
@property (assign, nonatomic) BOOL navigationBarTranslucent;

/**
 * @brief 导航栏item的着重色
 */
@property (strong, nonatomic) UIColor *navigationBarTintColor;

/**
 * @brief 导航栏标题颜色
 */
@property (strong, nonatomic) UIColor *navigationBarTitleColor;

/**
 * @brief 导航栏标题字体大小
 */
@property (assign, nonatomic) CGFloat navigationBarTitleSize;

/**
 * @brief 导航栏标题阴影
 */
@property (strong, nonatomic) NSShadow *navigationBarTitleShadow;


/*!
 *  @author xiongwei
 *
 *  @brief  获取管理器，全局唯一
 *
 *  @return
 */
+ (id)sharedAppearance;

/*!
 *  @author xiongwei
 *
 *  @brief  更新UI
 */
- (void)updateAppearance;


@end
