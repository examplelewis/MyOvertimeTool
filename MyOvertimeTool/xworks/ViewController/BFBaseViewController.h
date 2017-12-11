//
//  BFBaseViewController.h
//  OkayappsFrameworkDev
//
//  Created by lcy on 14/12/17.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFBaseViewController : UIViewController

/**
 *  在导航栏左侧添加文字按钮
 *
 *  @param title    文字内容
 *  @param color    文字颜色
 *  @param fontSize 字体大小
 *  @param frame    按钮frame
 *  @param action   点击事件
 */
- (void)addLeftBarButtonItemWithTitle:(NSString*)title textColor:(UIColor*)color fontSize:(CGFloat)fontSize frame:(CGRect)frame action:(SEL)action;
/**
 *  在导航栏左侧添加图片按钮
 *
 *  @param imageName 图片名称
 *  @param frame     按钮frame
 *  @param action    点击事件
 */
- (void)addLeftBarButtonItemWithImage:(NSString*)imageName frame:(CGRect)frame action:(SEL)action;

/**
 *  在导航栏右侧添加文字按钮
 *
 *  @param title    文字内容
 *  @param color    文字颜色
 *  @param fontSize 字体大小
 *  @param frame    按钮frame
 *  @param action   点击事件
 */
- (void)addRightBarButtonItemWithTitle:(NSString*)title textColor:(UIColor*)color fontSize:(CGFloat)fontSize frame:(CGRect)frame action:(SEL)action;

/**
 *  在导航栏右侧添加图片按钮
 *
 *  @param imageName 图片名称
 *  @param frame     按钮frame
 *  @param action    点击事件
 */
- (void)addRightBarButtonItemWithImage:(NSString*)imageName frame:(CGRect)frame action:(SEL)action;

@end
