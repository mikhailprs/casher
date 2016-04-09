//
//  Earning+CoreDataProperties.h
//  test
//
//  Created by Mikhail Prysiazhniy on 19.03.16.
//  Copyright © 2016 Michail. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Earning.h"

NS_ASSUME_NONNULL_BEGIN

@interface Earning (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *earn_amount;
@property (nullable, nonatomic, retain) NSDate *earn_date;
@property (nullable, nonatomic, retain) Balance *lastGain;

@end

NS_ASSUME_NONNULL_END
