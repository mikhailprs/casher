//
//  Balance+CoreDataProperties.h
//  test
//
//  Created by Mikhail Prysiazhniy on 19.03.16.
//  Copyright © 2016 Michail. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Balance.h"

NS_ASSUME_NONNULL_BEGIN

@interface Balance (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *amount;
@property (nullable, nonatomic, retain) NSNumber *keeped;
@property (nullable, nonatomic, retain) Earning *profit;
@property (nullable, nonatomic, retain) Transaction *loss;

@end

NS_ASSUME_NONNULL_END
