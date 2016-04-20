//
//  MPLocationManager.h
//  test
//
//  Created by Mikhail Prysiazhniy on 03.03.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^locationFinderBlock)(NSString* city, NSString* zone);
@interface MPLocationManager : NSObject

+ (id)sharedLocationManager;

@property (copy, nonatomic) locationFinderBlock locationFinder;

@property (strong, nonatomic, readonly) NSString *lastKnownStreet;

@end
