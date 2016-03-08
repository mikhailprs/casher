//
//  MPLocationManager.m
//  test
//
//  Created by Mikhail Prysiazhniy on 03.03.16.
//  Copyright © 2016 Michail. All rights reserved.
//

#import "MPLocationManager.h"
#import <CoreLocation/CoreLocation.h>
@interface MPLocationManager () <CLLocationManagerDelegate>

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
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
    {
        [self.locationManager requestAlwaysAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    return self;
}


#pragma mark - setters and getters

- (CLLocationManager *)locationManager{
    if(!_locationManager){
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return _locationManager;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{   CLLocation *loca = [locations firstObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    __weak typeof (self) wSelf = self;
    [geoCoder reverseGeocodeLocation:loca completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark * myPlacemark = [placemarks firstObject];
        wSelf.locationFinder(myPlacemark.name,myPlacemark.subAdministrativeArea);
        [wSelf.locationManager stopUpdatingLocation];
//        NSLog(@"%@ | %@ | %@ ",myPlacemark.name,myPlacemark.subAdministrativeArea,myPlacemark.subLocality);
    }];
  
}
@end
