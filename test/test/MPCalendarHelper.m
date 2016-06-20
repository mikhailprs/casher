//
//  MPCalendarHelper.m
//  Jewarator
//
//  Created by Michail on 10.06.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "MPCalendarHelper.h"
#import "Earning+CoreDataProperties.h"
#import "AppDelegate.h"
#import "NSManagedObjectContext+SRFetchAsync.h"

@interface MPCalendarHelper ()

@property (strong, nonatomic) NSDate *lastEarnDate;

@end

@implementation MPCalendarHelper



- (instancetype)init{
    self = [super init];
    if (self){
        [self getLastEarndate];
    }
    return self;
}

- (NSPredicate *)periodInterval:(MPPeriodType)interval{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:( NSCalendarUnitMonth  | NSCalendarUnitDay | NSCalendarUnitWeekday ) fromDate:[NSDate date]];
    //create a date with these components
//    NSDate *startDate = [calendar dateFromComponents:components];
    NSDate *startDate = [NSDate date];
    NSDate *endDate = [NSDate new];
    components.day = 0;
    components.month = 0;
    components.weekday = 0;
    switch (interval) {
        case MPWeek:
            [components setWeekOfMonth:-1];
            endDate = [calendar dateByAddingComponents:components toDate:startDate options:0];
            break;
        case MPMonth:
            [components setMonth:-1];
            endDate = [calendar dateByAddingComponents:components toDate:startDate options:0];
            break;
        case MPLastEarn:
            endDate = self.lastEarnDate;
            break;
        case MPAllTime:
            endDate = nil;
        default:
            break;
    }
    if (!endDate) return nil;
    return [NSPredicate predicateWithFormat:@"((trans_time >= %@) AND (trans_time < %@))",endDate,startDate];
}

- (NSArray *)getPeriodsName{
    NSArray *array = [NSArray arrayWithObjects:@"Week",
                      @"Month",@"Last Earn",@"All Time",nil];
    return array;
}

- (void)getLastEarndate{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Earning"];
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [appDelegate.coreDataBridge managedObjectContext];
    __weak typeof (self) wSelf = self;

    [context executeAsyncFetchRequest:request completion:^(NSArray *objects, NSError *error) {
        Earning *lastEarn = objects.lastObject;
        wSelf.lastEarnDate = lastEarn.earn_date;
    }];
}

@end
