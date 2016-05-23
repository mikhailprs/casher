//
//  AppDelegate.h
//  test
//
//  Created by Michail on 25.02.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MPCoredataBridge.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic, readonly) MPCoredataBridge *coreDataBridge;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

