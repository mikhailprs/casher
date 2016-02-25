//
//  Transaction+CoreDataProperties.h
//  test
//
//  Created by Michail on 25.02.16.
//  Copyright © 2016 Michail. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Transaction.h"

NS_ASSUME_NONNULL_BEGIN

@interface Transaction (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *trans_amount;
@property (nullable, nonatomic, retain) NSDate *trans_time;
@property (nullable, nonatomic, retain) NSString *trans_location;
@property (nullable, nonatomic, retain) NSNumber *trans_type;
@property (nullable, nonatomic, retain) NSSet<Companion *> *companion;

@end

@interface Transaction (CoreDataGeneratedAccessors)

- (void)addCompanionObject:(Companion *)value;
- (void)removeCompanionObject:(Companion *)value;
- (void)addCompanion:(NSSet<Companion *> *)values;
- (void)removeCompanion:(NSSet<Companion *> *)values;

@end

NS_ASSUME_NONNULL_END
