//
//  Balance+CoreDataProperties.m
//  test
//
//  Created by Mikhail Prysiazhniy on 19.03.16.
//  Copyright © 2016 Michail. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Balance+CoreDataProperties.h"
#import "Earning+CoreDataProperties.h"
@implementation Balance (CoreDataProperties)

@dynamic amount;
@dynamic keeped;
@dynamic profit;
@dynamic loss;


- (BOOL)validateForUpdate:(NSError * _Nullable __autoreleasing *)error{
    return YES;
}


- (void) setAmount:(NSNumber *)amount{
    [self willChangeValueForKey:@"amount"];
    
    [self setPrimitiveValue:amount forKey:@"amount"];
    [self didChangeValueForKey:@"amount"];
}
@end
