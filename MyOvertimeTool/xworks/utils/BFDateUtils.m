//
//  BFDateUtils.m
//  OkayappsFrameworkDev
//
//  Created by xiongwei on 14/12/11.
//  Copyright (c) 2015年 okayapps.com. All rights reserved.
//

#import "BFDateUtils.h"
#import "XworksCore.h"

BF_FIX_CATEGORY_BUG(BFDateUtils)

@interface NSDate (BFPrivate)

+ (NSCalendar *)shareCalendar;

+ (NSDateFormatter *)sharedFormatter;

- (NSDateComponents *)dateParts:(NSUInteger)flags;

- (NSTimeInterval)timeIntervalSince1970WithoutTimeParts;

@end

@implementation NSDate (BFPrivate)

+ (NSCalendar *)shareCalendar {
    static NSCalendar * calender = nil;
    
    if (calender == nil) {
        calender = [NSCalendar currentCalendar];
        [calender setFirstWeekday:kStartMonday];
    }
    
    return calender;
}

+ (NSDateFormatter *)sharedFormatter {
    static NSDateFormatter * dateFormatter = nil;
    
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    
    return dateFormatter;
}

+ (NSDateComponents *)shareComponents {
    static NSDateComponents * dateComponents = nil;
    
    if (dateComponents == nil) {
        dateComponents = [[NSDateComponents alloc] init];
    }
    
    return dateComponents;
}

- (NSDateComponents *)dateParts:(NSUInteger)flags
{
    NSDateComponents * comp = [[NSDate shareCalendar] components:flags fromDate:self];
    return comp;
}

- (NSTimeInterval)timeIntervalSince1970WithoutTimeParts {
    return [self timeIntervalSince1970] - self.hour * BFSecondsPerHour - self.minute * BFSecondsPerMinute - self.second;
}

@end

#pragma mark - Date Parts

@implementation NSDate (BFDateParts)

- (NSInteger)year {
    return [self dateParts:NSCalendarUnitYear].year;
}

- (NSInteger)month {
    return [self dateParts:NSCalendarUnitMonth].month;
}

- (NSInteger)day {
    return [self dateParts:NSCalendarUnitDay].day;
}

- (NSInteger)hour {
    return [self dateParts:NSCalendarUnitHour].hour;
}

- (NSInteger)minute {
    return [self dateParts:NSCalendarUnitMinute].minute;
}

- (NSInteger)second {
    return [self dateParts:NSCalendarUnitSecond].second;
}

- (NSInteger)days {
    NSRange days = [[NSDate shareCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return days.length;
}

- (NSInteger)weekday {
    return [self dateParts:NSCalendarUnitWeekday].weekday;
}

@end


#pragma mark - Date Compare

@implementation NSDate (BFDateCompare)

- (BOOL)isSameDay:(NSDate *)date {
    if (date.year == self.year && date.month == self.month && date.day == self.day) {
        return YES;
    }
    
    return NO;
}

- (NSComparisonResult)compare:(NSDate *)other mode:(NSDateCompareMode)mode {
    if ((mode & NSDatePart) && (mode & NSTimePart)) {
        return [self compare:other];
    } else if (mode & NSDatePart) {
        NSTimeInterval selfInterval = [self timeIntervalSince1970];
        NSTimeInterval otherInterval = [other timeIntervalSince1970];
        
        NSInteger s = BFSecondsPerDay;
        NSInteger selfDays = selfInterval / s;
        NSInteger otherDays = otherInterval / s;
        
        if (selfDays > otherDays) {
            return NSOrderedDescending;
        } else if (selfDays == otherDays) {
            return NSOrderedSame;
        } else {
            return NSOrderedAscending;
        }
    } else if (mode & NSTimePart) {
        NSInteger selfSeconds = self.hour * BFSecondsPerHour + self.minute*BFSecondsPerMinute + self.second;
        NSInteger otherSeconds = other.hour * BFSecondsPerHour + other.minute * BFSecondsPerMinute + other.second;
        
        if (selfSeconds > otherSeconds) {
            return NSOrderedDescending;
        } else if (selfSeconds == otherSeconds) {
            return NSOrderedSame;
        } else {
            return NSOrderedAscending;
        }
    }
    
    @throw [NSException
            exceptionWithName:@"InvalidDateCompareMode"
            reason:[NSString stringWithFormat:@"No such date compare mode %d", (int)mode]
            userInfo:nil];
}

- (BOOL)betweensDate:(NSDate *)date1 andDate:(NSDate *)date2 mode:(NSDateCompareMode)mode range:(NSDateRangeMode)range {
    NSComparisonResult result1 = [self compare:date1 mode:mode];
    NSComparisonResult result2 = [self compare:date2 mode:mode];
    
    if (range == NSDateRangeClosed) {
        if (LaterThanOrEqualTo(result1) && EarlierThanOrEqualTo(result2)) {
            return YES;
        }
        return NO;
    } else if (range == NSDateRangeOpen) {
        if (LaterThan(result1) && EarlierThan(result2)) {
            return YES;
        }
        
        return NO;
    } else if (range == NSDateRangeLeftClosed) {
        if (LaterThanOrEqualTo(result1) && EarlierThan(result2)) {
            return YES;
        }
        
        return NO;
    } else if (range == NSDateRangeRightClosed) {
        if (LaterThan(result1) && EarlierThanOrEqualTo(result2)) {
            return YES;
        }
        
        return NO;
    }
    
    @throw [NSException
            exceptionWithName:@"InvalidDateRangeMode"
            reason:[NSString stringWithFormat:@"No such date range mode %d", (int)range]
            userInfo:nil];
}

@end


#pragma mark - Date Calculation

@implementation NSDate (BFCalculation)

- (NSInteger)timeIntervalInDaysSinceDate:(NSDate *)date {
    NSTimeInterval interval1 = [self timeIntervalSince1970WithoutTimeParts];
    NSTimeInterval interval2 = [date timeIntervalSince1970WithoutTimeParts];
    
    NSTimeInterval interval = floor(interval1) - floor(interval2);
    return interval/60/60/24;
}

- (NSInteger)timeIntervalInDaysSinceNow {
    return [self timeIntervalInDaysSinceDate:[NSDate date]];
}

- (NSDate *)dateAfterMonth:(int)month {
    
    NSDateComponents *componentsToAdd = [NSDate shareComponents];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [[NSDate shareCalendar] dateByAddingComponents:componentsToAdd toDate:self options:0];
    
    return dateAfterMonth;
}

@end



#pragma mark - Date Generation

@implementation NSDate (BFGeneration)

- (NSDate *)getFirstDayDate
{
    return [NSDate dateFromNSString:[NSString stringWithFormat:@"%d-%02d-01",(int)self.year,(int)self.month] withFormat:Date_Format_yyyyMMdd];
}
- (NSDate *)getLastDayDate
{
    NSDate *nextMonth = [NSDate dateFromNSString:[NSString stringWithFormat:@"%d-%02d-01",(int)self.year,(int)(self.month+1)] withFormat:Date_Format_yyyyMMdd];
    return [nextMonth dateByAddingTimeInterval:-24*60*60];
}

- (NSDate *)dateByAddingDays:(NSInteger)days {
    NSTimeInterval interval = (NSTimeInterval)BFSecondsPerDay*(NSTimeInterval)days;
    return [self dateByAddingTimeInterval:interval];
}

+ (NSArray *)datesBetweenDate:(NSDate *)date1 andDate:(NSDate *)date2 range:(NSDateRangeMode)range {
    //如果传入的日期大小不正确，调整大小
    NSDate * startDate = nil;
    NSDate * endDate = nil;
    
    if ([date1 earlierDate:date2] == date1) {
        startDate = date1;
        endDate = date2;
    } else {
        startDate = date2;
        endDate = date1;
    }
    
    NSMutableArray * dates = [NSMutableArray array];
    
    if (range == NSDateRangeClosed || range == NSDateRangeLeftClosed) {
        [dates addObject:startDate];
    }
    
    NSDate * nextDay = [startDate dateByAddingDays:1];
    while (![nextDay isSameDay:endDate] && [nextDay earlierDate:endDate] != endDate) {
        [dates addObject:nextDay];
        nextDay = [nextDay dateByAddingDays:1];
    }
    
    if (![startDate isSameDay:endDate]) {
        if (range == NSDateRangeClosed || range == NSDateRangeRightClosed) {
            [dates addObject:endDate];
        }
    }
    
    return [NSArray arrayWithArray:dates];
}

+ (NSDate *)dateFromDateInfo:(NSDateInfo)dateInfo {
    NSDateComponents * comps = [[NSDateComponents alloc] init];
    comps.year = dateInfo.year;
    comps.month = dateInfo.month;
    comps.day = dateInfo.day;
    comps.hour = dateInfo.hour;
    comps.minute = dateInfo.minute;
    comps.second = dateInfo.second;
    
    return [[NSDate shareCalendar] dateFromComponents:comps];
}

- (NSDateInfo)dateInfo {
    NSUInteger flag = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps = [[NSDate shareCalendar] components:flag fromDate:self];
    NSDateInfo  dateInfo;
    dateInfo.year = comps.year;
    dateInfo.month = comps.month;
    dateInfo.day = comps.day;
    dateInfo.hour = comps.hour;
    dateInfo.minute = comps.minute;
    dateInfo.second = comps.second;
    
    return dateInfo;
}

+ (NSDate *)dateFromNSString:(NSString *)string withFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone {
    NSDateFormatter * fmt = [NSDate sharedFormatter];
    [fmt setDateFormat:format];
    if (timeZone != nil) {
        fmt.timeZone = timeZone;
    }
    NSDate * date = [fmt dateFromString:string];
    return date;
}

+ (NSDate *)dateFromNSString:(NSString *)string withFormat:(NSString *)format {
    return [self dateFromNSString:string withFormat:format timeZone:[NSTimeZone systemTimeZone]];
}

@end



#pragma mark - Date Formatting

@implementation NSDate (BFFormat)

- (NSString *)toNSString:(NSString *)format locale:(NSLocale *)locale timeZone:(NSTimeZone *)zone {
    NSDateFormatter * fmt = [NSDate sharedFormatter];
    
    if (locale != nil) {
        fmt.locale = locale;
    }
    
    if (zone != nil) {
        fmt.timeZone = zone;
    }
    
    [fmt setDateFormat:format];
    NSString* strDate = [fmt stringFromDate:self];
    return strDate;
}

- (NSString *)toNSString:(NSString *)format {
    return [self toNSString:format locale:[NSLocale systemLocale] timeZone:[NSTimeZone systemTimeZone]];
}

@end