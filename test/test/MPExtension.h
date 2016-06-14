//
//  MPExtension.h
//  test
//
//  Created by Michail on 10.03.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    Products          = 0,
    Sport           = 1,
    Party           = 2,
    Kartoha         = 3,
} MPTransactionType;

@interface MPExtension : NSObject

+ (NSArray *)getTransactionTypes;
+ (NSInteger)getTransactionCount;

@end
