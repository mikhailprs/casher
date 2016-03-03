//
//  MPLocationManager.m
//  test
//
//  Created by Mikhail Prysiazhniy on 03.03.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "MPLocationManager.h"
#import <CoreLocation/CoreLocation.h>
@interface MPLocationManager ()

@property (strong, nonatomic)  CLLocationManager *locationManager;

@end

@implementation MPLocationManager

+ (id)sharedLocationManager{
    static MPLocationManager *sharedLocationManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedLocationManager = [[self alloc] initSingleton];
    });
    return sharedLocationManager;
}

- (id)initSingleton{
    
    return self;
}

@end
