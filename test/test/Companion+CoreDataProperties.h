//
//  Companion+CoreDataProperties.h
//  test
//
//  Created by Michail on 25.02.16.
//  Copyright © 2016 Michail. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Companion.h"

NS_ASSUME_NONNULL_BEGIN

@interface Companion (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *comp_name;
@property (nullable, nonatomic, retain) NSDate *comp_time;
@property (nullable, nonatomic, retain) NSString *comp_location;
@property (nullable, nonatomic, retain) NSNumber *comp_debt;
@property (nullable, nonatomic, retain) NSData *comp_photo;
@property (nullable, nonatomic, retain) Transaction *impressario;

@end

NS_ASSUME_NONNULL_END
