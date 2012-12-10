//
//  main.m
//  NSDateExample
//
//  Created by Tomasz Kuźma on 10/9/12.
//  Copyright (c) 2012 mapedd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSDate-TKExtensions.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSDate *date1 = [NSDate dateWithYear:2012 month:10 day:9 hour:12 minute:0 second:0];
        NSDate *date2 = [NSDate dateWithYear:2012 month:10 day:10 hour:12 minute:0 second:0];
        NSInteger dayDiff = [date2 TKDaysBetweenDate:date1];
        
        /* We are using C Assertion, ObjC assertion can't be used inside functions */
        NSCAssert(dayDiff == 1, @"day diff should be 1");
        
        NSDate *date3 = [NSDate dateWithYear:2012 month:11 day:23 hour:12 minute:12 second:12];
        NSDate *date4 = [NSDate dateWithYear:2012 month:10 day:23 hour:12 minute:12 second:12];
        
        NSDate *novStart = [date3 TKDateByMovingToBeginningOfTheMonth];
        NSDate *octEnd = [date4 TKDateByMovingToEndOfTheMonth];
        
        NSCAssert([novStart TKDay] == 1 && [novStart TKMonth] == 11, @"first day is 1");
        NSCAssert([octEnd TKDay] == 31 && [octEnd TKMonth] == 10, @"first day is 1");
        
        NSDate *date5 = [NSDate date];
        NSDate *date6 = [NSDate dateWithYear:date5.TKYear month:date5.TKMonth day:date5.TKDay];
        
        NSCAssert([date5 daysAreTheSame:date6], @"days should be the same");
        
        NSDate *date7 = [NSDate dateWithYear:2012 month:11 day:6 hour:12 minute:0 second:0];
        NSDate *date8 = [NSDate dateWithYear:2012 month:11 day:6 hour:13 minute:0 second:0];
        
        NSDate *center78 = [date7 centerBetweenDate:date8];
        
        NSCAssert(center78.TKHour == 12 && center78.TKMinute == 30, @"12.30 is the correct hour");
        
        NSDate *date9 = [NSDate dateWithYear:2012 month:11 day:6 hour:12 minute:30 second:0];
        
        NSDate *date10 = [date9 TKDateBySubtractingMinutes:30];
        
        NSCAssert(date10.TKHour == 12 && date10.TKMinute == 0, @"12:00 is the proper time");
        
        NSDate *date11 = [date9 TKDateByAddingMinutes:33];
        
        NSCAssert(date11.TKHour == 13 && date11.TKMinute == 3, @"13:03 is the proper time");
        
        NSDate *date12 = [NSDate dateWithYear:2010 month:12 day:12 hour:12 minute:0 second:10];
        
        NSDate *date13 = [date12 TKDateByAddingSeconds:50];
        
        NSCAssert(date13.TKHour == 12 && date13.TKMinute == 1, @"12:01 is the proper time");
        
    }
    return 0;
}

