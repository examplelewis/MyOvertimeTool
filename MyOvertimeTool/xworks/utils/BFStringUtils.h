//
//  BFStringUtils.h
//  OkayappsFrameworkDev
//
//  NSString工具类
//
//  Created by xiongwei on 14/12/11.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XworksCore.h"

#if defined __cplusplus
extern "C" {
#endif

    /*!
     *  @author xiongwei
     *
     *  @brief  判断是否是有效的NSString
     *
     *  @param str 待判断的对象
     *
     *  @return YES - 有效， NO - 无效
     */
    BOOL BFIsValidString(id str);
    
    /**
     * @breif 去掉字符串收尾的空白
     * @param str 待处理的对象
     */
    NSString* BFTrimString(NSString *str);
    
    /**
     * @brief UUID生产随机唯一的字符串
     * @return 生产的UUID字符串
     */
    NSString* BFUUIDString();
    
    /**
     * URLEncode
     */
    NSString* BFURLEncode(NSString *str);
    
    /**
     * URLDecode
     */
    NSString* BFURLDecode(NSString *str);
    
    /**
     * BASE64加密
     */
    NSData* BFBASE64EncodeData(NSData *data);
    
    /**
     * BASE64解密
     */
    NSData* BFBASE64DecodeData(NSData *data);
    
    /**
     * BASE64加密
     */
    NSString* BFBASE64Encode(NSString *str);
    
    /**
     * BASE64解密
     */
    NSString* BFBASE64Decode(NSString *str);
    

#if defined __cplusplus
};
#endif

//  拼音扩展
//
//  Created by xiongwei on 15/01/29.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

typedef void(^BFPinyinOutputStringBlock)(NSString *pinYin) ;

/*!
 *  @category
 *
 *  @author xiongwei
 *
 *  @brief 对汉字进行拼音解析的扩展
 */
@interface NSString (BFPinyin)

/*
 * 汉字转拼音（异步操作）
 * seperater:分隔符
 * outputblock:转换完成后的Block
 */
- (void)bf_toPinyinStringwithSeperater:(NSString *)seperater
                       outputBlock:(BFPinyinOutputStringBlock)outputBlock;

/*
 * 汉字转拼音（同步操作）
 * seperater:分隔符
 */
- (NSString *)bf_toPinyinStringWithSeperater:(NSString *)seperater;

@end

@interface NSString (BFUtils)
/**
 *  @brief 判断是否包含其他字符串
 *
 *  @param other
 *
 *  @return 
 */
- (BOOL)bf_containsString:(NSString*)other;

@end