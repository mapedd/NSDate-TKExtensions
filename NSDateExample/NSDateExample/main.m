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

        
        pause();
    }
    return 0;
}

