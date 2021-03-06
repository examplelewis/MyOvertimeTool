#import "BFInMemoryCache.h"

NSString * const TMMemoryCachePrefix = @"com.tumblr.TMMemoryCache";

@interface BFInMemoryCache ()
#if OS_OBJECT_USE_OBJC
@property (strong, nonatomic) dispatch_queue_t queue;
#else
@property (assign, nonatomic) dispatch_queue_t queue;
#endif
@property (strong, nonatomic) NSMutableDictionary *dictionary;
@property (strong, nonatomic) NSMutableDictionary *dates;
@property (strong, nonatomic) NSMutableDictionary *costs;
@end

@implementation BFInMemoryCache

@synthesize ageLimit = _ageLimit;
@synthesize costLimit = _costLimit;
@synthesize totalCost = _totalCost;
@synthesize willAddObjectBlock = _willAddObjectBlock;
@synthesize willRemoveObjectBlock = _willRemoveObjectBlock;
@synthesize willRemoveAllObjectsBlock = _willRemoveAllObjectsBlock;
@synthesize didAddObjectBlock = _didAddObjectBlock;
@synthesize didRemoveObjectBlock = _didRemoveObjectBlock;
@synthesize didRemoveAllObjectsBlock = _didRemoveAllObjectsBlock;
@synthesize didReceiveMemoryWarningBlock = _didReceiveMemoryWarningBlock;
@synthesize didEnterBackgroundBlock = _didEnterBackgroundBlock;

#pragma mark - Initialization -

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    #if !OS_OBJECT_USE_OBJC
    dispatch_release(_queue);
    _queue = nil;
    #endif
}

- (id)init
{
    if (self = [super init]) {
        NSString *queueName = [[NSString alloc] initWithFormat:@"%@.%p", TMMemoryCachePrefix, self];
        _queue = dispatch_queue_create([queueName UTF8String], DISPATCH_QUEUE_CONCURRENT);

        _dictionary = [[NSMutableDictionary alloc] init];
        _dates = [[NSMutableDictionary alloc] init];
        _costs = [[NSMutableDictionary alloc] init];

        _willAddObjectBlock = nil;
        _willRemoveObjectBlock = nil;
        _willRemoveAllObjectsBlock = nil;

        _didAddObjectBlock = nil;
        _didRemoveObjectBlock = nil;
        _didRemoveAllObjectsBlock = nil;

        _didReceiveMemoryWarningBlock = nil;
        _didEnterBackgroundBlock = nil;

        _ageLimit = 0.0;
        _costLimit = 0;
        _totalCost = 0;

        _removeAllObjectsOnMemoryWarning = YES;
        _removeAllObjectsOnEnteringBackground = YES;

        #if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_4_0
        for (NSString *name in @[UIApplicationDidReceiveMemoryWarningNotification, UIApplicationDidEnterBackgroundNotification]) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(didObserveApocalypticNotification:)
                                                         name:name
                                                       object:[UIApplication sharedApplication]];
        }
        #endif
    }
    return self;
}

+ (instancetype)sharedCache
{
    static id cache;
    static dispatch_once_t predicate;

    dispatch_once(&predicate, ^{
        cache = [[self alloc] init];
    });

    return cache;
}

#pragma mark - Private Methods -

- (void)didObserveApocalypticNotification:(NSNotification *)notification
{
    #if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_4_0

    if ([[notification name] isEqualToString:UIApplicationDidReceiveMemoryWarningNotification]) {
        if (self.removeAllObjectsOnMemoryWarning)
            [self removeAllObjects:nil];

        __weak BFInMemoryCache *weakSelf = self;

        dispatch_async(_queue, ^{
            BFInMemoryCache *strongSelf = weakSelf;
            if (!strongSelf)
                return;

            if (strongSelf->_didReceiveMemoryWarningBlock)
                strongSelf->_didReceiveMemoryWarningBlock(strongSelf);
        });
    } else if ([[notification name] isEqualToString:UIApplicationDidEnterBackgroundNotification]) {
        if (self.removeAllObjectsOnEnteringBackground)
            [self removeAllObjects:nil];

        __weak BFInMemoryCache *weakSelf = self;

        dispatch_async(_queue, ^{
            BFInMemoryCache *strongSelf = weakSelf;
            if (!strongSelf)
                return;

            if (strongSelf->_didEnterBackgroundBlock)
                strongSelf->_didEnterBackgroundBlock(strongSelf);
        });
    }
    
    #endif
}

- (void)removeObjectAndExecuteBlocksForKey:(NSString *)key
{
    id object = [_dictionary objectForKey:key];
    NSNumber *cost = [_costs objectForKey:key];

    if (_willRemoveObjectBlock)
        _willRemoveObjectBlock(self, key, object);

    if (cost)
        _totalCost -= [cost unsignedIntegerValue];

    [_dictionary removeObjectForKey:key];
    [_dates removeObjectForKey:key];
    [_costs removeObjectForKey:key];

    if (_didRemoveObjectBlock)
        _didRemoveObjectBlock(self, key, nil);
}

- (void)trimMemoryToDate:(NSDate *)trimDate
{
    NSArray *keysSortedByDate = [_dates keysSortedByValueUsingSelector:@selector(compare:)];
    
    for (NSString *key in keysSortedByDate) { // oldest objects first
        NSDate *accessDate = [_dates objectForKey:key];
        if (!accessDate)
            continue;
        
        if ([accessDate compare:trimDate] == NSOrderedAscending) { // older than trim date
            [self removeObjectAndExecuteBlocksForKey:key];
        } else {
            break;
        }
    }
}

- (void)trimToCostLimit:(NSUInteger)limit
{
    if (_totalCost <= limit)
        return;

    NSArray *keysSortedByCost = [_costs keysSortedByValueUsingSelector:@selector(compare:)];

    for (NSString *key in [keysSortedByCost reverseObjectEnumerator]) { // costliest objects first
        [self removeObjectAndExecuteBlocksForKey:key];

        if (_totalCost <= limit)
            break;
    }
}

- (void)trimToCostLimitByDate:(NSUInteger)limit
{
    if (_totalCost <= limit)
        return;

    NSArray *keysSortedByDate = [_dates keysSortedByValueUsingSelector:@selector(compare:)];

    for (NSString *key in keysSortedByDate) { // oldest objects first
        [self removeObjectAndExecuteBlocksForKey:key];

        if (_totalCost <= limit)
            break;
    }
}

- (void)trimToAgeLimitRecursively
{
    if (_ageLimit == 0.0)
        return;

    NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:-_ageLimit];
    [self trimMemoryToDate:date];
    
    __weak BFInMemoryCache *weakSelf = self;
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_ageLimit * NSEC_PER_SEC));
    dispatch_after(time, _queue, ^(void){
        BFInMemoryCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;
        
        __weak BFInMemoryCache *weakSelf = strongSelf;
        
        dispatch_barrier_async(strongSelf->_queue, ^{
            BFInMemoryCache *strongSelf = weakSelf;
            [strongSelf trimToAgeLimitRecursively];
        });
    });
}

#pragma mark - Public Asynchronous Methods -

- (void)objectForKey:(NSString *)key block:(BFMemoryCacheObjectBlock)block
{
    NSDate *now = [[NSDate alloc] init];
    
    if (!key || !block)
        return;

    __weak BFInMemoryCache *weakSelf = self;

    dispatch_async(_queue, ^{
        BFInMemoryCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;

        id object = [strongSelf->_dictionary objectForKey:key];

        if (object) {
            __weak BFInMemoryCache *weakSelf = strongSelf;
            dispatch_barrier_async(strongSelf->_queue, ^{
                BFInMemoryCache *strongSelf = weakSelf;
                if (strongSelf)
                    [strongSelf->_dates setObject:now forKey:key];
            });
        }

        block(strongSelf, key, object);
    });
}

- (void)setObject:(id)object forKey:(NSString *)key block:(BFMemoryCacheObjectBlock)block
{
    [self setObject:object forKey:key withCost:0 block:block];
}

- (void)setObject:(id)object forKey:(NSString *)key withCost:(NSUInteger)cost block:(BFMemoryCacheObjectBlock)block
{
    NSDate *now = [[NSDate alloc] init];

    if (!key || !object)
        return;

    __weak BFInMemoryCache *weakSelf = self;

    dispatch_barrier_async(_queue, ^{
        BFInMemoryCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;

        if (strongSelf->_willAddObjectBlock)
            strongSelf->_willAddObjectBlock(strongSelf, key, object);

        [strongSelf->_dictionary setObject:object forKey:key];
        [strongSelf->_dates setObject:now forKey:key];
        [strongSelf->_costs setObject:@(cost) forKey:key];

        _totalCost += cost;

        if (strongSelf->_didAddObjectBlock)
            strongSelf->_didAddObjectBlock(strongSelf, key, object);

        if (strongSelf->_costLimit > 0)
            [strongSelf trimToCostByDate:strongSelf->_costLimit block:nil];

        if (block) {
            __weak BFInMemoryCache *weakSelf = strongSelf;
            dispatch_async(strongSelf->_queue, ^{
                BFInMemoryCache *strongSelf = weakSelf;
                if (strongSelf)
                    block(strongSelf, key, object);
            });
        }
    });
}

- (void)removeObjectForKey:(NSString *)key block:(BFMemoryCacheObjectBlock)block
{
    if (!key)
        return;

    __weak BFInMemoryCache *weakSelf = self;

    dispatch_barrier_async(_queue, ^{
        BFInMemoryCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;

        [strongSelf removeObjectAndExecuteBlocksForKey:key];

        if (block) {
            __weak BFInMemoryCache *weakSelf = strongSelf;
            dispatch_async(strongSelf->_queue, ^{
                BFInMemoryCache *strongSelf = weakSelf;
                if (strongSelf)
                    block(strongSelf, key, nil);
            });
        }
    });
}

- (void)trimToDate:(NSDate *)trimDate block:(BFMemoryCacheBlock)block
{
    if (!trimDate)
        return;

    if ([trimDate isEqualToDate:[NSDate distantPast]]) {
        [self removeAllObjects:block];
        return;
    }

    __weak BFInMemoryCache *weakSelf = self;

    dispatch_barrier_async(_queue, ^{
        BFInMemoryCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;

        [strongSelf trimMemoryToDate:trimDate];

        if (block) {
            __weak BFInMemoryCache *weakSelf = strongSelf;
            dispatch_async(strongSelf->_queue, ^{
                BFInMemoryCache *strongSelf = weakSelf;
                if (strongSelf)
                    block(strongSelf);
            });
        }
    });
}

- (void)trimToCost:(NSUInteger)cost block:(BFMemoryCacheBlock)block
{
    __weak BFInMemoryCache *weakSelf = self;

    dispatch_barrier_async(_queue, ^{
        BFInMemoryCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;

        [strongSelf trimToCostLimit:cost];

        if (block) {
            __weak BFInMemoryCache *weakSelf = strongSelf;
            dispatch_async(strongSelf->_queue, ^{
                BFInMemoryCache *strongSelf = weakSelf;
                if (strongSelf)
                    block(strongSelf);
            });
        }
    });
}

- (void)trimToCostByDate:(NSUInteger)cost block:(BFMemoryCacheBlock)block
{
    __weak BFInMemoryCache *weakSelf = self;

    dispatch_barrier_async(_queue, ^{
        BFInMemoryCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;

        [strongSelf trimToCostLimitByDate:cost];

        if (block) {
            __weak BFInMemoryCache *weakSelf = strongSelf;
            dispatch_async(strongSelf->_queue, ^{
                BFInMemoryCache *strongSelf = weakSelf;
                if (strongSelf)
                    block(strongSelf);
            });
        }
    });
}

- (void)removeAllObjects:(BFMemoryCacheBlock)block
{
    __weak BFInMemoryCache *weakSelf = self;

    dispatch_barrier_async(_queue, ^{
        BFInMemoryCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;

        if (strongSelf->_willRemoveAllObjectsBlock)
            strongSelf->_willRemoveAllObjectsBlock(strongSelf);

        [strongSelf->_dictionary removeAllObjects];
        [strongSelf->_dates removeAllObjects];
        [strongSelf->_costs removeAllObjects];
        
        strongSelf->_totalCost = 0;

        if (strongSelf->_didRemoveAllObjectsBlock)
            strongSelf->_didRemoveAllObjectsBlock(strongSelf);

        if (block) {
            __weak BFInMemoryCache *weakSelf = strongSelf;
            dispatch_async(strongSelf->_queue, ^{
                BFInMemoryCache *strongSelf = weakSelf;
                if (strongSelf)
                    block(strongSelf);
            });
        }
    });
}

- (void)enumerateObjectsWithBlock:(BFMemoryCacheObjectBlock)block completionBlock:(BFMemoryCacheBlock)completionBlock
{
    if (!block)
        return;

    __weak BFInMemoryCache *weakSelf = self;

    dispatch_barrier_async(_queue, ^{
        BFInMemoryCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;

        NSArray *keysSortedByDate = [strongSelf->_dates keysSortedByValueUsingSelector:@selector(compare:)];
        
        for (NSString *key in keysSortedByDate) {
            block(strongSelf, key, [strongSelf->_dictionary objectForKey:key]);
        }

        if (completionBlock) {
            __weak BFInMemoryCache *weakSelf = strongSelf;
            dispatch_async(strongSelf->_queue, ^{
                BFInMemoryCache *strongSelf = weakSelf;
                if (strongSelf)
                    completionBlock(strongSelf);
            });
        }
    });
}

#pragma mark - Public Synchronous Methods -

- (id)objectForKey:(NSString *)key
{
    if (!key)
        return nil;

    __block id objectForKey = nil;

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    [self objectForKey:key block:^(BFInMemoryCache *cache, NSString *key, id object) {
        objectForKey = object;
        dispatch_semaphore_signal(semaphore);
    }];

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    #if !OS_OBJECT_USE_OBJC
    dispatch_release(semaphore);
    #endif

    return objectForKey;
}

- (void)setObject:(id)object forKey:(NSString *)key
{
    [self setObject:object forKey:key withCost:0];
}

- (void)setObject:(id)object forKey:(NSString *)key withCost:(NSUInteger)cost
{
    if (!object || !key)
        return;

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    [self setObject:object forKey:key withCost:cost block:^(BFInMemoryCache *cache, NSString *key, id object) {
        dispatch_semaphore_signal(semaphore);
    }];

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    #if !OS_OBJECT_USE_OBJC
    dispatch_release(semaphore);
    #endif
}

- (void)removeObjectForKey:(NSString *)key
{
    if (!key)
        return;
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    [self removeObjectForKey:key block:^(BFInMemoryCache *cache, NSString *key, id object) {
        dispatch_semaphore_signal(semaphore);
    }];

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    #if !OS_OBJECT_USE_OBJC
    dispatch_release(semaphore);
    #endif
}

- (void)trimToDate:(NSDate *)date
{
    if (!date)
        return;

    if ([date isEqualToDate:[NSDate distantPast]]) {
        [self removeAllObjects];
        return;
    }
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    [self trimToDate:date block:^(BFInMemoryCache *cache) {
        dispatch_semaphore_signal(semaphore);
    }];

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    #if !OS_OBJECT_USE_OBJC
    dispatch_release(semaphore);
    #endif
}

- (void)trimToCost:(NSUInteger)cost
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    [self trimToCost:cost block:^(BFInMemoryCache *cache) {
        dispatch_semaphore_signal(semaphore);
    }];

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    #if !OS_OBJECT_USE_OBJC
    dispatch_release(semaphore);
    #endif
}

- (void)trimToCostByDate:(NSUInteger)cost
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    [self trimToCostByDate:cost block:^(BFInMemoryCache *cache) {
        dispatch_semaphore_signal(semaphore);
    }];

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    #if !OS_OBJECT_USE_OBJC
    dispatch_release(semaphore);
    #endif
}

- (void)removeAllObjects
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    [self removeAllObjects:^(BFInMemoryCache *cache) {
        dispatch_semaphore_signal(semaphore);
    }];

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    #if !OS_OBJECT_USE_OBJC
    dispatch_release(semaphore);
    #endif
}

- (void)enumerateObjectsWithBlock:(BFMemoryCacheObjectBlock)block
{
    if (!block)
        return;

    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    [self enumerateObjectsWithBlock:block completionBlock:^(BFInMemoryCache *cache) {
        dispatch_semaphore_signal(semaphore);
    }];

    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

    #if !OS_OBJECT_USE_OBJC
    dispatch_release(semaphore);
    #endif
}

#pragma mark - Public Thread Safe Accessors -

- (BFMemoryCacheObjectBlock)willAddObjectBlock
{
    __block BFMemoryCacheObjectBlock block = nil;

    dispatch_sync(_queue, ^{
        block = self->_willAddObjectBlock;
    });

    return block;
}

- (void)setWillAddObjectBlock:(BFMemoryCacheObjectBlock)block
{
    __weak BFInMemoryCache *weakSelf = self;
    
    dispatch_barrier_async(_queue, ^{
        BFInMemoryCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;

        strongSelf->_willAddObjectBlock = [block copy];
    });
}

- (BFMemoryCacheObjectBlock)willRemoveObjectBlock
{
    __block BFMemoryCacheObjectBlock block = nil;

    dispatch_sync(_queue, ^{
        block = _willRemoveObjectBlock;
    });

    return block;
}

- (void)setWillRemoveObjectBlock:(BFMemoryCacheObjectBlock)block
{
    __weak BFInMemoryCache *weakSelf = self;

    dispatch_barrier_async(_queue, ^{
        BFInMemoryCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;

        strongSelf->_willRemoveObjectBlock = [block copy];
    });
}

- (BFMemoryCacheBlock)willRemoveAllObjectsBlock
{
    __block BFMemoryCacheBlock block = nil;

    dispatch_sync(_queue, ^{
        block = _willRemoveAllObjectsBlock;
    });

    return block;
}

- (void)setWillRemoveAllObjectsBlock:(BFMemoryCacheBlock)block
{
    __weak BFInMemoryCache *weakSelf = self;

    dispatch_barrier_async(_queue, ^{
        BFInMemoryCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;

        strongSelf->_willRemoveAllObjectsBlock = [block copy];
    });
}

- (BFMemoryCacheObjectBlock)didAddObjectBlock
{
    __block BFMemoryCacheObjectBlock block = nil;

    dispatch_sync(_queue, ^{
        block = _didAddObjectBlock;
    });

    return block;
}

- (void)setDidAddObjectBlock:(BFMemoryCacheObjectBlock)block
{
    __weak BFInMemoryCache *weakSelf = self;

    dispatch_barrier_async(_queue, ^{
        BFInMemoryCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;

        strongSelf->_didAddObjectBlock = [block copy];
    });
}

- (BFMemoryCacheObjectBlock)didRemoveObjectBlock
{
    __block BFMemoryCacheObjectBlock block = nil;

    dispatch_sync(_queue, ^{
        block = _didRemoveObjectBlock;
    });

    return block;
}

- (void)setDidRemoveObjectBlock:(BFMemoryCacheObjectBlock)block
{
    __weak BFInMemoryCache *weakSelf = self;

    dispatch_barrier_async(_queue, ^{
        BFInMemoryCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;

        strongSelf->_didRemoveObjectBlock = [block copy];
    });
}

- (BFMemoryCacheBlock)didRemoveAllObjectsBlock
{
    __block BFMemoryCacheBlock block = nil;

    dispatch_sync(_queue, ^{
        block = _didRemoveAllObjectsBlock;
    });

    return block;
}

- (void)setDidRemoveAllObjectsBlock:(BFMemoryCacheBlock)block
{
    __weak BFInMemoryCache *weakSelf = self;

    dispatch_barrier_async(_queue, ^{
        BFInMemoryCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;

        strongSelf->_didRemoveAllObjectsBlock = [block copy];
    });
}

- (BFMemoryCacheBlock)didReceiveMemoryWarningBlock
{
    __block BFMemoryCacheBlock block = nil;

    dispatch_sync(_queue, ^{
        block = _didReceiveMemoryWarningBlock;
    });

    return block;
}

- (void)setDidReceiveMemoryWarningBlock:(BFMemoryCacheBlock)block
{
    __weak BFInMemoryCache *weakSelf = self;

    dispatch_barrier_async(_queue, ^{
        BFInMemoryCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;

        strongSelf->_didReceiveMemoryWarningBlock = [block copy];
    });
}

- (BFMemoryCacheBlock)didEnterBackgroundBlock
{
    __block BFMemoryCacheBlock block = nil;

    dispatch_sync(_queue, ^{
        block = _didEnterBackgroundBlock;
    });

    return block;
}

- (void)setDidEnterBackgroundBlock:(BFMemoryCacheBlock)block
{
    __weak BFInMemoryCache *weakSelf = self;

    dispatch_barrier_async(_queue, ^{
        BFInMemoryCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;

        strongSelf->_didEnterBackgroundBlock = [block copy];
    });
}

- (NSTimeInterval)ageLimit
{
    __block NSTimeInterval ageLimit = 0.0;
    
    dispatch_sync(_queue, ^{
        ageLimit = _ageLimit;
    });
    
    return ageLimit;
}

- (void)setAgeLimit:(NSTimeInterval)ageLimit
{
    __weak BFInMemoryCache *weakSelf = self;

    dispatch_barrier_async(_queue, ^{
        BFInMemoryCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;
        
        strongSelf->_ageLimit = ageLimit;
        
        [strongSelf trimToAgeLimitRecursively];
    });
}

- (NSUInteger)costLimit
{
    __block NSUInteger costLimit = 0;

    dispatch_sync(_queue, ^{
        costLimit = _costLimit;
    });

    return costLimit;
}

- (void)setCostLimit:(NSUInteger)costLimit
{
    __weak BFInMemoryCache *weakSelf = self;

    dispatch_barrier_async(_queue, ^{
        BFInMemoryCache *strongSelf = weakSelf;
        if (!strongSelf)
            return;

        strongSelf->_costLimit = costLimit;

        if (costLimit > 0)
            [strongSelf trimToCostLimitByDate:costLimit];
    });
}

- (NSUInteger)totalCost
{
    __block NSUInteger cost = 0;
    
    dispatch_sync(_queue, ^{
        cost = _totalCost;
    });
    
    return cost;
}

@end
