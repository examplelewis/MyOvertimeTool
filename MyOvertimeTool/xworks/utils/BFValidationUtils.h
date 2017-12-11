//
//  BFValidationUtils.h
//  OkayappsFrameworkDev
//
//  数据验证工具类
//
//  Created by xiongwei on 14/12/12.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - NSString校验扩展
//  NSString校验扩展
//
//  Created by lcy on 14/12/12.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//
@interface NSString (BFValidation)

/**
 *  正则验证
 *  @param pattern 正则表达式
 *  @return 匹配为YES，否则为NO
 */
- (BOOL)regexMatch:(NSString *)pattern;

/**
 *  校验邮箱
 *
 *  @return 校验通过YES，不通过NO
 */
- (BOOL)isValidEmail;

/**
 *  校验中国大陆手机号码
 
 *  移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
 
 *  联通：130,131,132,152,155,156,185,186
 
 *  电信：133,1349,153,180,189
 
 *  虚拟运营商：170
 *
 *  @return 校验通过YES，不通过NO
 */
- (BOOL)isValidPhoneNumber;

/**
 *  校验中国大陆身份证号码
 *
 *  @return 校验通过YES，不通过NO
 */
- (BOOL)isValidIdCardNo;

/**
 *  获取指定范围的字符串
 *
 *  @param begin 起始位置
 *  @param end   结束位置
 *
 *  @return 子字符串
 */
- (NSString *)subStringWithBegin:(NSInteger)begin end:(NSInteger)end;

@end