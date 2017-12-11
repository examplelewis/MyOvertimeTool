//
//  BFStringUtils.m
//  OkayappsFrameworkDev
//
//  Created by xiongwei on 14/12/11.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import "BFStringUtils.h"
#import "XworksCore.h"
#import "GTMBase64.h"
#import "BFPinYin4Objc.h"


/**
 * @breif 判断是否是有效的NSString
 * @param str 待判断的对象
 **/
BOOL BFIsValidString(id str) {
    return [str isKindOfClass:[NSString class]] && [str length] > 0;
}

/**
 * @breif 去掉字符串收尾的空白
 * @param str 待处理的对象
 */
NSString* BFTrimString(NSString *str) {
    BFASSERT(([str isKindOfClass:[NSString class]] || str == nil));
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

NSString* BFUUIDString() {
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    NSString * uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return uuidString;
}

NSString* BFURLEncode(NSString *str) {
    BFASSERT(([str isKindOfClass:[NSString class]] || str == nil));
    CFStringRef encodedCFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef) str, nil, CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\| "), kCFStringEncodingUTF8);
    
    NSString *encodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) encodedCFString];
    
    if(!encodedString)
        encodedString = @"";
        
    return encodedString;
}

NSString* BFURLDecode(NSString *str) {
    BFASSERT(([str isKindOfClass:[NSString class]] || str == nil));
    CFStringRef decodedCFString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (__bridge CFStringRef) str, CFSTR(""), kCFStringEncodingUTF8);
    
    // We need to replace "+" with " " because the CF method above doesn't do it
    NSString *decodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) decodedCFString];
    return (!decodedString) ? @"" : [decodedString stringByReplacingOccurrencesOfString:@"+" withString:@" "];
}

/**
 * BASE64加密
 */
NSData* BFBASE64EncodeData(NSData *data) {
    return [GTMBase64 encodeData:data];
}

/**
 * BASE64解密
 */
NSData* BFBASE64DecodeData(NSData *data) {
    return [GTMBase64 decodeData:data];
}

/**
 * BASE64加密
 */
NSString* BFBASE64Encode(NSString *str) {
    return [[NSString alloc] initWithData:[GTMBase64 encodeData:[str dataUsingEncoding:NSUTF8StringEncoding]] encoding:NSUTF8StringEncoding];
}

/**
 * BASE64解密
 */
NSString* BFBASE64Decode(NSString *str) {
    return [[NSString alloc] initWithData:[GTMBase64 decodeData:[str dataUsingEncoding:NSUTF8StringEncoding]] encoding:NSUTF8StringEncoding];
}

BF_FIX_CATEGORY_BUG(BFPinyin)

@implementation NSString (BFPinyin)

- (void)bf_toPinyinStringwithSeperater:(NSString *)seperater outputBlock:(BFPinyinOutputStringBlock)outputBlock
{
    BFHanyuPinyinOutputFormat *outputFormat = [[BFHanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:BFToneTypeWithoutTone];
    [outputFormat setVCharType:BFVCharTypeWithV];
    [outputFormat setCaseType:BFCaseTypeUppercase];
    
    [BFPinyinHelper toHanyuPinyinStringWithNSString:self withHanyuPinyinOutputFormat:outputFormat withNSString:seperater outputBlock:^(NSString *pinyin){
        if (outputBlock != nil)
        {
            outputBlock(pinyin);
        }
    }];
}

- (NSString *)bf_toPinyinStringWithSeperater:(NSString *)seperater
{
    BFHanyuPinyinOutputFormat *outputFormat = [[BFHanyuPinyinOutputFormat alloc] init];
    [outputFormat setToneType:BFToneTypeWithoutTone];
    [outputFormat setVCharType:BFVCharTypeWithV];
    [outputFormat setCaseType:BFCaseTypeUppercase];
    
    return [BFPinyinHelper toHanyuPinyinStringWithNSString:self withHanyuPinyinOutputFormat:outputFormat withNSString:seperater];
}

@end

BF_FIX_CATEGORY_BUG(BFUtils)

@implementation NSString (BFUtils)

- (BOOL)bf_containsString:(NSString*)other
{
    if ([[UIDevice currentDevice].systemVersion integerValue] > 8) {
        return [self containsString:other];
    }
    NSRange range = [self rangeOfString:other];
    return (range.location == NSNotFound ? NO : YES);
}

@end