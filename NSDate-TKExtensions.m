//
//  NSDate-TKExtensions.m
//  Pure
//
//  Created by Tomek K on 8/15/12.
//  Copyright (c) 2012 Creadhoc Sp. z.o.o www.creadhoc.pl  , Tomasz Kuzma (mapedd@mapedd.com). All rights reserved.
//

#import "NSDate-TKExtensions.h"

#define ISO_TIMEZONE_UTC_FORMAT @"Z"
#define ISO_TIMEZONE_OFFSET_FORMAT @"%+02d%02d"


#define SECS_MINUTE	60
#define SECS_HOUR	3600
#define SECS_DAY	86400
#define SECS_WEEK	604800
#define SECS_YEAR	31556926

@implementation NSDate (TKExtensions)

- (NSString *)TKHourAndMinutes{
    
    NSInteger hour = [self TKHour];
    NSInteger minute = [self TKMinute];
    
    return [NSString stringWithFormat:@"%@%d:%@%d",
            hour > 9 ? @"" : @"0",
            hour,
            minute > 9 ? @"" : @"0",
            minute
            ];
}

- (NSString *)TKDateDayMonthNameYear{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateStyle:kCFDateFormatterLongStyle];
    //    [df setDateFormat:@"dd MM yyyy"];
    [df setCalendar:[NSCalendar currentCalendar]];
    [df setTimeZone:[NSTimeZone localTimeZone]];
    
    return [df stringFromDate:self];
}

- (NSString *)TKPolishNotationDate{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy.MM.dd"];
    [df setCalendar:[NSCalendar currentCalendar]];
    [df setTimeZone:[NSTimeZone localTimeZone]];
    
    return [df stringFromDate:self];
}

- (NSString *)TKPolishInvertedNotationDate{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd.MM.yyyy"];
    [df setCalendar:[NSCalendar currentCalendar]];
    [df setTimeZone:[NSTimeZone localTimeZone]];
    
    return [df stringFromDate:self];
}

- (NSInteger)TKRealWeekday{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:self];
    
    NSInteger weekday = [weekdayComponents weekday];
    
    NSInteger realWeekday = weekday - 1;
    
    if (realWeekday==0) {
        realWeekday = 7;
    }
    
    return realWeekday;
}


+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day
                    hour:(NSInteger)hour
                  minute:(NSInteger)minute
                  second:(NSInteger)second{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *systemTimeZone = [NSTimeZone systemTimeZone];
    
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    [dateComps setCalendar:gregorian];
    [dateComps setYear:year];
    [dateComps setMonth:month];
    [dateComps setDay:day];
    [dateComps setTimeZone:systemTimeZone];
    [dateComps setHour:hour];
    [dateComps setMinute:minute];
    [dateComps setSecond:second];
    
    
    return [dateComps date];
}

+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day{
    return [NSDate dateWithYear:year month:month day:day hour:0 minute:0 second:0];
}

- (NSString *)TKISO8601String{
    /*
     Source: http://www.radupoenaru.com/processing-nsdate-into-an-iso8601-string/
     */
    static NSDateFormatter* sISO8601 = nil;
    
    if (!sISO8601) {
        sISO8601 = [[NSDateFormatter alloc] init];
        
        NSTimeZone *timeZone = [NSTimeZone localTimeZone];
        int offset = [timeZone secondsFromGMT];
        
        NSMutableString *strFormat = [NSMutableString stringWithString:@"yyyyMMdd'T'HH:mm:ss"];
        offset /= 60; //bring down to minutes
        if (offset == 0)
            [strFormat appendString:ISO_TIMEZONE_UTC_FORMAT];
        else
            [strFormat appendFormat:ISO_TIMEZONE_OFFSET_FORMAT, offset / 60, offset % 60];
        
        [sISO8601 setTimeStyle:NSDateFormatterFullStyle];
        [sISO8601 setDateFormat:strFormat];
    }
    return[sISO8601 stringFromDate:self];
}

- (NSString *)TKDateTimeString{
    
    return @"Date(1320476364000+0100)";
}

- (NSString*)TKYearDashMonthDashDay{
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    [df setTimeZone:[NSTimeZone localTimeZone]];
    
    return [df stringFromDate:self];
}

#pragma mark - Adding/Subtracting

- (NSDate *)TKDateByAddingSeconds:(NSInteger)seconds{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [comps setSecond:seconds];
    
    NSDate *newDate = [calendar dateByAddingComponents:comps toDate:self options:0];
    
    return newDate;
}

- (NSDate *)TKDateBySubtractingSeconds:(NSInteger)seconds{
    return [self TKDateByAddingSeconds:-seconds];
}

- (NSDate *)TKDateByAddingMinutes:(NSInteger)minutes{
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [comps setMinute:minutes];
    
    NSDate *newDate = [calendar dateByAddingComponents:comps toDate:self options:0];
    
    return newDate;
}

- (NSDate *)TKDateBySubtractingMinutes:(NSInteger)minutes{
    return [self TKDateByAddingMinutes:-minutes];
}

- (NSDate *)TKDateByAddingHours:(NSInteger)hours{
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [comps setHour:hours];
    
    NSDate *newDate = [calendar dateByAddingComponents:comps toDate:self options:0];
    
    return newDate;
}

- (NSDate *)TKDateBySubtractingHours:(NSInteger)hours{
    return [self TKDateByAddingHours:-hours];
}

- (NSDate *)TKDateByAddingDays:(NSInteger)days{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [comps setDay:days];
    
    NSDate *newDate = [calendar dateByAddingComponents:comps toDate:self options:0];
    
    return newDate;
}

- (NSDate *)TKDateBySubtractingDays:(NSInteger)days{
    return [self TKDateByAddingDays:-days];
}

- (NSDate *)TKDateByAddingWeeks:(NSInteger)weeks{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [comps setWeek:weeks];
    
    NSDate *newDate = [calendar dateByAddingComponents:comps toDate:self options:0];
    
    return newDate;
}

- (NSDate *)TKDateBySubtractingWeeks:(NSInteger)weeks{
    return [self TKDateByAddingWeeks:-weeks];
}

- (NSDate *)TKDateByAddingMonths:(NSInteger)months{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [comps setMonth:months];
    
    NSDate *newDate = [calendar dateByAddingComponents:comps toDate:self options:0];
    
    return newDate;
}

- (NSDate *)TKDateBySubtractingMonths:(NSInteger)months{
    return [self TKDateByAddingMonths:-months];
}

- (NSDate *)TKDateByAddingYears:(NSInteger)years{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [comps setYear:years];
    
    NSDate *newDate = [calendar dateByAddingComponents:comps toDate:self options:0];
    
    return newDate;
}

- (NSDate *)TKDateBySubtractingYears:(NSInteger)years{
    return [self TKDateByAddingYears:-years];
}


- (NSInteger)TKAgeInFullYears{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
	int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:self toDate:[NSDate date] options:0];
    
    NSInteger yearsSinceBirth = [comps year];
    
    
    return yearsSinceBirth;
}


- (NSInteger)TKYear{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:self];
    return [dateComponents year];
}

- (NSInteger)TKMonth{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit fromDate:self];
    return [dateComponents month];
}

- (NSInteger)TKDay{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit fromDate:self];
    return [dateComponents day];
}

- (NSInteger)TKHour{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSHourCalendarUnit fromDate:self];
    return [dateComponents hour];
}

- (NSInteger)TKMinute{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSMinuteCalendarUnit fromDate:self];
    return [dateComponents minute];
}

- (BOOL) isEarlierThanDate: (NSDate *) aDate{
	return ([self earlierDate:aDate] == self);
}

- (BOOL) isLaterThanDate: (NSDate *) aDate{
	return ([self laterDate:aDate] == self);
}

- (NSInteger) minutesAfterDate: (NSDate *) aDate{
	NSTimeInterval interval = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (interval / SECS_MINUTE);
}

- (NSString *)localDescription{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy, H:mm ,EEEE, LLLL"];
    [dateFormatter setCalendar:[NSCalendar currentCalendar]];
    return [dateFormatter stringFromDate:self];
}



- (NSDate *)TKDateByMovingToBeginningOfDay{
    NSDateComponents* parts = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    [parts setHour:0];
    [parts setMinute:0];
    [parts setSecond:0];
    
    return [[NSCalendar currentCalendar] dateFromComponents:parts];
}

- (NSDate *)TKDateByMovingToEndOfDay{
    NSDateComponents* parts = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    [parts setHour:23];
    [parts setMinute:59];
    [parts setSecond:59];
    
    return [[NSCalendar currentCalendar] dateFromComponents:parts];
}


- (NSDate *)TKDateByMovingToBeginningOfTheMonth{
    NSDateComponents* parts = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    
    [parts setDay:1];
    [parts setHour:0];
    [parts setMinute:0];
    [parts setSecond:0];
    
    return [[NSCalendar currentCalendar] dateFromComponents:parts];
}

- (NSDate *)TKDateByMovingToEndOfTheMonth{
    
    NSDateComponents* parts = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    
    [parts setMonth:[parts month]+1];
    [parts setDay:0];
    [parts setHour:23];
    [parts setMinute:59];
    [parts setSecond:59];
    
    return [[NSCalendar currentCalendar] dateFromComponents:parts];
}


- (NSDate *)TKDateByMovingToBeginningOfTheYear{
    NSDateComponents* parts = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    
    [parts setDay:1];
    [parts setHour:0];
    [parts setMinute:0];
    [parts setSecond:0];
    [parts setMonth:1];
    
    return [[NSCalendar currentCalendar] dateFromComponents:parts];
}

- (NSDate *)TKDateByMovingToEndOfTheYear{
    
    NSDate *firstDayNextYear = [[self TKDateByMovingToBeginningOfTheYear] TKDateByAddingYears:1];
    NSDate *lastDayThisYear = [firstDayNextYear TKDateBySubtractingDays:1];
    return [lastDayThisYear TKDateByMovingToEndOfDay];
}



- (NSInteger)TKDaysBetweenDate:(NSDate *)date{
    return [self timeIntervalSinceDate:date] / (60 * 60 * 24);
}



- (BOOL)isToday{
    NSDate *today = [NSDate date];
    return [self daysAreTheSame:today];
    
}

- (BOOL)isSunday{
    return self.TKRealWeekday == 7;
}

- (BOOL)isSaturday{
    return self.TKRealWeekday == 6;
}



- (BOOL)daysAreTheSame:(NSDate *)date{

    NSDateComponents *selfDateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:self];
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];

    return (dateComponents.year == selfDateComponents.year) && (dateComponents.month == selfDateComponents.month) && (dateComponents.day == selfDateComponents.day);
}

- (BOOL)weeksAreTheSame:(NSDate *)date{
    NSDateComponents *selfDateComponents = [[NSCalendar currentCalendar] components:NSWeekCalendarUnit fromDate:self];
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSWeekCalendarUnit fromDate:date];
    
    return (dateComponents.week == selfDateComponents.week);
}

- (BOOL)monthsAreTheSame:(NSDate *)date{
    NSDateComponents *selfDateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:date];
    
    return (dateComponents.year == selfDateComponents.year) && (dateComponents.month == selfDateComponents.month);
}

- (BOOL)yearsAreTheSame:(NSDate *)date{
    
    NSDateComponents *selfDateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:date];
    
    return (dateComponents.year == selfDateComponents.year);
}


- (NSDate *)centerBetweenDate:(NSDate *)date{
    return [self dateByAddingTimeInterval:[date timeIntervalSinceDate:self]/ 2];
}

@end


@implementation NSDate (TKExtensionsCachedCalednar)

- (NSDate *)TKDateByAddingUnit:(NSInteger)unit unitType:(NSCalendarUnit)unitType withCalendar:(NSCalendar *)calendar{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    switch (unitType) {
        case NSSecondCalendarUnit:
            [comps setSecond:unit];
            break;
        case NSMinuteCalendarUnit:
            [comps setMinute:unit];
            break;
        case NSHourCalendarUnit:
            [comps setHour:unit];
            break;
        case NSDayCalendarUnit:
            [comps setDay:unit];
            break;
        case NSMonthCalendarUnit:
            [comps setMonth:unit];
            break;
        case NSYearCalendarUnit:
            [comps setYear:unit];
            break;
        default:
            return nil;
            break;
    }
    
    return [calendar dateByAddingComponents:comps toDate:self options:0];
}


- (NSDate *)TKDateByAddingSeconds:(NSInteger)seconds withCalendar:(NSCalendar *)calendar{
    return [self TKDateByAddingUnit:seconds unitType:NSSecondCalendarUnit withCalendar:calendar];
}

- (NSDate *)TKDateBySubtractingSeconds:(NSInteger)seconds withCalendar:(NSCalendar *)calendar{
    return [self TKDateByAddingSeconds:-seconds withCalendar:calendar];
}


- (NSDate *)TKDateByAddingMinutes:(NSInteger)minutes withCalendar:(NSCalendar *)calendar{
    return [self TKDateByAddingUnit:minutes unitType:NSMinuteCalendarUnit withCalendar:calendar];
}

- (NSDate *)TKDateBySubtractingMinutes:(NSInteger)minutes withCalendar:(NSCalendar *)calendar{
    return [self TKDateByAddingMinutes:-minutes withCalendar:calendar];
}


- (NSDate *)TKDateByAddingHours:(NSInteger)hours withCalendar:(NSCalendar *)calendar{
    return [self TKDateByAddingUnit:hours unitType:NSHourCalendarUnit withCalendar:calendar];
}

- (NSDate *)TKDateBySubtractingHours:(NSInteger)hours withCalendar:(NSCalendar *)calendar{
    return [self TKDateByAddingHours:-hours withCalendar:calendar];
}


- (NSDate *)TKDateByAddingDays:(NSInteger)days withCalendar:(NSCalendar *)calendar{
    return [self TKDateByAddingUnit:days unitType:NSDayCalendarUnit withCalendar:calendar];
}

- (NSDate *)TKDateBySubtractingDays:(NSInteger)days withCalendar:(NSCalendar *)calendar{
    return [self TKDateByAddingDays:-days withCalendar:calendar];
}


- (NSDate *)TKDateByAddingWeeks:(NSInteger)weeks withCalendar:(NSCalendar *)calendar{
    return [self TKDateByAddingUnit:7 * weeks unitType:NSDayCalendarUnit withCalendar:calendar];
}

- (NSDate *)TKDateBySubtractingWeeks:(NSInteger)weeks withCalendar:(NSCalendar *)calendar{
    return [self TKDateByAddingWeeks:-weeks withCalendar:calendar];
}


- (NSDate *)TKDateByAddingMonths:(NSInteger)months withCalendar:(NSCalendar *)calendar{
    return [self TKDateByAddingUnit:months unitType:NSMonthCalendarUnit withCalendar:calendar];
}

- (NSDate *)TKDateBySubtractingMonths:(NSInteger)months withCalendar:(NSCalendar *)calendar{
    return [self TKDateByAddingMonths:-months withCalendar:calendar];
}


- (NSDate *)TKDateByAddingYears:(NSInteger)years withCalendar:(NSCalendar *)calendar{
    return [self TKDateByAddingUnit:years unitType:NSYearCalendarUnit withCalendar:calendar];
}

- (NSDate *)TKDateBySubtractingYears:(NSInteger)years withCalendar:(NSCalendar *)calendar{
    return [self TKDateByAddingYears:-years withCalendar:calendar];
}

- (NSDate *)TKDateByMovingToBeginningOfDayWithCalendar:(NSCalendar *)calendar{
    NSDateComponents* parts = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    [parts setHour:0];
    [parts setMinute:0];
    [parts setSecond:0];
    
    return [calendar dateFromComponents:parts];
}

- (NSDate *)TKDateByMovingToEndOfDayWithCalendar:(NSCalendar *)calendar{
    NSDateComponents* parts = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    [parts setHour:23];
    [parts setMinute:59];
    [parts setSecond:59];
    
    return [calendar dateFromComponents:parts];
}


- (NSDate *)TKDateByMovingToBeginningOfTheMonthWithCalendar:(NSCalendar *)calendar{
    NSDateComponents* parts = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    
    [parts setDay:1];
    [parts setHour:0];
    [parts setMinute:0];
    [parts setSecond:0];
    
    return [calendar dateFromComponents:parts];
}

- (NSDate *)TKDateByMovingToEndOfTheMonthWithCalendar:(NSCalendar *)calendar{
    NSDateComponents* parts = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    
    [parts setMonth:[parts month]+1];
    [parts setDay:0];
    [parts setHour:23];
    [parts setMinute:59];
    [parts setSecond:59];
    
    return [calendar dateFromComponents:parts];
}


- (NSDate *)TKDateByMovingToBeginningOfTheYearWithCalendar:(NSCalendar *)calendar{
    NSDateComponents* parts = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    
    [parts setDay:1];
    [parts setHour:0];
    [parts setMinute:0];
    [parts setSecond:0];
    [parts setMonth:1];
    
    return [calendar dateFromComponents:parts];
}

- (NSDate *)TKDateByMovingToEndOfTheYearWithCalendar:(NSCalendar *)calendar{
    NSDate *firstDayNextYear = [[self TKDateByMovingToBeginningOfTheYear] TKDateByAddingYears:1];
    NSDate *lastDayThisYear = [firstDayNextYear TKDateBySubtractingDays:1];
    return [lastDayThisYear TKDateByMovingToEndOfDay];
}


- (NSInteger)TKYearWithCalendar:(NSCalendar *)calendar{
    NSDateComponents *dateComponents = [calendar components:NSYearCalendarUnit fromDate:self];
    return [dateComponents year];
}

- (NSInteger)TKMonthWithCalendar:(NSCalendar *)calendar{
    NSDateComponents *dateComponents = [calendar components:NSMonthCalendarUnit fromDate:self];
    return [dateComponents month];
}

- (NSInteger)TKDayWithCalendar:(NSCalendar *)calendar{
    NSDateComponents *dateComponents = [calendar components:NSDayCalendarUnit fromDate:self];
    return [dateComponents day];
}

- (NSInteger)TKHourWithCalendar:(NSCalendar *)calendar{
    NSDateComponents *dateComponents = [calendar components:NSHourCalendarUnit fromDate:self];
    return [dateComponents hour];
}

- (NSInteger)TKMinuteWithCalendar:(NSCalendar *)calendar{
    NSDateComponents *dateComponents = [calendar components:NSMinuteCalendarUnit fromDate:self];
    return [dateComponents minute];
}


- (BOOL)daysAreTheSame:(NSDate *)date withCalendar:(NSCalendar *)calendar{
    
    NSDateComponents *selfDateComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:self];
    NSDateComponents *dateComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:date];
    
    return (dateComponents.year == selfDateComponents.year) && (dateComponents.month == selfDateComponents.month) && (dateComponents.day == selfDateComponents.day);
}

- (BOOL)weeksAreTheSame:(NSDate *)date withCalendar:(NSCalendar *)calendar{
    NSDateComponents *selfDateComponents = [calendar components:NSWeekCalendarUnit fromDate:self];
    NSDateComponents *dateComponents = [calendar components:NSWeekCalendarUnit fromDate:date];
    
    return (dateComponents.week == selfDateComponents.week);
}

- (BOOL)monthsAreTheSame:(NSDate *)date withCalendar:(NSCalendar *)calendar{
    NSDateComponents *selfDateComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
    NSDateComponents *dateComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:date];
    
    return (dateComponents.year == selfDateComponents.year) && (dateComponents.month == selfDateComponents.month);
}

- (BOOL)yearsAreTheSame:(NSDate *)date withCalendar:(NSCalendar *)calendar{
    
    NSDateComponents *selfDateComponents = [calendar components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *dateComponents = [calendar components:NSYearCalendarUnit fromDate:date];
    
    return (dateComponents.year == selfDateComponents.year);
}



- (NSInteger)TKDaysBetweenDate:(NSDate *)date withCalendar:(NSCalendar *)calendar{
    NSDateComponents *dateComponents = [calendar components:NSDayCalendarUnit
                                                   fromDate:date
                                                     toDate:self
                                                    options:0];
    return [dateComponents day];
}

@end