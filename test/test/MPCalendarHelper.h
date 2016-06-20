//
//  MPCalendarHelper.h
//  Jewarator
//
//  Created by Michail on 10.06.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    MPWeek          = 0,
    MPMonth         = 1,
    MPLastEarn      = 2,
    MPAllTime       = 3,
} MPPeriodType;

@interface MPCalendarHelper : NSObject

- (NSPredicate *)periodInterval:(MPPeriodType)interval;
- (NSArray *)getPeriodsName;

@end
