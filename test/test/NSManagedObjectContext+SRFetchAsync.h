//
//  NSManagedObjectContext+SRFetchAsync.h
//  Jewarator
//
//  Created by Michail on 13.06.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (SRFetchAsync)

- (void)executeAsyncFetchRequest:(NSFetchRequest *)request completion:(void (^)(NSArray *objects, NSError *error))completion;

@end
