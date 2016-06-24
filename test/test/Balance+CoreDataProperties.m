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
#import "Transaction+CoreDataProperties.h"
@implementation Balance (CoreDataProperties)

@dynamic amount;
@dynamic keeped;
@dynamic profit;
@dynamic loss;


- (BOOL)validateForUpdate:(NSError * _Nullable __autoreleasing *)error{
    return YES;
}


- (void)setLoss:(Transaction *)loss{
    [self willChangeValueForKey:@"amount"];
    NSNumber *currentAmount = [NSNumber numberWithFloat:([self.amount floatValue] - [loss.trans_amount floatValue])];
    [self setAmount:currentAmount];
    [self setPrimitiveValue:loss forKey:@"loss"];
    [self didChangeValueForKey:@"amount"];
}

- (void)setProfit:(Earning *)profit{
    [self willChangeValueForKey:@"profit"];
    NSNumber *currentAmount = [NSNumber numberWithFloat:([self.amount floatValue] + [profit.earn_amount floatValue])];
    [self setAmount:currentAmount];
    [self setPrimitiveValue:profit forKey:@"profit"];
    [self didChangeValueForKey:@"profit"];
}


- (void) setAmount:(NSNumber *)amount{
    [self willChangeValueForKey:@"amount"];
    [self setPrimitiveValue:amount forKey:@"amount"];
    [self didChangeValueForKey:@"amount"];
}

- (void)setKeeped:(NSNumber *)keeped{
    [self willChangeValueForKey:@"keeped"];
    NSNumber *currentAmount = [NSNumber numberWithFloat:([self.keeped floatValue] + [keeped floatValue])];
    [self setPrimitiveValue:currentAmount forKey:@"keeped"];
    [self didChangeValueForKey:@"keeped"];
}


@end
