/*!
 @header BFViewUtils
 @abstract OkayappsFrameworkDev
 @author xiongwei
 @version 1.0 14/12/11 Copyright (c) 2015年 okayapps.com. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*!
 @class
 @abstract 关于UIView曾测结构相关的扩展
 */
@interface UIView (BFHierarchy)

/*!
 @method
 @abstract 在日志中打印出View的结构层次
 @param view 要打印结构层次的view
 @return 无
 */
+ (void)detactView:(UIView *)view;

/*!
 @property viewController
 @abstract 返回view关联的UIViewController
 */
@property (nonatomic, readonly, strong) UIViewController *viewController;

/*!
 @property superScrollView
 @abstract 返回view上层的UIScrollView
 */
@property (nonatomic, readonly, strong) UIScrollView *superScrollView;

/*!
 @property superTableView
 @abstract 返回view上层的UITableView
 */
@property (nonatomic, readonly, strong) UITableView *superTableView;

/*!
 @property
 @abstract 返回view上层的UITableViewCell
 */
@property (nonatomic, readonly, strong) UITableViewCell *superTableViewCell;

/*!
 @property
 @abstract 判断是否是搜索框的TextField
 */
@property (nonatomic, getter=isSearchBarTextField, readonly) BOOL searchBarTextField;

/*!
 @property isAlertViewTextField
 @abstract 判断是否是UIAlertSheetTextField
 */
@property (nonatomic, getter=isAlertViewTextField, readonly) BOOL alertViewTextField;

@end

@interface UIView (BFRoundCornor)

- (void)roundCornorWithRadius:(CGFloat)radius borderColor:(UIColor *)color borderWidth:(CGFloat)borderWith;

@end

@interface UIView (BFAccess)

// Frame
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

// Frame Origin
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;

// Frame Size
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

// Frame Borders
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat right;

// Center Point
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

// Middle Point
@property (nonatomic, readonly) CGPoint middlePoint;
@property (nonatomic, readonly) CGFloat middleX;
@property (nonatomic, readonly) CGFloat middleY;

@end

@interface UIScrollView (BFAccess)

// Content Offset
@property (nonatomic) CGFloat contentOffsetX;
@property (nonatomic) CGFloat contentOffsetY;

// Content Size
@property (nonatomic) CGFloat contentSizeWidth;
@property (nonatomic) CGFloat contentSizeHeight;

// Content Inset
@property (nonatomic) CGFloat contentInsetTop;
@property (nonatomic) CGFloat contentInsetLeft;
@property (nonatomic) CGFloat contentInsetBottom;
@property (nonatomic) CGFloat contentInsetRight;

@end