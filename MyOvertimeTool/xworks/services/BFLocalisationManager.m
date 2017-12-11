//
//  BFLocalisationManager.m
//  OkayAppsFramework
//
//  Created by 熊玮 on 14/7/25.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import "BFLocalisationManager.h"

static NSString * const kSaveDefaultLanguageKey = @"kSaveDefaultLanguageKey";
// 切换语言的通知事件名称
static NSString * const kNotificationLanguageChanged = @"kNotificationLanguageChanged";
// 默认的语言
static NSString * const kDefaultLanguage = @"Default";

@interface BFLocalisationManager()

@property NSDictionary *dicLocalisation;
@property NSUserDefaults *defaults;

@end

@implementation BFLocalisationManager

// 单例
+ (BFLocalisationManager *)sharedInstance
{
    static BFLocalisationManager *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[BFLocalisationManager alloc] init];
    });
    
    return _sharedInstance;
}


- (id)init
{
    self = [super init];
    if (self)
    {
        _defaults = [NSUserDefaults standardUserDefaults];
        _dicLocalisation = nil;
        _currentLanguage = kDefaultLanguage;
        
        NSString * languageSaved = [_defaults objectForKey:kSaveDefaultLanguageKey];
        
        if (languageSaved != nil && ![languageSaved isEqualToString:kDefaultLanguage])
        {
            [self loadDictionaryForLanguage:languageSaved];
        }
    }
    return self;
}

#pragma mark - Private  Instance methods

-(BOOL)loadDictionaryForLanguage:(NSString *)newLanguage
{
    NSURL * urlPath = [[NSBundle bundleForClass:[self class]] URLForResource:@"Localizable" withExtension:@"strings" subdirectory:nil localization:newLanguage];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:urlPath.path])
    {
        self.currentLanguage = [newLanguage copy];
        self.dicLocalisation = [[NSDictionary dictionaryWithContentsOfFile:urlPath.path] copy];
        
        return YES;
    }
    return NO;
}

#pragma mark - saveInIUserDefaults custom accesser/setter

-(BOOL)saveInUserDefaults
{
    return ([self.defaults objectForKey:kSaveDefaultLanguageKey] != nil);
}

-(void)setSaveInUserDefaults:(BOOL)saveInUserDefaults
{
    if (saveInUserDefaults)
    {
        [self.defaults setObject:_currentLanguage forKey:kSaveDefaultLanguageKey];
    } else {
        [self.defaults removeObjectForKey:kSaveDefaultLanguageKey];
    }
    [self.defaults synchronize];
}

#pragma mark - Public  Instance methods
/**
 获取当前语言下对应key的值
 @param key
 @param NSString
 */
- (NSString *)localizedStringForKey:(NSString*)key
{
    if (self.dicLocalisation == nil)
    {
        return NSLocalizedString(key, key);
    } else {
        NSString * localizedString = self.dicLocalisation[key];
        if (localizedString == nil) {
            localizedString = key;
        }
        return localizedString;
    }
}

/**
 设置语言
 @param newLanguage
 */
- (BOOL)setLanguage:(NSString*)newLanguage
{
    if (newLanguage == nil || [newLanguage isEqualToString:self.currentLanguage] || ![self supportLanguage:newLanguage])
        return NO;
    
    if ([newLanguage isEqualToString:kDefaultLanguage])
    {
        self.currentLanguage = [newLanguage copy];
        self.dicLocalisation = nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLanguageChanged
                                                            object:nil];
        return YES;
    } else {
        BOOL isLoadingOk = [self loadDictionaryForLanguage:newLanguage];
        
        if (isLoadingOk) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLanguageChanged
                                                                object:nil];
            if ([self saveInUserDefaults])
            {
                [self.defaults setObject:_currentLanguage forKey:kSaveDefaultLanguageKey];
                [self.defaults synchronize];
            }
        }
        return isLoadingOk;
    }
}

/**
 判断是否支持一种语言
 @param theLanguage 要判断的语言
 */
- (BOOL)supportLanguage:(NSString *)theLanguage
{
    NSURL * urlPath = [[NSBundle bundleForClass:[self class]] URLForResource:@"Localizable" withExtension:@"strings" subdirectory:nil localization:theLanguage];
    return [[NSFileManager defaultManager] fileExistsAtPath:urlPath.path];
}

@end
