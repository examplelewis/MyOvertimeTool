//
//  BFCacheManager.m
//  OkayAppsFramework
//
//  Created by 熊玮 on 14/7/22.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import "BFCacheManager.h"

#import "BFCache.h"
#import "BFKeyChainStore.h"

#define keyCacheValueDate   @"bf_keyCacheValueDate"
#define keyCacheValue   @"bf_keyCacheValue"
#define keyCacheValueExpire   @"bf_keyCacheValueExpire"

@interface BFCacheManager ()

/**
 * @brief 缓存的具体实现类TMCache，在属性中保留以供特殊情况使用，一般情况下尽量不要使用此属性
 */
@property (readonly, nonatomic) BFCache *tmCache;

/**
 * @brief keychain的缓存，敏感信息如用户密码，用户信息等数据使用此缓存，同样尽量不要使用此属性
 */
@property (readonly, nonatomic) BFKeyChainStore *keyChainStore;

@end

/**
 * 统一的数据缓存接口
 */
@implementation BFCacheManager

@synthesize tmCache;
@synthesize keyChainStore;

+ (BFCacheManager *)sharedCacheManager
{
    static BFCacheManager *cache;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        cache = [[self alloc] init];
    });
    
    return cache;
}


- (BFCache *)tmCache
{
    if (tmCache == nil) {
        tmCache = [BFCache sharedCache];
    }
    return tmCache;
}

- (BFKeyChainStore *)keyChainStore
{
    if (keyChainStore == nil) {
        keyChainStore = [BFKeyChainStore keyChainStore];
    }
    return keyChainStore;
}

#pragma -
#pragma mark - uses of UICKeyChainStore
/**
 *  在keychain中缓存
 */
- (void)cacheInKeyChain:(NSString *)str forKey:(NSString *)key
{
    [BFKeyChainStore setString:str forKey:key];
}

/**
*  在keychain中获取缓存的值
*/
- (NSString *)cachedValueInKeyChain:(NSString *)key
{
    return [BFKeyChainStore stringForKey:key];
}

- (BOOL)hasCachedValueInKeyChain:(NSString *)key
{
    return [BFKeyChainStore stringForKey:key] != nil;
}

- (BOOL)removeItemInKeyChain:(NSString *)key
{
    return [BFKeyChainStore removeItemForKey:key];
}

/**
 *  在keychain中缓存
 */
- (void)cacheDataInKeyChain:(NSData *)data forKey:(NSString *)key
{
    [BFKeyChainStore setData:data forKey:key];
}

/**
 *  在keychain中获取缓存的值
 */
- (NSData *)cachedDataInKeyChain:(NSString *)key
{
    return [BFKeyChainStore dataForKey:key];
}

- (BOOL)hasCachedDataInKeyChain:(NSString *)key
{
    return [BFKeyChainStore dataForKey:key] != nil;
}

- (BOOL)removeAllItemInKeyChain
{
    return [BFKeyChainStore removeAllItems];
}


#pragma -
#pragma mark - uses of TMCache
- (void)cache:(id<NSCoding>)obj forKey:(NSString *)key expireAfter:(NSTimeInterval)expire
{
    NSDictionary *dict = @{keyCacheValueDate:[NSDate date], keyCacheValue:obj, keyCacheValueExpire: [NSNumber numberWithDouble:expire]};
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    [self.tmCache setObject:data forKey:key block:nil];
}

- (void)cache:(id<NSCoding>)obj forKey:(NSString *)key
{
    [self cache:obj forKey:key expireAfter:.0f];
}

/**
 * @brief 缓存key是否有值
 * @param key 缓存的key
 * @return BOOL YES 已缓存，NO未缓存
 */
- (BOOL)hasCached:(NSString *)key
{
    return [self cachedObjectForKey:key] != nil;
}

// get cached
- (id<NSCoding>)cachedObjectForKey:(NSString *)key
{
    NSData *data = [self.tmCache objectForKey:key];
    if (data == nil) {
        return nil;
    }
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (dict == nil) {
        return nil;
    }
    NSDate *cacheDate = [dict objectForKey:keyCacheValueDate];
    id<NSCoding> object = [dict objectForKey:keyCacheValue];
    NSTimeInterval expire = [[dict objectForKey:keyCacheValueExpire] doubleValue];
    
    // 判断是否过期
    if (expire > 0 && ABS([cacheDate timeIntervalSinceNow]) > expire) {
        [self removeCacheForKey:key];
        return nil;
    }
    return object;
}

// remove cache
- (void)removeCacheForKey:(NSString *)key
{
    [self.tmCache removeObjectForKey:key];
}

- (NSUInteger)cacheSize
{
    return [self.tmCache diskCache].byteCount;
}

- (void)clearCache
{
    [self.tmCache removeAllObjects];
}

@end
