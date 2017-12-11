//
//  BFCache.h
//  OkayappsFrameowork
//
//  Created by 熊玮 on 14/7/22.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BFDiskCache.h"
#import "BFInMemoryCache.h"

@class BFCache;

typedef void (^BFCacheBlock)(BFCache *cache);
typedef void (^BFCacheObjectBlock)(BFCache *cache, NSString *key, id object);

@interface BFCache : NSObject

#pragma mark -
/// @name Core

/**
 The name of this cache, used to create the <diskCache> and also appearing in stack traces.
 */
@property (readonly) NSString *name;

/**
 A concurrent queue on which blocks passed to the asynchronous access methods are run.
 */
@property (readonly) dispatch_queue_t queue;

/**
 Synchronously retrieves the total byte count of the <diskCache> on the shared disk queue.
 */
@property (readonly) NSUInteger diskByteCount;

/**
 The underlying disk cache, see <TMDiskCache> for additional configuration and trimming options.
 */
@property (readonly) BFDiskCache *diskCache;

/**
 The underlying memory cache, see <TMMemoryCache> for additional configuration and trimming options.
 */
@property (readonly) BFInMemoryCache *memoryCache;

#pragma mark -
/// @name Initialization

/**
 A shared cache.
 
 @result The shared singleton cache instance.
 */
+ (instancetype)sharedCache;

/**
 Multiple instances with the same name are allowed and can safely access
 the same data on disk thanks to the magic of seriality. Also used to create the <diskCache>.
 
 @see name
 @param name The name of the cache.
 @result A new cache with the specified name.
 */
- (instancetype)initWithName:(NSString *)name;

/**
 The designated initializer. Multiple instances with the same name are allowed and can safely access
 the same data on disk thanks to the magic of seriality. Also used to create the <diskCache>.
 
 @see name
 @param name The name of the cache.
 @param rootPath The path of the cache on disk.
 @result A new cache with the specified name.
 */
- (instancetype)initWithName:(NSString *)name rootPath:(NSString *)rootPath;

#pragma mark -
/// @name Asynchronous Methods

/**
 Retrieves the object for the specified key. This method returns immediately and executes the passed
 block after the object is available, potentially in parallel with other blocks on the <queue>.
 
 @param key The key associated with the requested object.
 @param block A block to be executed concurrently when the object is available.
 */
- (void)objectForKey:(NSString *)key block:(BFCacheObjectBlock)block;

/**
 Stores an object in the cache for the specified key. This method returns immediately and executes the
 passed block after the object has been stored, potentially in parallel with other blocks on the <queue>.
 
 @param object An object to store in the cache.
 @param key A key to associate with the object. This string will be copied.
 @param block A block to be executed concurrently after the object has been stored, or nil.
 */
- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key block:(BFCacheObjectBlock)block;

/**
 Removes the object for the specified key. This method returns immediately and executes the passed
 block after the object has been removed, potentially in parallel with other blocks on the <queue>.
 
 @param key The key associated with the object to be removed.
 @param block A block to be executed concurrently after the object has been removed, or nil.
 */
- (void)removeObjectForKey:(NSString *)key block:(BFCacheObjectBlock)block;

/**
 Removes all objects from the cache that have not been used since the specified date. This method returns immediately and
 executes the passed block after the cache has been trimmed, potentially in parallel with other blocks on the <queue>.
 
 @param date Objects that haven't been accessed since this date are removed from the cache.
 @param block A block to be executed concurrently after the cache has been trimmed, or nil.
 */
- (void)trimToDate:(NSDate *)date block:(BFCacheBlock)block;

/**
 Removes all objects from the cache.This method returns immediately and executes the passed block after the
 cache has been cleared, potentially in parallel with other blocks on the <queue>.
 
 @param block A block to be executed concurrently after the cache has been cleared, or nil.
 */
- (void)removeAllObjects:(BFCacheBlock)block;

#pragma mark -
/// @name Synchronous Methods

/**
 Retrieves the object for the specified key. This method blocks the calling thread until the object is available.
 
 @see objectForKey:block:
 @param key The key associated with the object.
 @result The object for the specified key.
 */
- (id)objectForKey:(NSString *)key;

/**
 Stores an object in the cache for the specified key. This method blocks the calling thread until the object has been set.
 
 @see setObject:forKey:block:
 @param object An object to store in the cache.
 @param key A key to associate with the object. This string will be copied.
 */
- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key;

/**
 Removes the object for the specified key. This method blocks the calling thread until the object
 has been removed.
 
 @param key The key associated with the object to be removed.
 */
- (void)removeObjectForKey:(NSString *)key;

/**
 Removes all objects from the cache that have not been used since the specified date.
 This method blocks the calling thread until the cache has been trimmed.
 
 @param date Objects that haven't been accessed since this date are removed from the cache.
 */
- (void)trimToDate:(NSDate *)date;

/**
 Removes all objects from the cache. This method blocks the calling thread until the cache has been cleared.
 */
- (void)removeAllObjects;

@end
