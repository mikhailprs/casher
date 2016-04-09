//
//  Earning+CoreDataProperties.m
//  test
//
//  Created by Mikhail Prysiazhniy on 19.03.16.
//  Copyright © 2016 Michail. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Earning+CoreDataProperties.h"

@implementation Earning (CoreDataProperties)

@dynamic earn_amount;
@dynamic earn_date;
@dynamic lastGain;

- (BOOL)validateForInsert:(NSError **)error{
    BOOL propertiesValid = [super validateForInsert:error];

    return propertiesValid;
}




@end
