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
    NSArray *array = [NSArray arrayWithObjects:@"Food",@"Rest",@"Sport",@"Health",@"Education",@"Apartment",@"Equipment",@"Toys",@"Transport",@"Clothes",nil];
    return array;
}

+ (NSInteger)getTransactionCount{
    return 10;
}

@end