//
//  BFViewRecycler.m
//  OkayappsFrameworkDev
//
//  Created by xiongwei on 14/12/10.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import "BFViewRecycler.h"

#import "BFMacros.h"
#import "BFDebuggingTools.h"

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "OkayappsFramework requires ARC support."
#endif

@interface BFViewRecycler()
@property (nonatomic, strong) NSMutableDictionary* reuseIdentifiersToRecycledViews;
@end

@implementation BFViewRecycler

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init {
    if ((self = [super init])) {
        _reuseIdentifiersToRecycledViews = [[NSMutableDictionary alloc] init];
        
        NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(reduceMemoryUsage)
                   name:UIApplicationDidReceiveMemoryWarningNotification
                 object:nil];
    }
    return self;
}

#pragma mark - Memory Warnings

- (void)reduceMemoryUsage {
    [self removeAllViews];
}

#pragma mark - Public

- (UIView<BFRecyclableView> *)dequeueReusableViewWithIdentifier:(NSString *)reuseIdentifier {
    NSMutableArray* views = [_reuseIdentifiersToRecycledViews objectForKey:reuseIdentifier];
    UIView<BFRecyclableView>* view = [views lastObject];
    if (nil != view) {
        [views removeLastObject];
        if ([view respondsToSelector:@selector(prepareForReuse)]) {
            [view prepareForReuse];
        }
    }
    return view;
}

- (void)recycleView:(UIView<BFRecyclableView> *)view {
    BFASSERT([view isKindOfClass:[UIView class]]);
    
    NSString* reuseIdentifier = nil;
    if ([view respondsToSelector:@selector(reuseIdentifier)]) {
        reuseIdentifier = [view reuseIdentifier];;
    }
    if (nil == reuseIdentifier) {
        reuseIdentifier = NSStringFromClass([view class]);
    }
    
    BFASSERT(nil != reuseIdentifier);
    if (nil == reuseIdentifier) {
        return;
    }
    
    NSMutableArray* views = [_reuseIdentifiersToRecycledViews objectForKey:reuseIdentifier];
    if (nil == views) {
        views = [[NSMutableArray alloc] init];
        [_reuseIdentifiersToRecycledViews setObject:views forKey:reuseIdentifier];
    }
    [views addObject:view];
}

- (void)removeAllViews {
    [_reuseIdentifiersToRecycledViews removeAllObjects];
}

@end

@implementation BFRecyclableView

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithFrame:CGRectZero])) {
        _reuseIdentifier = reuseIdentifier;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    return [self initWithReuseIdentifier:nil];
}

@end
