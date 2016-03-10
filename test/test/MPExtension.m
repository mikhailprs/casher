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
                      @"Sport",@"Party",nil];
    return array;
}

@end
