//
//  MPCalendarHelper.m
//  Jewarator
//
//  Created by Michail on 10.06.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "MPCalendarHelper.h"

@implementation MPCalendarHelper


- (NSPredicate *)periodInterval:(MPPeriodType)interval{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:( NSCalendarUnitMonth  | NSCalendarUnitDay | NSCalendarUnitWeekday ) fromDate:[NSDate date]];
    //create a date with these components
//    NSDate *startDate = [calendar dateFromComponents:components];
    NSDate *startDate = [NSDate date];
    components.day = 0;
    components.month = 0;
    components.weekday = 0;
    switch (interval) {
        case MPDay:
            [components setDay:-1];
            break;
        case MPWeek:
            [components setWeekOfMonth:-1];
            break;
        case MPMonth:
            [components setMonth:-1];
            break;
        default:
            break;
    }
    NSDate *endDate = [calendar dateByAddingComponents:components toDate:startDate options:0];
    return [NSPredicate predicateWithFormat:@"((trans_time >= %@) AND (trans_time < %@))",endDate,startDate];
}

- (NSArray *)getPeriodsName{
    NSArray *array = [NSArray arrayWithObjects:@"Day",
                      @"Week",@"Month",nil];
    return array;
}

@end
