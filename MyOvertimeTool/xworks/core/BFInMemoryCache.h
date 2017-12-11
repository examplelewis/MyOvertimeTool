//
//  BFInMemoryCache.h
//  BbdtekFrameworkDev
//
//  Created by xiongwei on 14/12/8.
//  Copyright (c) 2014年 Bbdtek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BFMacros.h"

@interface BFMemoryCache : NSObject

// Designated initializer.
- (id)initWithCapacity:(NSUInteger)capacity;

- (NSUInteger)count;

- (void)storeObject:(id)object withName:(NSString *)name;
- (void)storeObject:(id)object withName:(NSString *)name expiresAfter:(NSDate *)expirationDate;

- (void)removeObjectWithName:(NSString *)name;
- (void)removeAllObjectsWithPrefix:(NSString *)prefix;
- (void)removeAllObjects;

- (id)objectWithName:(NSString *)name;
- (BOOL)containsObjectWithName:(NSString *)name;
- (NSDate *)dateOfLastAccessWithName:(NSString *)name;

- (NSString *)nameOfLeastRecentlyUsedObject;
- (NSString *)nameOfMostRecentlyUsedObject;

- (void)reduceMemoryUsage;

// Subclassing

- (BOOL)shouldSetObject:(id)object withName:(NSString *)name previousObject:(id)previousObject;
- (void)didSetObject:(id)object withName:(NSString *)name;
- (void)willRemoveObject:(id)object withName:(NSString *)name;

// Deprecated method. Use shouldSetObject:withName:previousObject: instead.
- (BOOL)willSetObject:(id)object withName:(NSString *)name previousObject:(id)previousObject __BF_DEPRECATED_METHOD;

@end

@interface BFImageMemoryCache : BFMemoryCache

@property (nonatomic, readonly) unsigned long long numberOfPixels;

@property (nonatomic)           unsigned long long maxNumberOfPixels;             // Default: 0 (unlimited)
@property (nonatomic)           unsigned long long maxNumberOfPixelsUnderStress;  // Default: 0 (unlimited)

@end
