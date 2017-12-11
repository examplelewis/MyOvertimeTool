//
//  BFFoundationMethods.m
//  OkayappsFrameworkDev
//
//  Created by xiongwei on 14/12/8.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import "BFFoundationMethods.h"

#import "BFDebuggingTools.h"
#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "OkayappsFramework requires ARC support."
#endif

#pragma mark - NSInvocation
NSInvocation* BFInvocationWithInstanceTarget(NSObject *targetObject, SEL selector) {
    NSMethodSignature* sig = [targetObject methodSignatureForSelector:selector];
    NSInvocation* inv = [NSInvocation invocationWithMethodSignature:sig];
    [inv setTarget:targetObject];
    [inv setSelector:selector];
    return inv;
}

// Deprecated. Please delete on the next minor version upgrade.
NSInvocation* BFInvocationWithClassTarget(Class targetClass, SEL selector) {
    return BFInvocationWithInstanceTarget((NSObject *)targetClass, selector);
}

#pragma mark - CGRect

CGRect BFRectContract(CGRect rect, CGFloat dx, CGFloat dy) {
    return CGRectMake(rect.origin.x, rect.origin.y, rect.size.width - dx, rect.size.height - dy);
}

CGRect BFRectExpand(CGRect rect, CGFloat dx, CGFloat dy) {
    return CGRectMake(rect.origin.x, rect.origin.y, rect.size.width + dx, rect.size.height + dy);
}

CGRect BFRectShift(CGRect rect, CGFloat dx, CGFloat dy) {
    return CGRectOffset(BFRectContract(rect, dx, dy), dx, dy);
}

CGRect BFEdgeInsetsOutsetRect(CGRect rect, UIEdgeInsets outsets) {
    return CGRectMake(rect.origin.x - outsets.left,
                      rect.origin.y - outsets.top,
                      rect.size.width + outsets.left + outsets.right,
                      rect.size.height + outsets.top + outsets.bottom);
}

CGFloat BFCenterX(CGSize containerSize, CGSize size) {
    return BFCGFloatFloor((containerSize.width - size.width) / 2.f);
}

CGFloat BFCenterY(CGSize containerSize, CGSize size) {
    return BFCGFloatFloor((containerSize.height - size.height) / 2.f);
}

CGRect BFFrameOfCenteredViewWithinView(UIView* viewToCenter, UIView* containerView) {
    CGPoint origin;
    CGSize containerViewSize = containerView.bounds.size;
    CGSize viewSize = viewToCenter.frame.size;
    origin.x = BFCenterX(containerViewSize, viewSize);
    origin.y = BFCenterY(containerViewSize, viewSize);
    return CGRectMake(origin.x, origin.y, viewSize.width, viewSize.height);
}

CGSize BFSizeOfStringWithLabelProperties(NSString *string, CGSize constrainedToSize, UIFont *font, NSLineBreakMode lineBreakMode, NSInteger numberOfLines) {
    if (string.length == 0) {
        return CGSizeZero;
    }
    
    CGFloat lineHeight = font.lineHeight;
    CGSize size = CGSizeZero;
    
    if (numberOfLines == 1) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        size = [string sizeWithFont:font forWidth:constrainedToSize.width lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        size = [string sizeWithFont:font constrainedToSize:constrainedToSize lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
        if (numberOfLines > 0) {
            size.height = MIN(size.height, numberOfLines * lineHeight);
        }
    }
    
    return size;
}

#pragma mark - NSRange

NSRange BFMakeNSRangeFromCFRange(CFRange range) {
    // CFRange stores its values in signed longs, but we're about to copy the values into
    // unsigned integers, let's check whether we're about to lose any information.
    BFASSERT(range.location >= 0 && range.location <= NSIntegerMax);
    BFASSERT(range.length >= 0 && range.length <= NSIntegerMax);
    return NSMakeRange(range.location, range.length);
}

#pragma mark - NSData

NSString* BFMD5HashFromData(NSData* data) {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    bzero(result, sizeof(result));
    CC_MD5_CTX md5Context;
    CC_MD5_Init(&md5Context);
    size_t bytesHashed = 0;
    while (bytesHashed < [data length]) {
        CC_LONG updateSize = 1024 * 1024;
        if (([data length] - bytesHashed) < (size_t)updateSize) {
            updateSize = (CC_LONG)([data length] - bytesHashed);
        }
        CC_MD5_Update(&md5Context, (char *)[data bytes] + bytesHashed, updateSize);
        bytesHashed += updateSize;
    }
    CC_MD5_Final(result, &md5Context);
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14],
            result[15]
            ];
}

NSString* BFSHA1HashFromData(NSData* data) {
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    bzero(result, sizeof(result));
    CC_SHA1_CTX sha1Context;
    CC_SHA1_Init(&sha1Context);
    size_t bytesHashed = 0;
    while (bytesHashed < [data length]) {
        CC_LONG updateSize = 1024 * 1024;
        if (([data length] - bytesHashed) < (size_t)updateSize) {
            updateSize = (CC_LONG)([data length] - bytesHashed);
        }
        CC_SHA1_Update(&sha1Context, (char *)[data bytes] + bytesHashed, updateSize);
        bytesHashed += updateSize;
    }
    CC_SHA1_Final(result, &sha1Context);
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14],
            result[15], result[16], result[17], result[18], result[19]
            ];
}

#pragma mark - NSString

NSString* BFMD5HashFromString(NSString* string) {
    return BFMD5HashFromData([string dataUsingEncoding:NSUTF8StringEncoding]);
}

NSString* BFSHA1HashFromString(NSString* string) {
    return BFSHA1HashFromData([string dataUsingEncoding:NSUTF8StringEncoding]);
}

BOOL BFIsStringWithWhitespaceAndNewlines(NSString* string) {
    NSCharacterSet* notWhitespaceAndNewlines = [[NSCharacterSet whitespaceAndNewlineCharacterSet] invertedSet];
    return [string isKindOfClass:[NSString class]] && [string rangeOfCharacterFromSet:notWhitespaceAndNewlines].length == 0;
}

NSComparisonResult BFCompareVersionStrings(NSString* string1, NSString* string2) {
    NSArray *oneComponents = [string1 componentsSeparatedByString:@"a"];
    NSArray *twoComponents = [string2 componentsSeparatedByString:@"a"];
    
    // The parts before the "a"
    NSString *oneMain = [oneComponents objectAtIndex:0];
    NSString *twoMain = [twoComponents objectAtIndex:0];
    
    // If main parts are different, return that result, regardless of alpha part
    NSComparisonResult mainDiff;
    if ((mainDiff = [oneMain compare:twoMain]) != NSOrderedSame) {
        return mainDiff;
    }
    
    // At this point the main parts are the same; just deal with alpha stuff
    // If one has an alpha part and the other doesn't, the one without is newer
    if ([oneComponents count] < [twoComponents count]) {
        return NSOrderedDescending;
        
    } else if ([oneComponents count] > [twoComponents count]) {
        return NSOrderedAscending;
        
    } else if ([oneComponents count] == 1) {
        // Neither has an alpha part, and we know the main parts are the same
        return NSOrderedSame;
    }
    
    // At this point the main parts are the same and both have alpha parts. Compare the alpha parts
    // numerically. If it's not a valid number (including empty string) it's treated as zero.
    NSNumber *oneAlpha = [NSNumber numberWithInt:[[oneComponents objectAtIndex:1] intValue]];
    NSNumber *twoAlpha = [NSNumber numberWithInt:[[twoComponents objectAtIndex:1] intValue]];
    return [oneAlpha compare:twoAlpha];
}

NSDictionary* BFQueryDictionaryFromStringUsingEncoding(NSString* string, NSStringEncoding encoding) {
    NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    NSScanner* scanner = [[NSScanner alloc] initWithString:string];
    
    while (![scanner isAtEnd]) {
        NSString* pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        
        NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count == 1 || kvPair.count == 2) {
            NSString* key = [kvPair[0] stringByReplacingPercentEscapesUsingEncoding:encoding];
            
            NSMutableArray* values = pairs[key];
            if (nil == values) {
                values = [NSMutableArray array];
                pairs[key] = values;
            }
            
            if (kvPair.count == 1) {
                [values addObject:[NSNull null]];
                
            } else if (kvPair.count == 2) {
                NSString* value = [kvPair[1] stringByReplacingPercentEscapesUsingEncoding:encoding];
                [values addObject:value];
            }
        }
    }
    return [pairs copy];
}

NSString* BFStringByAddingPercentEscapesForURLParameterString(NSString* parameter) {
    CFStringRef buffer = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                 (__bridge CFStringRef)parameter,
                                                                 NULL,
                                                                 (__bridge CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                 kCFStringEncodingUTF8);
    
    NSString* result = [NSString stringWithString:(__bridge NSString *)buffer];
    CFRelease(buffer);
    return result;
}

NSString* BFStringByAddingQueryDictionaryToString(NSString* string, NSDictionary* query) {
    NSMutableArray* pairs = [NSMutableArray array];
    for (NSString* key in [query keyEnumerator]) {
        NSString* value = BFStringByAddingPercentEscapesForURLParameterString([query objectForKey:key]);
        NSString* pair = [NSString stringWithFormat:@"%@=%@", key, value];
        [pairs addObject:pair];
    }
    
    NSString* params = [pairs componentsJoinedByString:@"&"];
    if ([string rangeOfString:@"?"].location == NSNotFound) {
        return [string stringByAppendingFormat:@"?%@", params];
        
    } else {
        return [string stringByAppendingFormat:@"&%@", params];
    }
}

#pragma mark - General Purpose
CGFloat BFBoundf(CGFloat value, CGFloat min, CGFloat max) {
    if (max < min) {
        max = min;
    }
    CGFloat bounded = value;
    if (bounded > max) {
        bounded = max;
    }
    if (bounded < min) {
        bounded = min;
    }
    return bounded;
}

NSInteger BFBoundi(NSInteger value, NSInteger min, NSInteger max) {
    if (max < min) {
        max = min;
    }
    NSInteger bounded = value;
    if (bounded > max) {
        bounded = max;
    }
    if (bounded < min) {
        bounded = min;
    }
    return bounded;
}
