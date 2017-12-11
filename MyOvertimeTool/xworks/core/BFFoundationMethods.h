//
//  BFFoundationMethods.h
//  OkayappsFrameworkDev
//
//  Created by xiongwei on 14/12/8.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "BFMacros.h"

#if defined __cplusplus
extern "C" {
#endif
    
/**
 * For filling in gaps in Apple's Foundation framework.
 *
 * @ingroup BFmbusCore
 * @defgroup Foundation-Methods Foundation Methods
 * @{
 *
 * Utility methods save time and headache. You've probably written dozens of your own. BFmbus
 * hopes to provide an ever-growing set of conveBFence methods that compliment the Foundation
 * framework's functionality.
 */
    
#pragma mark - NSInvocation Methods
    
/**
 * Construct an NSInvocation with an instance of an object and a selector
 *
 *  @return an NSInvocation that will call the given selector on the given target
 */
NSInvocation* BFInvocationWithInstanceTarget(NSObject* target, SEL selector);

/**
 * This method is deprecated. Please use BFInvocationWithInstanceTarget([object class], selector)
 * instead.
 */
NSInvocation* BFInvocationWithClassTarget(Class targetClass, SEL selector) __BF_DEPRECATED_METHOD;

#pragma mark - CGRect Methods

/**
 * For maBFpulating CGRects.
 *
 * @defgroup CGRect-Methods CGRect Methods
 * @{
 *
 * These methods provide additional means of modifying the edges of CGRects beyond the basics
 * included in CoreGraphics.
 */

/**
 * Modifies only the right and bottom edges of a CGRect.
 *
 * @return a CGRect with dx and dy subtracted from the width and height.
 *
 *      Example result: CGRectMake(x, y, w - dx, h - dy)
 */
CGRect BFRectContract(CGRect rect, CGFloat dx, CGFloat dy);

/**
 * Modifies only the right and bottom edges of a CGRect.
 *
 * @return a CGRect with dx and dy added to the width and height.
 *
 *      Example result: CGRectMake(x, y, w + dx, h + dy)
 */
CGRect BFRectExpand(CGRect rect, CGFloat dx, CGFloat dy);

/**
 * Modifies only the top and left edges of a CGRect.
 *
 * @return a CGRect whose origin has been offset by dx, dy, and whose size has been
 *              contracted by dx, dy.
 *
 *      Example result: CGRectMake(x + dx, y + dy, w - dx, h - dy)
 */
CGRect BFRectShift(CGRect rect, CGFloat dx, CGFloat dy);

/**
 * Inverse of UIEdgeInsetsInsetRect.
 *
 *      Example result: CGRectMake(x - left, y - top,
 *                                 w + left + right, h + top + bottom)
 */
CGRect BFEdgeInsetsOutsetRect(CGRect rect, UIEdgeInsets outsets);

/**
 * Returns the x position that will center size within containerSize.
 *
 *      Example result: floorf((containerSize.width - size.width) / 2.f)
 */
CGFloat BFCenterX(CGSize containerSize, CGSize size);

/**
 * Returns the y position that will center size within containerSize.
 *
 *      Example result: floorf((containerSize.height - size.height) / 2.f)
 */
CGFloat BFCenterY(CGSize containerSize, CGSize size);

/**
 * Returns a rect that will center viewToCenter within containerView.
 *
 * @return a CGPoint that will center viewToCenter within containerView.
 */
CGRect BFFrameOfCenteredViewWithinView(UIView* viewToCenter, UIView* containerView);

/**
 * Returns the size of the string with given UILabel properties.
 */
CGSize BFSizeOfStringWithLabelProperties(NSString *string, CGSize constrainedToSize, UIFont *font, NSLineBreakMode lineBreakMode, NSInteger numberOfLines);

/**@}*/


#pragma mark - NSRange Methods

/**
 * For maBFpulating NSRange.
 *
 * @defgroup NSRange-Methods NSRange Methods
 * @{
 */

/**
 * Create an NSRange object from a CFRange object.
 *
 * @return an NSRange object with the same values as the CFRange object.
 *
 * @attention This has the potential to behave unexpectedly because it converts the
 *                 CFRange's long values to unsigned integers. BFmbus will fire off a debug
 *                 assertion at runtime if the value will be chopped or the sign will change.
 *                 Even though the assertion will fire, the method will still chop or change
 *                 the sign of the values so you should take care to fix this.
 */
NSRange BFMakeNSRangeFromCFRange(CFRange range);

/**@}*/


#pragma mark - NSData Methods

/**
 * For maBFpulating NSData.
 *
 * @defgroup NSData-Methods NSData Methods
 * @{
 */

/**
 * Calculates an md5 hash of the data using CC_MD5.
 */
NSString* BFMD5HashFromData(NSData* data);

/**
 * Calculates a sha1 hash of the data using CC_SHA1.
 */
NSString* BFSHA1HashFromData(NSData* data);

/**@}*/


#pragma mark - NSString Methods

/**
 * For maBFpulating NSStrings.
 *
 * @defgroup NSString-Methods NSString Methods
 * @{
 */

/**
 * Calculates an md5 hash of the string using CC_MD5.
 *
 * Treats the string as UTF8.
 */
NSString* BFMD5HashFromString(NSString* string);

/**
 * Calculates a sha1 hash of the string using CC_SHA1.
 *
 * Treats the string as UTF8.
 */
NSString* BFSHA1HashFromString(NSString* string);

/**
 * Returns a Boolean value indicating whether the string is a NSString object that contains only
 * whitespace and newlines.
 */
BOOL BFIsStringWithWhitespaceAndNewlines(NSString* string);

/**
 * Compares two strings expressing software versions.
 *
 * The comparison is (except for the development version provisions noted below) lexicographic
 * string comparison. So as long as the strings being compared use consistent version formats,
 * a variety of schemes are supported. For example "3.02" < "3.03" and "3.0.2" < "3.0.3". If you
 * mix such schemes, like trying to compare "3.02" and "3.0.3", the result may not be what you
 * expect.
 *
 * Development versions are also supported by adding an "a" character and more version info after
 * it. For example "3.0a1" or "3.01a4". The way these are handled is as follows: if the parts
 * before the "a" are different, the parts after the "a" are ignored. If the parts before the "a"
 * are identical, the result of the comparison is the result of NUMERICALLY comparing the parts
 * after the "a". If the part after the "a" is empty, it is treated as if it were "0". If one
 * string has an "a" and the other does not (e.g. "3.0" and "3.0a1") the one without the "a"
 * is newer.
 *
 * Examples (?? means undefined):
 * @htmlonly
 * <pre>
 *   "3.0" = "3.0"
 *   "3.0a2" = "3.0a2"
 *   "3.0" > "2.5"
 *   "3.1" > "3.0"
 *   "3.0a1" < "3.0"
 *   "3.0a1" < "3.0a4"
 *   "3.0a2" < "3.0a19"  <-- numeric, not lexicographic
 *   "3.0a" < "3.0a1"
 *   "3.02" < "3.03"
 *   "3.0.2" < "3.0.3"
 *   "3.00" ?? "3.0"
 *   "3.02" ?? "3.0.3"
 *   "3.02" ?? "3.0.2"
 * </pre>
 * @endhtmlonly
 */
NSComparisonResult BFCompareVersionStrings(NSString* string1, NSString* string2);

/**
 * Parses a URL query string into a dictionary where the values are arrays.
 *
 * A query string is one that looks like &param1=value1&param2=value2...
 *
 * The resulting NSDictionary will contain keys for each parameter name present in the query.
 * The value for each key will be an NSArray which may be empty if the key is simply present
 * in the query. Otherwise each object in the array with be an NSString corresponding to a value
 * in the query for that parameter.
 */
NSDictionary* BFQueryDictionaryFromStringUsingEncoding(NSString* string, NSStringEncoding encoding);

/**
 * Returns a string that has been escaped for use as a URL parameter.
 */
NSString* BFStringByAddingPercentEscapesForURLParameterString(NSString* parameter);

/**
 * Appends a dictionary of query parameters to a string, adding the ? character if necessary.
 */
NSString* BFStringByAddingQueryDictionaryToString(NSString* string, NSDictionary* query);

/**@}*/


#pragma mark - CGFloat Methods

/**
 * For maBFpulating CGFloat.
 *
 * @defgroup CGFloat-Methods CGFloat Methods
 * @{
 *
 * These methods provide math functions on CGFloats. They could easily be replaced with <tgmath.h>
 * but that is currently (Xcode 5.0) incompatible with CLANG_ENABLE_MODULES (on by default for
 * many projects/targets). We'll use CG_INLINE because this really should be completely inline.
 */

#if CGFLOAT_IS_DOUBLE
#define BF_CGFLOAT_EPSILON DBL_EPSILON
#else
#define BF_CGFLOAT_EPSILON FLT_EPSILON
#endif

/**
 * fabs()/fabsf() sized for CGFloat
 */
CG_INLINE CGFloat BFCGFloatAbs(CGFloat x) {
#if CGFLOAT_IS_DOUBLE
    return (CGFloat)fabs(x);
#else
    return (CGFloat)fabsf(x);
#endif
}

/**
 * floor()/floorf() sized for CGFloat
 */
CG_INLINE CGFloat BFCGFloatFloor(CGFloat x) {
#if CGFLOAT_IS_DOUBLE
    return (CGFloat)floor(x);
#else
    return (CGFloat)floorf(x);
#endif
}

/**
 * ceil()/ceilf() sized for CGFloat
 */
CG_INLINE CGFloat BFCGFloatCeil(CGFloat x) {
#if CGFLOAT_IS_DOUBLE
    return (CGFloat)ceil(x);
#else
    return (CGFloat)ceilf(x);
#endif
}

/**
 * round()/roundf() sized for CGFloat
 */
CG_INLINE CGFloat BFCGFloatRound(CGFloat x) {
#if CGFLOAT_IS_DOUBLE
    return (CGFloat)round(x);
#else
    return (CGFloat)roundf(x);
#endif
}

/**
 * sqrt()/sqrtf() sized for CGFloat
 */
CG_INLINE CGFloat BFCGFloatSqRt(CGFloat x) {
#if CGFLOAT_IS_DOUBLE
    return (CGFloat)sqrt(x);
#else
    return (CGFloat)sqrtf(x);
#endif
}

/**
 * copysign()/copysignf() sized for CGFloat
 */
CG_INLINE CGFloat BFCGFloatCopySign(CGFloat x, CGFloat y) {
#if CGFLOAT_IS_DOUBLE
    return (CGFloat)copysign(x, y);
#else
    return (CGFloat)copysignf(x, y);
#endif
}

/**
 * pow()/powf() sized for CGFloat
 */
CG_INLINE CGFloat BFCGFloatPow(CGFloat x, CGFloat y) {
#if CGFLOAT_IS_DOUBLE
    return (CGFloat)pow(x, y);
#else
    return (CGFloat)powf(x, y);
#endif
}

/**
 * cos()/cosf() sized for CGFloat
 */
CG_INLINE CGFloat BFCGFloatCos(CGFloat x) {
#if CGFLOAT_IS_DOUBLE
    return (CGFloat)cos(x);
#else
    return (CGFloat)cosf(x);
#endif
}

/**@}*/

#pragma mark - General Purpose Methods

/**
 * For general purpose foundation type maBFpulation.
 *
 * @defgroup General-Purpose-Methods General Purpose Methods
 * @{
 */

/**
 * Bounds a given value within the min and max values.
 *
 * If max < min then value will be min.
 *
 * @returns min <= result <= max
 */
CGFloat BFBoundf(CGFloat value, CGFloat min, CGFloat max);

/**
 * Bounds a given value within the min and max values.
 *
 * If max < min then value will be min.
 *
 * @returns min <= result <= max
 */
NSInteger BFBoundi(NSInteger value, NSInteger min, NSInteger max);

/**@}*/
    
#if defined __cplusplus
};
#endif

/**@}*/// End of Foundation Methods ///////////////////////////////////////////////////////////////

