//
//  BFError.h
//  OkayappsFrameworkDev
//
//  Created by xiongwei on 14/12/8.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

/**
 * For defining various error types used throughout the Nimbus framework.
 *
 * @ingroup NimbusCore
 * @defgroup Errors Errors
 * @{
 */

/** The Nimbus error domain. */
extern NSString* const BFNimbusErrorDomain;

/** The key used for images in the error's userInfo. */
extern NSString* const BFImageErrorKey;

/** NSError codes in NINimbusErrorDomain. */
typedef NS_ENUM(NSInteger, BFErrorDomainCode) {
    /** The image is too small to be used. */
    BFImageTooSmall = 1,
} ;


/**@}*/// End of Errors ///////////////////////////////////////////////////////////////////////////