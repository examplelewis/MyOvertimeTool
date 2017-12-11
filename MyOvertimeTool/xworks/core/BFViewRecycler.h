//
//  BFViewRecycler.h
//  OkayappsFrameworkDev
//
//  Created by xiongwei on 14/12/10.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol BFRecyclableView;

@interface BFViewRecycler : NSObject

- (UIView<BFRecyclableView> *)dequeueReusableViewWithIdentifier:(NSString *)reuseIdentifier;

- (void)recycleView:(UIView<BFRecyclableView> *)view;

- (void)removeAllViews;

@end

/**
 * The BFRecyclableView protocol defines a set of optional methods that a view may implement to
 * handle being added to a NIViewRecycler.
 */
@protocol BFRecyclableView <NSObject>

@optional

/**
 * The identifier used to categorize views into buckets for reuse.
 *
 * Views will be reused when a new view is requested with a matching identifier.
 *
 * If the reuseIdentifier is nil then the class name will be used.
 */
@property (nonatomic, copy) NSString* reuseIdentifier;

/**
 * Called immediately after the view has been dequeued from the recycled view pool.
 */
- (void)prepareForReuse;

@end

@interface BFRecyclableView : UIView <BFRecyclableView>

// Designated initializer.
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic, copy) NSString* reuseIdentifier;

@end