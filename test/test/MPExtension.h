//
//  MPExtension.h
//  test
//
//  Created by Michail on 10.03.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    Food            = 0,
    Rest            = 1,
    Sport           = 2,
    Health          = 3,
    Education       = 4,
    Apartment       = 5,
    Equipment       = 6,
    Toys            = 7,
    Transport       = 8,
    Сlothes         = 9,
} MPTransactionType;

@interface MPExtension : NSObject

+ (NSArray *)getTransactionTypes;
+ (NSInteger)getTransactionCount;

@end
