//
//  Transaction+CoreDataProperties.m
//  test
//
//  Created by Mikhail Prysiazhniy on 19.03.16.
//  Copyright © 2016 Michail. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Transaction+CoreDataProperties.h"

@implementation Transaction (CoreDataProperties)

@dynamic trans_amount;
@dynamic trans_location;
@dynamic trans_time;
@dynamic trans_type;
@dynamic companion;
@dynamic lastSpending;

@end
