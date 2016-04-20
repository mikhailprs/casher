//
//  NSDate+Formatter.m
//  test
//
//  Created by Mikhail Prysiazhniy on 10.04.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "NSDate+Formatter.h"

@implementation NSDate (Formatter)


- (NSString *)getFormattedGMTTime{
    static NSDateFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [NSDateFormatter new];
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        [formatter setLocale:[NSLocale currentLocale]];
        [formatter setDateFormat:@"dd/MM/YYYY HH:mm:ss' (GMT)'"];
    }
    return [formatter stringFromDate:self];
}

- (NSString *)getFormattedGMTTimeWithoutText{
    static NSDateFormatter *formatterWithoutText = nil;
    if (formatterWithoutText == nil) {
        formatterWithoutText = [NSDateFormatter new];
        [formatterWithoutText setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        [formatterWithoutText setLocale:[NSLocale currentLocale]];
        [formatterWithoutText setDateFormat:@"dd/MM/YYYY HH:mm:ss"];
    }
    return [formatterWithoutText stringFromDate:self];
}

- (NSString *)getFormattedGMTTimeWithoutYear{
    static NSDateFormatter *formatterWithoutYear = nil;
    if (formatterWithoutYear == nil) {
        formatterWithoutYear = [NSDateFormatter new];
        NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [formatterWithoutYear setCalendar:gregorianCalendar];
        [formatterWithoutYear setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        [formatterWithoutYear setLocale:[NSLocale currentLocale]];
        [formatterWithoutYear setDateFormat:@"dd/MM HH:mm"];
    }
    return [formatterWithoutYear stringFromDate:self];
}

- (NSString *)dateStringServerFormat{
    static NSDateFormatter *formatterServer = nil;
    if (formatterServer == nil) {
        formatterServer = [NSDateFormatter new];
        [formatterServer setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        [formatterServer setLocale:[NSLocale currentLocale]];
        [formatterServer setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    }
    return [formatterServer stringFromDate:self];
}




@end
