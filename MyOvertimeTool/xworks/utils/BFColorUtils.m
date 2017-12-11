//
//  BFColorUtils.m
//  OkayappsFrameworkDev
//
//  Created by xiongwei on 14/12/12.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import "BFColorUtils.h"
#import "XworksCore.h"

BF_FIX_CATEGORY_BUG(BFColorUtils)

@implementation UIColor (BFCategory)

/**
 * Creates a new UIColor instance using a hex input and alpha value.
 *
 * @param {UInt32} Hex
 * @param {CGFloat} Alpha
 *
 * @return {UIColor}
 */
+ (UIColor *)colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [self colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:alpha];
}

/**
 * Creates a new UIColor instance using a hex input.
 *
 * @param {UInt32} Hex
 *
 * @return {UIColor}
 */
+ (UIColor *)colorWithHex:(UInt32)hex
{
    return [self colorWithHex:hex andAlpha:1.0];
}

/**
 * Creates a new UIColor instance using a hex string input.
 *
 * @param {NSString} Hex string (ie: @"ff", @"#fff", @"ff0000", or @"ccff00ff")
 *
 * @return {UIColor}
 */
+ (UIColor *)colorWithHexString:(id)hexString
{
    if (![hexString isKindOfClass:[NSString class]] || [hexString length] == 0) {
        return [self colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
    }
    
    const char *s = [hexString cStringUsingEncoding:NSASCIIStringEncoding];
    if (*s == '#') {
        ++s;
    }
    unsigned long long value = strtoll(s, nil, 16);
    int r, g, b, a;
    switch (strlen(s)) {
        case 2:
            // xx
            r = g = b = (int)value;
            a = 255;
            break;
        case 3:
            // RGB
            r = ((value & 0xf00) >> 8);
            g = ((value & 0x0f0) >> 4);
            b = ((value & 0x00f) >> 0);
            r = r * 16 + r;
            g = g * 16 + g;
            b = b * 16 + b;
            a = 255;
            break;
        case 6:
            // RRGGBB
            r = (value & 0xff0000) >> 16;
            g = (value & 0x00ff00) >>  8;
            b = (value & 0x0000ff) >>  0;
            a = 255;
            break;
        default:
            // AARRGGBB
            a = (value & 0xff000000) >> 24;
            r = (value & 0x00ff0000) >> 16;
            g = (value & 0x0000ff00) >>  8;
            b = (value & 0x000000ff) >>  0;
            break;
    }
    return [self colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/255.0f];
}

/**
 * Returns the hex value of the receiver. Alpha value is not included.
 *
 * @return {UInt32}
 */
- (UInt32)hexValue {
    CGFloat r,g,b,a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    
    UInt32 ri = r * 255.0;
    UInt32 gi = g * 255.0;
    UInt32 bi = b * 255.0;
    
    return (ri<<16) + (gi<<8) + bi;
}

/**
 *  是否为浅色
 */
- (BOOL)isLight {
    CGFloat r,g,b,a;
    [self getRed:&r green:&g blue:&b alpha:&a];
    
    UInt32 ri = r * 255.0;
    UInt32 gi = g * 255.0;
    UInt32 bi = b * 255.0;
    
    return BFCGFloatSqRt(ri * ri * .241f + gi * gi * .691f + bi * bi * .068f) > 130.0f;
}

@end
