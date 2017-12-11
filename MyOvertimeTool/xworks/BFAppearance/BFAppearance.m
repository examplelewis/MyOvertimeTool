//
//  BFAppearance.m
//  OkayappsFrameworkDev
//
//  Created by xiongwei on 15/2/6.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import "BFAppearance.h"
#import "XworksUtils.h"

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "OkayappsFramework requires ARC support."
#endif

NSString* const BFAppearanceBackgroundChanged = @"com.bbdtekframework.appearance.BackgroundChanged";

@implementation BFAppearance

@synthesize backgroundColor;
@synthesize backgroundImage;
@synthesize navigationBarBackgroundColor;
@synthesize navigationBarBackgroundImage;
@synthesize navigationBarTranslucent;
@synthesize navigationBarTintColor;
@synthesize navigationBarTitleColor;
@synthesize navigationBarTitleSize;
@synthesize navigationBarTitleShadow;

+ (void)load
{
    [[BFAppearance sharedAppearance] updateAppearance];
}

+ (id)sharedAppearance
{
    static BFAppearance *_sharedAppearance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedAppearance = [[self alloc] init];
    });
    return _sharedAppearance;
}

- (id)init
{
    self = [super init];
    if (self) {
        // 设置默认值
        backgroundColor = [UIColor colorWithHexString:@"efefef"];
        navigationBarBackgroundColor = BFCOLOR_INDIGO_500;
        navigationBarTranslucent = NO;
        navigationBarTintColor = BFCOLOR_BODY_TEXT_1_INVERSE;
        navigationBarTitleSize = 18.0f;
        navigationBarTitleColor = [UIColor whiteColor];
        
    }
    return self;
}

/**
 * 更新UI
 */
- (void)updateAppearance
{
    [self updateNavigationBarAppearance];
    [self updateNavigationBarTitleTextAttributes];
}

/**
 * 更新UI
 */
- (void)updateNavigationBarAppearance
{
    id appearance = [UINavigationBar appearance];
    if (navigationBarBackgroundColor) {
        if ([appearance respondsToSelector:@selector(setBarTintColor:)]) {
            [appearance setBarTintColor:navigationBarBackgroundColor];
        } else {
            [appearance setBackgroundImage:BFImageWithColor(navigationBarBackgroundColor) forBarMetrics:UIBarMetricsDefault];
        }
    } else if (navigationBarBackgroundImage) {
        if ([appearance respondsToSelector:@selector(setBackButtonBackgroundImage:forState:barMetrics:)]) {
            [appearance setBackgroundImage:navigationBarBackgroundImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        } else {
            [appearance setBackgroundImage:navigationBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
        }
    }
    [appearance setTintColor:navigationBarTintColor];
    [appearance setShadowImage:[[UIImage alloc] init]];
    if (BF_GREATER_OSVERSON(8.0)) {
        [appearance setTranslucent:navigationBarTranslucent];
    }
}

/**
 * 更新导航栏标题文本属性
 */
- (void)updateNavigationBarTitleTextAttributes
{
    if (navigationBarTitleShadow == nil) {
        navigationBarTitleShadow = [[NSShadow alloc] init];
        navigationBarTitleShadow.shadowOffset = CGSizeMake(0, 1);
        navigationBarTitleShadow.shadowColor = [UIColor lightGrayColor];
    }
    
    NSDictionary *titleAttrs = @{};
    if (navigationBarTitleShadow == nil) {
        titleAttrs = [NSDictionary dictionaryWithObjectsAndKeys:navigationBarTitleColor, NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:navigationBarTitleSize], NSFontAttributeName, nil];
    } else {
        titleAttrs = [NSDictionary dictionaryWithObjectsAndKeys:navigationBarTitleColor, NSForegroundColorAttributeName, navigationBarTitleShadow, NSShadowAttributeName, [UIFont boldSystemFontOfSize:navigationBarTitleSize], NSFontAttributeName, nil];
    }
    [[UINavigationBar appearance] setTitleTextAttributes:titleAttrs];
}


/***Getter & Setter begin***/

- (void)setBackgroundColor:(UIColor *)theBackgroundColor
{
    backgroundColor = theBackgroundColor;
    backgroundImage = nil;
    [self fireBackgroundChangeNotification];
}

- (void)setBackgroundImage:(UIImage *)theBackgroundImage
{
    backgroundColor = nil;
    backgroundImage = theBackgroundImage;
    [self fireBackgroundChangeNotification];
}

- (void)setNavigationBarBackgroundColor:(UIColor *)theNavigationBarBackgroundColor
{
    navigationBarBackgroundColor = theNavigationBarBackgroundColor;
    // 根据颜色深浅来判断是用浅色还是深色的状态栏
    if ([navigationBarBackgroundColor isLight]) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    } else {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
}

- (void)setNavigationBarTranslucent:(BOOL)theNavigationBarTranslucent
{
    navigationBarTranslucent = theNavigationBarTranslucent;
    if (BF_GREATER_OSVERSON(8.0)) {
        [[UINavigationBar appearance] setTranslucent:navigationBarTranslucent];
    }
}

/***Getter & Setter end***/

/**
 * 发出背景改变的通知
 */
- (void)fireBackgroundChangeNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:BFAppearanceBackgroundChanged object:self];
}

@end
