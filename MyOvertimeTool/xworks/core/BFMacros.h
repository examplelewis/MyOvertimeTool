//
//  BFMacros.h
//  OkayappsFrameworkDev
//
//  Created by xiongwei on 14/12/8.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#pragma mark - Preprocessor Macros

/**
 * Mark a method or property as deprecated to the compiler.
 *
 * Any use of a deprecated method or property will flag a warning when compiling.
 *
 * Borrowed from Apple's AvailabiltyInternal.h header.
 *
 * @htmlonly
 * <pre>
 *   __AVAILABILITY_INTERNAL_DEPRECATED         __attribute__((deprecated))
 * </pre>
 * @endhtmlonly
 */
#define __BF_DEPRECATED_METHOD __attribute__((deprecated))

/**
 * Force a category to be loaded when an app starts up.
 *
 * Add this macro before each category implementation, so we don't have to use
 * -all_load or -force_load to load object files from static libraries that only contain
 * categories and no classes.
 * See http://developer.apple.com/library/mac/#qa/qa2006/qa1490.html for more info.
 */
#define BF_FIX_CATEGORY_BUG(name) @interface BF_FIX_CATEGORY_BUG_##name : NSObject @end \
@implementation BF_FIX_CATEGORY_BUG_##name @end

/**
 * Creates an opaque UIColor object from a byte-value color definition.
 */
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

/**
 * Creates a UIColor object from a byte-value color definition and alpha transparency.
 */
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

