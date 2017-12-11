//
//  BFCacheManager.h
//  OkayAppsFramework
//
//  Created by 熊玮 on 14/7/22.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 * @brief 统一的数据缓存实现接口
 */
@interface BFCacheManager : NSObject

/**
 @brief 获取实例
 */
+ (BFCacheManager *)sharedCacheManager;

/**
 *  在keychain中缓存
 */
- (void)cacheInKeyChain:(NSString *)str forKey:(NSString *)key;

/**
 *  在keychain中获取缓存的值
 */
- (NSString *)cachedValueInKeyChain:(NSString *)key;

/**
 *  在keychain中是否存在缓存的值
 */
- (BOOL)hasCachedValueInKeyChain:(NSString *)key;

/**
 *  在keychain中删除缓存的值
 */
- (BOOL)removeItemInKeyChain:(NSString *)key;

/**
 *  在keychain中缓存
 */
- (void)cacheDataInKeyChain:(NSData *)data forKey:(NSString *)key;

/**
 *  在keychain中获取缓存的值
 */
- (NSData *)cachedDataInKeyChain:(NSString *)key;

/**
 * keyChain中时候有缓存
 */
- (BOOL)hasCachedDataInKeyChain:(NSString *)key;

/**
 * 清空KeyChain缓存
 */
- (BOOL)removeAllItemInKeyChain;

/**
 * @brief 缓存值，此值必须实现NSCoding协议
 * @param obj 待缓存的对象
 * @param key 缓存的key
 * @param expire 有效时间
 * @return void
 */
- (void)cache:(id<NSCoding>)obj forKey:(NSString *)key expireAfter:(NSTimeInterval)expire;

/**
 * @brief 缓存值，此值必须实现NSCoding协议，有效时间为0，标识永久有效
 * @param obj 待缓存的对象
 * @param key 缓存的key
 * @return void
 */
- (void)cache:(id<NSCoding>)obj forKey:(NSString *)key;

/**
 * @brief 缓存key是否有值
 * @param key 缓存的key
 * @return BOOL YES 已缓存，NO未缓存
 */
- (BOOL)hasCached:(NSString *)key;

/**
 * @brief 获取缓存值
 * @param key 缓存的key
 * @return id<NSCoding> 缓存值
 */
- (id<NSCoding>)cachedObjectForKey:(NSString *)key;

/**
 * @brief 删除缓存值
 * @param key 缓存的key
 * @return void
 */
- (void)removeCacheForKey:(NSString *)key;

/**
 * @brief 获取缓存大小
 * @return 缓存大小，单位为字节
 */
- (NSUInteger)cacheSize;

/**
 * @brief 清空缓存
 * @return void
 */
- (void)clearCache;

@end
