//
//  NSDate-TKExtensions.h
//  Pure
//
//  Created by Tomek K on 8/15/12.
//  Copyright (c) 2012 Creadhoc Sp. z.o.o www.creadhoc.pl  , Tomasz Kuzma (mapedd@mapedd.com). All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (TKExtensions)

- (NSString *)TKHourAndMinutes;

- (NSString *)TKPolishNotationDate;

- (NSString *)TKDateDayMonthNameYear;

- (NSString *)TKPolishInvertedNotationDate;

- (NSInteger)TKRealWeekday;

+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day
                    hour:(NSInteger)hour
                  minute:(NSInteger)minute
                  second:(NSInteger)second;

+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day;

- (NSString *)TKISO8601String;

- (NSString *)TKDateTimeString;

- (NSString *)TKYearDashMonthDashDay;


- (NSDate *)TKDateByAddingSeconds:(NSInteger)seconds;

- (NSDate *)TKDateBySubtractingSeconds:(NSInteger)seconds;

- (NSDate *)TKDateByAddingMinutes:(NSInteger)minutes;

- (NSDate *)TKDateBySubtractingMinutes:(NSInteger)minutes;

- (NSDate *)TKDateByAddingHours:(NSInteger)hours;

- (NSDate *)TKDateBySubtractingHours:(NSInteger)hours;

- (NSDate *)TKDateByAddingDays:(NSInteger)days;

- (NSDate *)TKDateBySubtractingDays:(NSInteger)days;

- (NSDate *)TKDateByAddingWeeks:(NSInteger)weeks;

- (NSDate *)TKDateBySubtractingWeeks:(NSInteger)weeks;

- (NSDate *)TKDateByAddingMonths:(NSInteger)months;

- (NSDate *)TKDateBySubtractingMonths:(NSInteger)months;

- (NSDate *)TKDateByAddingYears:(NSInteger)years;

- (NSDate *)TKDateBySubtractingYears:(NSInteger)years;


- (NSInteger)TKAgeInFullYears;

- (NSInteger)TKYear;

- (NSInteger)TKMonth;

- (NSInteger)TKDay;

- (NSInteger)TKHour;

- (NSInteger)TKMinute;

- (BOOL)isEarlierThanDate:(NSDate *)aDate;

- (BOOL)isLaterThanDate:(NSDate *)aDate;

- (NSInteger)minutesAfterDate:(NSDate *)aDate;

- (NSString *)localDescription;

/* Begining/End of the unit */


- (NSDate *)TKDateByMovingToBeginningOfDay;

- (NSDate *)TKDateByMovingToEndOfDay;


- (NSDate *)TKDateByMovingToBeginningOfTheMonth;

- (NSDate *)TKDateByMovingToEndOfTheMonth;


- (NSDate *)TKDateByMovingToBeginningOfTheYear;

- (NSDate *)TKDateByMovingToEndOfTheYear;



- (NSInteger)TKDaysBetweenDate:(NSDate *)date;



- (BOOL)isToday;

- (BOOL)isSunday;

- (BOOL)isSaturday;



- (BOOL)daysAreTheSame:(NSDate *)date;

- (BOOL)weeksAreTheSame:(NSDate *)date;

- (BOOL)monthsAreTheSame:(NSDate *)date;

- (BOOL)yearsAreTheSame:(NSDate *)date;

/* Assuming object is earlier than date */
- (NSDate *)centerBetweenDate:(NSDate *)date;

@end



@interface NSDate (TKExtensionsCachedCalednar)

- (NSDate *)TKDateByAddingSeconds:(NSInteger)seconds withCalendar:(NSCalendar *)calendar;

- (NSDate *)TKDateBySubtractingSeconds:(NSInteger)seconds withCalendar:(NSCalendar *)calendar;


- (NSDate *)TKDateByAddingMinutes:(NSInteger)minutes withCalendar:(NSCalendar *)calendar;

- (NSDate *)TKDateBySubtractingMinutes:(NSInteger)minutes withCalendar:(NSCalendar *)calendar;


- (NSDate *)TKDateByAddingHours:(NSInteger)hours withCalendar:(NSCalendar *)calendar;

- (NSDate *)TKDateBySubtractingHours:(NSInteger)hours withCalendar:(NSCalendar *)calendar;


- (NSDate *)TKDateByAddingDays:(NSInteger)days withCalendar:(NSCalendar *)calendar;

- (NSDate *)TKDateBySubtractingDays:(NSInteger)days withCalendar:(NSCalendar *)calendar;


- (NSDate *)TKDateByAddingWeeks:(NSInteger)weeks withCalendar:(NSCalendar *)calendar;

- (NSDate *)TKDateBySubtractingWeeks:(NSInteger)weeks withCalendar:(NSCalendar *)calendar;


- (NSDate *)TKDateByAddingMonths:(NSInteger)months withCalendar:(NSCalendar *)calendar;

- (NSDate *)TKDateBySubtractingMonths:(NSInteger)months withCalendar:(NSCalendar *)calendar;


- (NSDate *)TKDateByAddingYears:(NSInteger)years withCalendar:(NSCalendar *)calendar;

- (NSDate *)TKDateBySubtractingYears:(NSInteger)years withCalendar:(NSCalendar *)calendar;


- (NSDate *)TKDateByMovingToBeginningOfDayWithCalendar:(NSCalendar *)calendar;

- (NSDate *)TKDateByMovingToEndOfDayWithCalendar:(NSCalendar *)calendar;


- (NSDate *)TKDateByMovingToBeginningOfTheMonthWithCalendar:(NSCalendar *)calendar;

- (NSDate *)TKDateByMovingToEndOfTheMonthWithCalendar:(NSCalendar *)calendar;


- (NSDate *)TKDateByMovingToBeginningOfTheYearWithCalendar:(NSCalendar *)calendar;

- (NSDate *)TKDateByMovingToEndOfTheYearWithCalendar:(NSCalendar *)calendar;



- (NSInteger)TKYearWithCalendar:(NSCalendar *)calendar;

- (NSInteger)TKMonthWithCalendar:(NSCalendar *)calendar;

- (NSInteger)TKDayWithCalendar:(NSCalendar *)calendar;

- (NSInteger)TKHourWithCalendar:(NSCalendar *)calendar;

- (NSInteger)TKMinuteWithCalendar:(NSCalendar *)calendar;


- (BOOL)daysAreTheSame:(NSDate *)date withCalendar:(NSCalendar *)calendar;

- (BOOL)weeksAreTheSame:(NSDate *)date withCalendar:(NSCalendar *)calendar;

- (BOOL)monthsAreTheSame:(NSDate *)date withCalendar:(NSCalendar *)calendar;

- (BOOL)yearsAreTheSame:(NSDate *)date withCalendar:(NSCalendar *)calendar;


- (NSInteger)TKDaysBetweenDate:(NSDate *)date withCalendar:(NSCalendar *)calendar;

@end