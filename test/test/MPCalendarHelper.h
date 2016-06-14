//
//  MPCalendarHelper.h
//  Jewarator
//
//  Created by Michail on 10.06.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    MPDay      = 0,
    MPWeek     = 1,
    MPMonth    = 2,
} MPPeriodType;

@interface MPCalendarHelper : NSObject

- (NSPredicate *)periodInterval:(MPPeriodType)interval;
- (NSArray *)getPeriodsName;

@end
