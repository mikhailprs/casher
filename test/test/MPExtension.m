//
//  MPExtension.m
//  test
//
//  Created by Michail on 10.03.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "MPExtension.h"

@implementation MPExtension

+ (NSArray *)getTransactionTypes{
    NSArray *array = [NSArray arrayWithObjects:@"Products",
                      @"Sport",@"Party",@"Kartoha",nil];
    return array;
}

+ (NSInteger)getTransactionCount{
    return 4;
}

@end
