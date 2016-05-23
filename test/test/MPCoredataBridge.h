//
//  MPCoredataBridge.h
//  Jewarator
//
//  Created by Michail on 23.05.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@interface MPCoredataBridge : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end
