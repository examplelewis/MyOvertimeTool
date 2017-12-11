//
//  BFLocalisationManager
//  OkayAppsFramework
//
//  Created by 熊玮 on 14/7/25.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>

// 便捷调用的国际化宏
#define bfi18n(key) [[BFLocalisationManager sharedInstance] localizedStringForKey:key]

/**
 @breif 统一的多语言管理器
 */
@interface BFLocalisationManager : NSObject

// 当前的语言
@property (nonatomic, copy) NSString * currentLanguage;
// 是否在UserDefaults里保存当前语言
@property (nonatomic, assign) BOOL saveInUserDefaults;

/**
 @brief 单例
 */
+ (BFLocalisationManager *)sharedInstance;

/**
 获取当前语言下对应key的值
 @param key 
 @param NSString
 */
- (NSString *)localizedStringForKey:(NSString*)key;

/**
 设置语言
 @param newLanguage
 */
- (BOOL)setLanguage:(NSString*)newLanguage;

/**
 判断是否支持一种语言
 @param theLanguage 要判断的语言
 */
- (BOOL)supportLanguage:(NSString *)theLanguage;

@end
