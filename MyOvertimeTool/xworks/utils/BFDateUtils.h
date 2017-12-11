//
//  BFDateUtils.h
//  OkayappsFrameworkDev
//
//  Created by xiongwei on 14/12/11.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XworksCore.h"

#pragma mark - Parse the date compare results

#define EarlierThan(result) ({__typeof__(result) __r = (result); (__r == NSOrderedAscending);})
#define EarlierThanOrEqualTo(result) ({__typeof__(result) __r = (result); (__r == NSOrderedAscending) || (__r == NSOrderedSame);})
#define LaterThan(result) ({__typeof__(result) __r = (result); (__r == NSOrderedDescending);})
#define LaterThanOrEqualTo(result) ({__typeof__(result) __r = (result); (__r == NSOrderedDescending) || (__r == NSOrderedSame);})
#define Equal(result) (#result == NSOrderedSame)

static NSUInteger const BFSecondsPerMinute = 60;
static NSUInteger const BFSecondsPerHour = 60 * 60;
static NSUInteger const BFSecondsPerDay = 60 * 60 * 24;

#pragma mark - Frequently used date format

#define Date_Format_yyyyMMdd            @"yyyy-MM-dd"
#define Date_Format_yyyyMM              @"yyyy-MM"
#define Date_Format_MMdd                @"MM-dd"
#define Date_Format1                    @"yyyy/MM/dd EE" //... 周二
#define Date_Format2                    @"yyyy/MM/dd EEEE" //... 星期三
#define Date_Format3                    @"yyyy/MM/dd"
#define Date_Format_Chinese_MMdd        @"MM月dd日"

#define Default_Date_Time_Format        @"yyyy-MM-dd hh:mm:ss"//12小时制
#define Date_Time_Format1               @"yyyy-MM-dd HH:mm"//24小时制

#define Default_Time_Format             @"hh:mm:ss"
#define Time_Format1                    @"hh:mm" //12-hour
#define Time_Format2                    @"HH:mm" //24-hour

//Date parts
typedef NS_ENUM(NSInteger, NSDateCompareMode) {
    NSDatePart  = 0x01,
    NSTimePart  = 0x10
} ;

//Range mode. Used to check if a date is in some range
typedef NS_ENUM(NSInteger, NSDateRangeMode) {
    NSDateRangeClosed,      //closed interval                   <=> []
    NSDateRangeOpen,        //open interval                     <=> ()
    NSDateRangeLeftClosed,  //Left-closed right-open interval   <=> [)
    NSDateRangeRightClosed  //Left-open right-closed interval   <=> (]
} ;

typedef struct {
    NSInteger year;
    NSInteger month;
    NSInteger day;
    NSInteger hour;
    NSInteger minute;
    NSInteger second;
    NSInteger days;
    NSInteger weekday;
} NSDateInfo;

/**
 * 日历的第一天是周日，还是周一
 */
typedef NS_ENUM(NSInteger, EnumStartDay) {
    kStartSunday = 1,
    kStartMonday = 2,
};

@interface NSDate (BFDateParts)

@property (nonatomic, readonly) NSInteger year;

@property (nonatomic, readonly) NSInteger month;

@property (nonatomic, readonly) NSInteger day;

@property (nonatomic, readonly) NSInteger hour;

@property (nonatomic, readonly) NSInteger minute;

@property (nonatomic, readonly) NSInteger second;

@property (nonatomic, readonly) NSInteger days;

@property (nonatomic, readonly) NSInteger weekday;

@end


@interface NSDate (BFDateCompare)

//判断date和当前实例是否是同一天
- (BOOL)isSameDay:(NSDate *)date;

//比较日期的日期部分、时间部分或日期和时间部分
- (NSComparisonResult)compare:(NSDate *)other mode:(NSDateCompareMode)mode;

//检查日期是否出于某个日期范围内
- (BOOL)betweensDate:(NSDate *)date1 andDate:(NSDate *)date2 mode:(NSDateCompareMode)mode range:(NSDateRangeMode)range;

@end


@interface NSDate (BFCalculation)

/*
 日期计算
 */

//计算当前实例距离指定 日期的天数，正数表示在指定日期之后，负数表示在指定日期之前
- (NSInteger)timeIntervalInDaysSinceDate:(NSDate *)date;

//计算当前实例距离当前日期的天数，正数表示在当前日期之后，负数表示在当前日期之前
- (NSInteger)timeIntervalInDaysSinceNow;

//计算month个月后的日期 比如当前日期是 2013年12月12日，得到结果为 2014年1月12日
- (NSDate *)dateAfterMonth:(int)month;
@end


@interface NSDate (BFGeneration)

/*
 日期创建
 */

//获取当前日期所在月份的第一天日期
- (NSDate *)getFirstDayDate;

- (NSDate *)getLastDayDate;

- (NSDate *)dateByAddingDays:(NSInteger)days;

+ (NSArray *)datesBetweenDate:(NSDate *)date1 andDate:(NSDate *)date2 range:(NSDateRangeMode)range;

+ (NSDate *)dateFromDateInfo:(NSDateInfo)dateInfo;

- (NSDateInfo)dateInfo;

//根据字符串和日期格式来构造日期对象，使用当前系统时区
+ (NSDate *)dateFromNSString:(NSString *)string withFormat:(NSString *)format;

+ (NSDate *)dateFromNSString:(NSString *)string withFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone;

//- (NSString*)getChineseWeekStringWithStartDay:(EnumStartDay)enumStartDay;

@end


@interface NSDate (BFFormat)

/*
 日期格式化
 
 Format: 日期格式仅仅是影响日期各分量的具体呈现方式
 
 Locale：日期的格式会根据Locale来调整以适应当地的阅读习惯，基本是改变各日期分量的排放位置
 
 TimeZone: 表示日期所属时区
 */

- (NSString *)toNSString:(NSString *)format locale:(NSLocale *)locale timeZone:(NSTimeZone *)zone;

- (NSString *)toNSString:(NSString *)format;

@end